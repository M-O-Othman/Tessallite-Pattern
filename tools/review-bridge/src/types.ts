export interface RoundRecord {
  round_number: number;
  timestamp: string;
  plan_file: string;
  review_file: string;
  fixes_file: string | null;
  status: "review_submitted" | "approved" | "fixes_submitted" | "completed" | "stopped";
  summary: string;
  severity_counts: SeverityCounts;
}

export interface SeverityCounts {
  critical: number;
  high: number;
  medium: number;
  low: number;
  info: number;
}

export interface BridgeState {
  project_root: string;
  current_round: number;
  rounds: RoundRecord[];
  active: boolean;
}

export interface ReviewSubmission {
  plan_file: string;
  review_content: string;
  summary: string;
  severity_counts: SeverityCounts;
}

export interface FixesSubmission {
  fixes_applied: string[];
  fixes_skipped: SkippedFix[];
  remaining_issues: string[];
}

export interface SkippedFix {
  issue: string;
  reason: string;
}
