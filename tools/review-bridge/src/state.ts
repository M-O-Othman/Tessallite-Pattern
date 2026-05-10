import fs from "node:fs";
import path from "node:path";
import type { BridgeState, RoundRecord, ReviewSubmission, FixesSubmission } from "./types.js";

const BRIDGE_DIR = "work/external-review";
const ROUNDS_DIR = "work/external-review/rounds";
const STATE_FILE = "work/external-review/bridge-state.json";

export class StateManager {
  private state: BridgeState;
  private projectRoot: string;

  constructor(projectRoot: string) {
    this.projectRoot = projectRoot;
    this.ensureDirectories();
    this.state = this.loadState();
  }

  private resolve(relativePath: string): string {
    return path.join(this.projectRoot, relativePath);
  }

  private ensureDirectories(): void {
    const dirs = [this.resolve(BRIDGE_DIR), this.resolve(ROUNDS_DIR)];
    for (const dir of dirs) {
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
      }
    }
  }

  private loadState(): BridgeState {
    const stateFile = this.resolve(STATE_FILE);
    if (fs.existsSync(stateFile)) {
      const raw = fs.readFileSync(stateFile, "utf-8");
      return JSON.parse(raw) as BridgeState;
    }
    return {
      project_root: this.projectRoot,
      current_round: 0,
      rounds: [],
      active: false,
    };
  }

  private saveState(): void {
    const stateFile = this.resolve(STATE_FILE);
    fs.writeFileSync(stateFile, JSON.stringify(this.state, null, 2), "utf-8");
  }

  getState(): BridgeState {
    return { ...this.state };
  }

  getCurrentRound(): RoundRecord | null {
    if (this.state.rounds.length === 0) return null;
    return this.state.rounds[this.state.rounds.length - 1];
  }

  getPlanContent(planFile: string): string {
    const resolved = path.isAbsolute(planFile)
      ? planFile
      : this.resolve(planFile);
    if (!fs.existsSync(resolved)) {
      throw new Error(`Plan file not found: ${resolved}`);
    }
    return fs.readFileSync(resolved, "utf-8");
  }

  submitReview(submission: ReviewSubmission): RoundRecord {
    this.state.current_round += 1;
    const roundNum = this.state.current_round;
    const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
    const reviewFileName = `round-${String(roundNum).padStart(3, "0")}-${timestamp}-review.md`;
    const reviewFilePath = path.join(ROUNDS_DIR, reviewFileName);

    fs.writeFileSync(this.resolve(reviewFilePath), submission.review_content, "utf-8");

    // Also write to the canonical location for easy access
    fs.writeFileSync(
      this.resolve(path.join(BRIDGE_DIR, "review-report.md")),
      submission.review_content,
      "utf-8"
    );

    const record: RoundRecord = {
      round_number: roundNum,
      timestamp: new Date().toISOString(),
      plan_file: submission.plan_file,
      review_file: reviewFilePath,
      fixes_file: null,
      status: "review_submitted",
      summary: submission.summary,
      severity_counts: submission.severity_counts,
    };

    this.state.rounds.push(record);
    this.state.active = true;
    this.saveState();
    return record;
  }

  approveRound(): RoundRecord {
    const current = this.getCurrentRound();
    if (!current) throw new Error("No active round to approve.");
    if (current.status !== "review_submitted") {
      throw new Error(`Round ${current.round_number} is in status '${current.status}', expected 'review_submitted'.`);
    }
    current.status = "approved";
    this.saveState();
    return current;
  }

  getLatestReview(): { record: RoundRecord; content: string } {
    const current = this.getCurrentRound();
    if (!current) throw new Error("No review rounds exist yet.");
    const content = fs.readFileSync(this.resolve(current.review_file), "utf-8");
    return { record: current, content };
  }

  submitFixes(submission: FixesSubmission): RoundRecord {
    const current = this.getCurrentRound();
    if (!current) throw new Error("No active round.");
    if (current.status !== "approved") {
      throw new Error(`Round ${current.round_number} is in status '${current.status}', expected 'approved'.`);
    }

    const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
    const fixesFileName = `round-${String(current.round_number).padStart(3, "0")}-${timestamp}-fixes.md`;
    const fixesFilePath = path.join(ROUNDS_DIR, fixesFileName);

    const fixesContent = this.formatFixesReport(submission, current.round_number);
    fs.writeFileSync(this.resolve(fixesFilePath), fixesContent, "utf-8");

    current.fixes_file = fixesFilePath;
    current.status = submission.remaining_issues.length > 0 ? "completed" : "completed";
    this.saveState();
    return current;
  }

  stopBridge(): BridgeState {
    this.state.active = false;
    const current = this.getCurrentRound();
    if (current && (current.status === "review_submitted" || current.status === "approved")) {
      current.status = "stopped";
    }
    this.saveState();
    return this.state;
  }

  getSeverityTrend(): Array<{ round: number; counts: RoundRecord["severity_counts"] }> {
    return this.state.rounds.map((r) => ({
      round: r.round_number,
      counts: r.severity_counts,
    }));
  }

  private formatFixesReport(submission: FixesSubmission, roundNum: number): string {
    const lines: string[] = [
      `# Fixes Report - Round ${roundNum}`,
      ``,
      `Generated: ${new Date().toISOString()}`,
      ``,
      `## Applied Fixes`,
      ``,
    ];

    if (submission.fixes_applied.length === 0) {
      lines.push("None.");
    } else {
      for (const fix of submission.fixes_applied) {
        lines.push(`- ${fix}`);
      }
    }

    lines.push("", "## Skipped Fixes", "");
    if (submission.fixes_skipped.length === 0) {
      lines.push("None.");
    } else {
      for (const skip of submission.fixes_skipped) {
        lines.push(`- ${skip.issue}: ${skip.reason}`);
      }
    }

    lines.push("", "## Remaining Issues", "");
    if (submission.remaining_issues.length === 0) {
      lines.push("None.");
    } else {
      for (const issue of submission.remaining_issues) {
        lines.push(`- ${issue}`);
      }
    }

    return lines.join("\n");
  }
}
