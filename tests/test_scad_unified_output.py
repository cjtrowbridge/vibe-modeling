import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = REPO_ROOT / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

import scad_build  # noqa: E402
import scad_build_all  # noqa: E402
import scad_render_assembly_review as assembly_review  # noqa: E402


def record(path: Path) -> dict:
    return {
        "path": path.name,
        "bytes": path.stat().st_size,
        "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
    }


class UnifiedOutputTests(unittest.TestCase):
    def test_mutable_staging_is_allowed_only_inside_design_output(self):
        accepted = scad_build.validate_output_directory(
            REPO_ROOT / "output" / "example_box" / ".build-stage-test",
            "example_box",
        )
        self.assertEqual(
            accepted,
            (REPO_ROOT / "output" / "example_box" / ".build-stage-test").resolve(),
        )
        with self.assertRaises(SystemExit):
            scad_build.validate_output_directory(
                REPO_ROOT / ".tmp" / "scad" / "example_box" / "stage",
                "example_box",
            )
        self.assertEqual(
            assembly_review.validate_build_directory(
                REPO_ROOT / "output" / "example_box", "example_box"
            ),
            (REPO_ROOT / "output" / "example_box").resolve(),
        )
        with self.assertRaises(SystemExit):
            assembly_review.validate_build_directory(
                REPO_ROOT / "output" / "somewhere_else", "example_box"
            )

    def test_unified_manifest_union_is_the_only_valid_flat_set(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary) / "design output with spaces"
            root.mkdir()
            printable = root / "left.stl"
            combined = root / "assembled.stl"
            printable.write_bytes(b"printable")
            combined.write_bytes(b"combined")
            build_manifest = {"artifacts": [record(printable)]}
            assembly_manifest = {
                "schema_version": 1,
                "artifacts": [record(combined)],
            }
            (root / scad_build_all.BUILD_MANIFEST_NAME).write_text(
                json.dumps(build_manifest), encoding="utf-8"
            )
            (root / scad_build_all.ASSEMBLY_MANIFEST_NAME).write_text(
                json.dumps(assembly_manifest), encoding="utf-8"
            )

            expected = scad_build_all.unified_expected_names(root, build_manifest)
            scad_build_all.validate_exact_artifacts(root, expected)
            self.assertEqual(
                expected,
                {
                    "left.stl",
                    "assembled.stl",
                    scad_build_all.BUILD_MANIFEST_NAME,
                    scad_build_all.ASSEMBLY_MANIFEST_NAME,
                },
            )

            (root / "stale.png").write_bytes(b"stale")
            with self.assertRaises(SystemExit):
                scad_build_all.validate_exact_artifacts(root, expected)

            (root / "stale.png").unlink()
            assembly_manifest["artifacts"] = [record(printable)]
            (root / scad_build_all.ASSEMBLY_MANIFEST_NAME).write_text(
                json.dumps(assembly_manifest), encoding="utf-8"
            )
            with self.assertRaises(SystemExit):
                scad_build_all.unified_expected_names(root, build_manifest)

    def test_hash_mismatch_and_leftover_directory_fail_closed(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            artifact = root / "part.stl"
            artifact.write_bytes(b"original")
            manifest = {"artifacts": [record(artifact)]}
            artifact.write_bytes(b"tampered")
            with self.assertRaises(SystemExit):
                scad_build_all.recorded_artifact_names_and_validate(
                    root, manifest, "test manifest"
                )

            artifact.write_bytes(b"original")
            (root / "leftover-stage").mkdir()
            with self.assertRaises(SystemExit):
                scad_build_all.validate_exact_artifacts(root, {"part.stl"})

    def test_review_install_can_roll_back_without_touching_printable_files(self):
        with tempfile.TemporaryDirectory() as temporary:
            final = Path(temporary)
            printable = final / "left.stl"
            printable.write_bytes(b"printable")
            old = final / "assembled.stl"
            old.write_bytes(b"old")
            old_manifest = {
                "schema_version": 1,
                "artifacts": [record(old)],
            }
            (final / assembly_review.MANIFEST_NAME).write_text(
                json.dumps(old_manifest), encoding="utf-8"
            )

            stage = final / ".assembly-stage-test"
            stage.mkdir()
            new = stage / "assembled.stl"
            new.write_bytes(b"new")
            new_manifest = stage / assembly_review.MANIFEST_NAME
            new_manifest.write_text("{}", encoding="utf-8")
            names = {"assembled.stl", assembly_review.MANIFEST_NAME}

            backup = assembly_review.install_review_set(stage, final, names)
            self.assertEqual((final / "assembled.stl").read_bytes(), b"new")
            assembly_review.rollback_review_set(final, backup, names)
            self.assertEqual((final / "assembled.stl").read_bytes(), b"old")
            self.assertEqual(printable.read_bytes(), b"printable")

    def test_complete_build_promotion_can_restore_previous_output(self):
        with tempfile.TemporaryDirectory() as temporary:
            final = Path(temporary)
            previous = final / "previous.stl"
            previous.write_bytes(b"previous")
            stage_root = final / ".build-stage-test"
            staged = stage_root / "artifacts"
            staged.mkdir(parents=True)
            (staged / "replacement.stl").write_bytes(b"replacement")

            backup = scad_build_all.install_artifacts(staged, final, stage_root)
            self.assertFalse(previous.exists())
            self.assertEqual((final / "replacement.stl").read_bytes(), b"replacement")
            scad_build_all.rollback_install(final, stage_root, backup)
            self.assertEqual(previous.read_bytes(), b"previous")
            self.assertFalse((final / "replacement.stl").exists())


if __name__ == "__main__":
    unittest.main()
