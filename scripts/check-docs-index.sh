#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs"

if [[ ! -d "$DOCS_DIR" ]]; then
  echo "docs directory not found: $DOCS_DIR" >&2
  exit 1
fi

failures=0

for domain_dir in "$DOCS_DIR"/*; do
  [[ -d "$domain_dir" ]] || continue

  domain_name="$(basename "$domain_dir")"
  index_file="$domain_dir/_INDEX.md"

  if [[ ! -f "$index_file" ]]; then
    echo "missing index: docs/$domain_name/_INDEX.md" >&2
    failures=$((failures + 1))
    continue
  fi

  while IFS= read -r -d '' doc_file; do
    file_name="$(basename "$doc_file")"
    [[ "$file_name" == "_INDEX.md" ]] && continue

    relative_path="${doc_file#"$domain_dir"/}"

    if ! grep -Fq "$relative_path" "$index_file"; then
      echo "missing index entry: docs/$domain_name/$relative_path is not listed in docs/$domain_name/_INDEX.md" >&2
      failures=$((failures + 1))
    fi
  done < <(find "$domain_dir" -type f -name "*.md" -print0)
done

while IFS= read -r -d '' nested_index; do
  nested_dir="$(dirname "$nested_index")"
  [[ "$nested_dir" == "$DOCS_DIR" ]] && continue
  [[ "$(dirname "$nested_dir")" == "$DOCS_DIR" ]] && continue

  display_index="${nested_index#"$ROOT_DIR"/}"

  while IFS= read -r -d '' doc_file; do
    file_name="$(basename "$doc_file")"
    [[ "$file_name" == "_INDEX.md" ]] && continue

    display_file="${doc_file#"$ROOT_DIR"/}"

    if ! grep -Fq "$file_name" "$nested_index"; then
      echo "missing nested index entry: $display_file is not listed in $display_index" >&2
      failures=$((failures + 1))
    fi
  done < <(find "$nested_dir" -maxdepth 1 -type f -name "*.md" -print0)
done < <(find "$DOCS_DIR" -mindepth 2 -type f -name "_INDEX.md" -print0)

if [[ "$failures" -gt 0 ]]; then
  echo "documentation index check failed with $failures issue(s)" >&2
  exit 1
fi

echo "documentation index check passed"
