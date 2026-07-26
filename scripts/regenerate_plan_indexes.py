#!/usr/bin/env python3
"""Validate host plan files and generate deterministic lifecycle indexes."""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

STATUSES = ("future", "current", "past")
REQUIRED_KEYS = ("plan_id", "title", "summary", "status", "created_at")
TIMESTAMP_FORMAT = "%Y-%m-%d-%H-%M-%S"
TIMESTAMP_PATTERN = re.compile(r"^\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}$")
FILENAME_PATTERN = re.compile(
    r"^(?P<timestamp>\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2})_"
    r"(?P<slug>[a-z0-9]+(?:-[a-z0-9]+)*)\.md$"
)
KEY_LINE = "Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task"


@dataclass(frozen=True)
class PlanEntry:
    status: str
    rel_path: str
    title: str
    summary: str
    created_at: datetime

    @property
    def created_at_label(self) -> str:
        return self.created_at.strftime(TIMESTAMP_FORMAT)


def parse_front_matter(path: Path) -> tuple[dict[str, str], list[str]]:
    lines = path.read_text(encoding="utf-8").splitlines()
    if len(lines) < 3 or lines[0].strip() != "---":
        raise ValueError("missing YAML front matter delimiters")

    try:
        end_index = next(i for i, line in enumerate(lines[1:], start=1) if line.strip() == "---")
    except StopIteration as exc:
        raise ValueError("missing closing YAML front matter delimiter") from exc

    metadata: dict[str, str] = {}
    for raw in lines[1:end_index]:
        if not raw.strip():
            continue
        if ":" not in raw:
            raise ValueError(f"invalid front matter line: {raw}")
        key, value = raw.split(":", 1)
        key = key.strip()
        if not key or key in metadata:
            raise ValueError(f"invalid or duplicate front matter key: {key!r}")
        metadata[key] = value.strip().strip('"').strip("'")

    return metadata, lines[end_index + 1 :]


def collect_plans(repo_root: Path) -> tuple[list[PlanEntry], list[str]]:
    entries: list[PlanEntry] = []
    errors: list[str] = []
    seen_ids: dict[str, str] = {}

    for status in STATUSES:
        status_dir = repo_root / "plans" / status
        if not status_dir.is_dir():
            errors.append(f"missing plans directory: {status_dir}")
            continue

        for path in sorted(status_dir.glob("*.md")):
            if path.name == "index.md":
                continue

            rel_path = path.relative_to(repo_root).as_posix()
            if not FILENAME_PATTERN.match(path.name):
                errors.append(f"{rel_path}: invalid plan filename")
                continue

            try:
                metadata, body = parse_front_matter(path)
            except ValueError as exc:
                errors.append(f"{rel_path}: {exc}")
                continue

            missing = [key for key in REQUIRED_KEYS if key not in metadata]
            if missing:
                errors.append(f"{rel_path}: missing keys: {', '.join(missing)}")
                continue

            plan_id = metadata["plan_id"]
            if plan_id != path.stem:
                errors.append(f"{rel_path}: plan_id must match filename stem")
            if plan_id in seen_ids:
                errors.append(f"{rel_path}: duplicate plan_id also used by {seen_ids[plan_id]}")
            else:
                seen_ids[plan_id] = rel_path

            if metadata["status"] != status:
                errors.append(f"{rel_path}: status must match plans/{status}/")

            created_at_value = metadata["created_at"]
            if not TIMESTAMP_PATTERN.match(created_at_value):
                errors.append(f"{rel_path}: invalid created_at timestamp")
                continue
            try:
                created_at = datetime.strptime(created_at_value, TIMESTAMP_FORMAT)
            except ValueError:
                errors.append(f"{rel_path}: invalid created_at timestamp")
                continue

            if KEY_LINE not in "\n".join(body):
                errors.append(f"{rel_path}: missing required key line")

            entries.append(
                PlanEntry(
                    status=status,
                    rel_path=rel_path,
                    title=metadata["title"],
                    summary=metadata["summary"],
                    created_at=created_at,
                )
            )

    return entries, errors


def render_index(status: str, entries: list[PlanEntry]) -> str:
    lines = [
        f"# {status.capitalize()} Plans Index",
        "",
        "Format: `created_at | path | title | summary`",
        "",
    ]
    for entry in entries:
        lines.append(
            f"{entry.created_at_label} | {entry.rel_path} | {entry.title} | {entry.summary}"
        )
    return "\n".join(lines).rstrip() + "\n"


def write_atomic(path: Path, content: str) -> None:
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(content, encoding="utf-8", newline="\n")
    temporary.replace(path)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Validate plans and generate deterministic lifecycle indexes."
    )
    parser.add_argument("--check", action="store_true", help="Check without writing indexes.")
    parser.add_argument("--repo-root", default=None, help="Repository root containing plans/.")
    args = parser.parse_args()

    repo_root = Path(args.repo_root).resolve() if args.repo_root else Path(__file__).resolve().parents[1]
    entries, errors = collect_plans(repo_root)
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    by_status = {status: [] for status in STATUSES}
    for entry in entries:
        by_status[entry.status].append(entry)
    for status in STATUSES:
        by_status[status].sort(key=lambda entry: (-entry.created_at.timestamp(), entry.rel_path))

    outdated = 0
    for status in STATUSES:
        path = repo_root / "plans" / status / "index.md"
        rendered = render_index(status, by_status[status])
        if args.check:
            current = path.read_text(encoding="utf-8") if path.exists() else ""
            if current != rendered:
                print(f"OUTDATED: {path.relative_to(repo_root).as_posix()}")
                outdated += 1
        else:
            write_atomic(path, rendered)
            print(f"UPDATED: {path.relative_to(repo_root).as_posix()}")

    return 1 if outdated else 0


if __name__ == "__main__":
    raise SystemExit(main())
