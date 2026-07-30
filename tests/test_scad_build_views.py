import sys
import unittest
from pathlib import Path


SCRIPTS = Path(__file__).resolve().parents[1] / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

import scad_build  # noqa: E402


class ScadBuildViewTests(unittest.TestCase):
    def test_governed_views_include_auto_framed_inside_bottom_views(self):
        presets = {preset.suffix: preset for preset in scad_build.PNG_VIEW_PRESETS}

        self.assertEqual(len(presets), 16)
        for name in ("inspect_inside_bottom_iso", "inspect_inside_bottom_ortho"):
            with self.subTest(name=name):
                self.assertIn(name, presets)
                self.assertTrue(presets[name].autocenter)
                self.assertTrue(presets[name].viewall)
                self.assertEqual(presets[name].target, (0.0, 0.0, 0.0))


if __name__ == "__main__":
    unittest.main()
