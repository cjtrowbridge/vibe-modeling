# Playbook: Use Downtime to Improve the Framework

*Status: Stable*

## Objective

Use optional maintenance time for evidence-based, report-only framework review.

## Rules

- A downtime task may inspect but may not directly change framework files.
- Write one report to `downtime/reports/pending/` using
  `templates/downtime_report.md`.
- Name reports `<task>.<YYYY-MM-DD-HH-mm-ss>.report.md`.
- Record comprehensive recommendations, affected files, risks, and verification.
- Implementation requires a separate approved active plan.

## Verification

- Only the pending report was created during the downtime run.
- The report distinguishes observations from proposed changes.
- The user is told which report awaits review.
