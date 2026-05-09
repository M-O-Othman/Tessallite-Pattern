#!/usr/bin/env node

const childProcess = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");

const repoRoot = path.resolve(__dirname, "..");
const outDir = path.join(repoRoot, "walk-through", "illustrations");
const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "tessallite-walkthrough-"));

fs.mkdirSync(outDir, { recursive: true });

const palette = {
  green: "#006C35",
  gold: "#D4AF37",
  charcoal: "#333333",
  white: "#FFFFFF",
  mint: "#F2F7F4",
  gray: "#8A94A6",
  border: "#CBD5E1",
};

const steps = [
  {
    file: "01-create-project-directory.png",
    eyebrow: "Step 1",
    title: "Create a project directory in macOS Terminal",
    badge: "macOS",
    path: "~/Projects",
    lines: [
      ["ava@MacBook-Pro Projects % mkdir tessallite-demo", "command"],
      ["ava@MacBook-Pro Projects % ls", "command"],
      ["tessallite-demo/", "output"],
      ["", ""],
      ["# Start from a normal macOS Terminal window. The project name can be changed.", "note"],
    ],
  },
  {
    file: "02-change-directory.png",
    eyebrow: "Step 2",
    title: "Change into the project root and initialize git",
    badge: "Shell",
    path: "~/Projects/tessallite-demo",
    lines: [
      ["ava@MacBook-Pro Projects % cd tessallite-demo", "command"],
      ["ava@MacBook-Pro tessallite-demo % pwd", "command"],
      ["/Users/ava/Projects/tessallite-demo", "output"],
      ["ava@MacBook-Pro tessallite-demo % git init", "command"],
      ["Initialized empty Git repository in /Users/ava/Projects/tessallite-demo/.git/", "output"],
      ["", ""],
      ["# Keep all later agent actions scoped to this project root.", "note"],
    ],
  },
  {
    file: "03-copy-greenfield-prompt-files.png",
    eyebrow: "Step 3",
    title: "Copy the greenfield prompt files into the project",
    badge: "Files",
    path: "~/Projects/tessallite-demo",
    lines: [
      ["ava@MacBook-Pro tessallite-demo % KIT=~/Projects/Tessallite-Pattern/docs/tessallite-pattern/prompts", "command"],
      ["ava@MacBook-Pro tessallite-demo % cp \"$KIT/agent-memory-instructions.md\" .", "command"],
      ["ava@MacBook-Pro tessallite-demo % cp \"$KIT/bootstrap-greenfield-project-prompt.md\" .", "command"],
      ["", ""],
      ["# These files must be present before Codex starts the bootstrap.", "note"],
      ["# Adjust ~/Projects/Tessallite-Pattern if your kit is stored elsewhere.", "note"],
    ],
  },
  {
    file: "04-verify-prompt-files.png",
    eyebrow: "Step 4",
    title: "Verify the prompt files before opening Codex",
    badge: "Check",
    path: "~/Projects/tessallite-demo",
    lines: [
      ["ava@MacBook-Pro tessallite-demo % ls", "command"],
      ["agent-memory-instructions.md", "output"],
      ["bootstrap-greenfield-project-prompt.md", "output"],
      ["", ""],
      ["ava@MacBook-Pro tessallite-demo % sed -n '25,40p' bootstrap-greenfield-project-prompt.md", "command"],
      ["## Prompt To Paste Into The Agent Chat", "output"],
      ["You are helping bootstrap a new greenfield software project using the Tessallite Pattern.", "output"],
    ],
  },
  {
    file: "05-open-codex-from-project-root.png",
    eyebrow: "Step 5",
    title: "Open Codex from the project root",
    badge: "Codex",
    path: "~/Projects/tessallite-demo",
    lines: [
      ["ava@MacBook-Pro tessallite-demo % codex", "command"],
      ["", ""],
      ["Codex CLI", "agent"],
      ["Workspace: /Users/ava/Projects/tessallite-demo", "output"],
      ["Git: repository initialized, no commits yet", "output"],
      ["", ""],
      ["# Claude Code alternative from the same directory: claude", "note"],
    ],
  },
  {
    file: "06-instruct-codex-to-run-bootstrap.png",
    eyebrow: "Step 6",
    title: "Tell Codex to follow the bootstrap prompt",
    badge: "Prompt",
    path: "Codex · tessallite-demo",
    lines: [
      ["You:", "question"],
      ["Read bootstrap-greenfield-project-prompt.md and follow it exactly.", "command"],
      ["Read agent-memory-instructions.md when the prompt asks for it.", "command"],
      ["Install project memory first, create only the bootstrap docs structure,", "command"],
      ["ask me the initial product questions, and do not write application code.", "command"],
      ["", ""],
      ["Codex:", "agent"],
      ["I will inspect those two files, install persistent memory, create the minimum documentation structure, then stop at the initial questions.", "output"],
    ],
  },
  {
    file: "07-install-agent-memory.png",
    eyebrow: "Step 7",
    title: "Codex installs persistent project memory",
    badge: "AGENTS.md",
    path: "Codex · tessallite-demo",
    lines: [
      ["Codex:", "agent"],
      ["Reading agent-memory-instructions.md", "output"],
      ["Creating AGENTS.md with Tessallite Pattern working rules", "output"],
      ["", ""],
      ["Created:", "section"],
      ["AGENTS.md", "output"],
      ["", ""],
      ["Key rules installed:", "section"],
      ["- Optimize for verification, not generation.", "output"],
      ["- Read docs/_INDEX.md first unless the exact path is known.", "output"],
      ["- Produce requirements before design.", "output"],
    ],
  },
  {
    file: "08-create-docs-structure.png",
    eyebrow: "Step 8",
    title: "Codex creates the documentation and log structure",
    badge: "Structure",
    path: "Codex · tessallite-demo",
    lines: [
      ["Codex:", "agent"],
      ["Creating minimum Tessallite Pattern directories and indexes", "output"],
      ["", ""],
      ["Created:", "section"],
      ["docs/_INDEX.md", "output"],
      ["docs/architecture/_INDEX.md", "output"],
      ["docs/questions/_INDEX.md", "output"],
      ["docs/execution/_INDEX.md", "output"],
      ["docs/guides/_INDEX.md", "output"],
      ["docs/strategy/_INDEX.md", "output"],
      ["docs/archive/_INDEX.md", "output"],
      ["work/logs/project-journal.md", "output"],
      ["work/sessions/", "output"],
      ["scripts/check-docs-index.sh", "output"],
    ],
  },
  {
    file: "09-create-starter-documents.png",
    eyebrow: "Step 9",
    title: "Codex creates starter project documents",
    badge: "L1/L2",
    path: "Codex · tessallite-demo",
    lines: [
      ["Codex:", "agent"],
      ["Creating starter documents and updating each domain index", "output"],
      ["", ""],
      ["Created:", "section"],
      ["docs/architecture/architecture_project-overview.md", "output"],
      ["docs/questions/questions_initial-project.md", "output"],
      ["docs/execution/execution_issue-registry.md", "output"],
      ["docs/guides/guides_developer-guide.md", "output"],
      ["work/logs/project-journal.md", "output"],
      ["", ""],
      ["No application source files created.", "question"],
    ],
  },
  {
    file: "10-codex-asks-initial-product-questions.png",
    eyebrow: "Step 10",
    title: "Codex asks the initial product questions",
    badge: "Questions",
    path: "Codex · tessallite-demo",
    lines: [
      ["Codex:", "agent"],
      ["I need the minimum information to define the greenfield project:", "output"],
      ["", ""],
      ["1. Product goal?", "question"],
      ["2. Primary users?", "question"],
      ["3. Core workflows?", "question"],
      ["4. Target stack?", "question"],
      ["5. External systems?", "question"],
      ["6. Non-goals?", "question"],
      ["7. Initial delivery milestone?", "question"],
      ["", ""],
      ["# Concrete answers prevent the model from filling product gaps with guesses.", "note"],
    ],
  },
  {
    file: "11-answer-initial-product-questions.png",
    eyebrow: "Step 11",
    title: "Answer the initial product questions in Codex",
    badge: "Architect",
    path: "Codex · tessallite-demo",
    lines: [
      ["You:", "question"],
      ["Product goal: internal task tracker for launch work.", "command"],
      ["Primary users: project lead, developer, reviewer.", "command"],
      ["Core workflows: create task, assign owner, review status, close task.", "command"],
      ["Target stack: TypeScript, SQLite, simple web UI.", "command"],
      ["External systems: none for the first milestone.", "command"],
      ["Non-goals: mobile app, SSO, notifications.", "command"],
      ["Initial milestone: local CRUD workflow with tests and docs.", "command"],
    ],
  },
  {
    file: "12-record-answers-and-stop-before-code.png",
    eyebrow: "Step 12",
    title: "Codex records answers and stops before code",
    badge: "Gate",
    path: "Codex · tessallite-demo",
    lines: [
      ["Codex:", "agent"],
      ["Updated docs/questions/questions_initial-project.md", "output"],
      ["Updated docs/architecture/architecture_project-overview.md", "output"],
      ["Updated work/logs/project-journal.md", "output"],
      ["Ran scripts/check-docs-index.sh: passed", "output"],
      ["", ""],
      ["Stopped before writing application code.", "question"],
      ["", ""],
      ["Next: run requirements-authoring-prompt.md, then the first open-questions gate.", "section"],
    ],
  },
];

function escapeHtml(value) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}

function renderLines(lines) {
  return lines
    .map(([text, kind]) => {
      if (!text) {
        return '<div class="line empty">&nbsp;</div>';
      }
      return `<div class="line ${kind}">${escapeHtml(text)}</div>`;
    })
    .join("\n");
}

function htmlFor(step) {
  return `<!doctype html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; }
  html, body { margin: 0; width: 1200px; height: 760px; overflow: hidden; }
  body {
    background:
      linear-gradient(135deg, ${palette.mint} 0%, #ffffff 48%, #eef6f1 100%);
    color: ${palette.charcoal};
    font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  }
  .stage {
    width: 1200px;
    height: 760px;
    padding: 54px 72px;
    position: relative;
  }
  .accent {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 12px;
    background: linear-gradient(90deg, ${palette.green}, ${palette.gold});
  }
  .header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 28px;
  }
  .eyebrow {
    color: ${palette.green};
    font-size: 18px;
    font-weight: 800;
    letter-spacing: 0;
    margin-bottom: 8px;
  }
  h1 {
    margin: 0;
    font-size: 38px;
    line-height: 1.12;
    letter-spacing: 0;
    max-width: 760px;
  }
  .badge {
    border: 2px solid ${palette.gold};
    color: ${palette.green};
    background: ${palette.white};
    border-radius: 6px;
    padding: 9px 14px;
    font-weight: 800;
    font-size: 16px;
  }
  .terminal {
    border-radius: 8px;
    border: 1px solid #1f2937;
    overflow: hidden;
    box-shadow: 0 22px 60px rgba(51, 51, 51, 0.22);
    background: #101513;
  }
  .titlebar {
    height: 46px;
    background: ${palette.charcoal};
    color: ${palette.white};
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 18px;
    font-size: 14px;
    border-bottom: 3px solid ${palette.gold};
  }
  .traffic {
    display: flex;
    gap: 8px;
    align-items: center;
  }
  .dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: ${palette.gray};
  }
  .dot:nth-child(1) { background: #ff5f56; }
  .dot:nth-child(2) { background: ${palette.gold}; }
  .dot:nth-child(3) { background: ${palette.green}; }
  .path {
    color: #dfe7e1;
    font-weight: 700;
  }
  .screen {
    min-height: 472px;
    padding: 26px 30px 30px;
    font-family: "SFMono-Regular", "Cascadia Code", "Liberation Mono", Menlo, Consolas, monospace;
    font-size: 21px;
    line-height: 1.36;
    letter-spacing: 0;
  }
  .line { white-space: pre-wrap; color: #f8fafc; }
  .empty { line-height: 0.75; }
  .command { color: ${palette.white}; }
  .command::first-letter { color: ${palette.gold}; }
  .output { color: #d9eadf; }
  .agent { color: #9ee4bb; }
  .question { color: ${palette.gold}; }
  .section { color: ${palette.gold}; font-weight: 800; }
  .note { color: #a9b8ad; }
  .footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 24px;
    color: ${palette.gray};
    font-size: 16px;
  }
  .brand {
    color: ${palette.green};
    font-weight: 900;
  }
  .rule {
    height: 3px;
    width: 180px;
    background: ${palette.gold};
  }
</style>
</head>
<body>
  <main class="stage">
    <div class="accent"></div>
    <section class="header">
      <div>
        <div class="eyebrow">${escapeHtml(step.eyebrow)}</div>
        <h1>${escapeHtml(step.title)}</h1>
      </div>
      <div class="badge">${escapeHtml(step.badge)}</div>
    </section>
    <section class="terminal" aria-label="${escapeHtml(step.title)}">
      <div class="titlebar">
        <div class="traffic"><span class="dot"></span><span class="dot"></span><span class="dot"></span></div>
        <div class="path">${escapeHtml(step.path || "~/Projects/tessallite-demo")}</div>
        <div>120 x 36</div>
      </div>
      <div class="screen">
        ${renderLines(step.lines)}
      </div>
    </section>
    <section class="footer">
      <div><span class="brand">Tessallite Pattern</span> greenfield walkthrough</div>
      <div class="rule"></div>
    </section>
  </main>
</body>
</html>`;
}

function chromePath() {
  const candidates = ["google-chrome", "chromium", "chromium-browser"];
  for (const candidate of candidates) {
    try {
      const resolved = childProcess.execFileSync("command", ["-v", candidate], {
        encoding: "utf8",
        shell: true,
        stdio: ["ignore", "pipe", "ignore"],
      }).trim();
      if (resolved) return resolved;
    } catch (_) {
      // Try the next candidate.
    }
  }
  throw new Error("No headless Chrome/Chromium binary found.");
}

const chrome = chromePath();

for (const step of steps) {
  const htmlPath = path.join(tmpDir, step.file.replace(/\.png$/, ".html"));
  const outPath = path.join(outDir, step.file);
  fs.writeFileSync(htmlPath, htmlFor(step), "utf8");
  childProcess.execFileSync(chrome, [
    "--headless=new",
    "--disable-gpu",
    "--no-sandbox",
    "--hide-scrollbars",
    "--force-device-scale-factor=1",
    "--window-size=1200,760",
    `--screenshot=${outPath}`,
    `file://${htmlPath}`,
  ], { stdio: "ignore" });
  console.log(`wrote ${path.relative(repoRoot, outPath)}`);
}
