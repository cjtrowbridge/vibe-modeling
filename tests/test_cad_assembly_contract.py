import copy
import sys
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / "scripts"))

import scad_render_assembly_review as review  # noqa: E402
import validate_cad_assembly_contract as contract  # noqa: E402


ZERO = {"translate": [0, 0, 0], "rotate": [0, 0, 0]}


def valid_contract():
    parts = {
        1: "skeleton_left",
        2: "skeleton_right",
        3: "pi_module",
        4: "display_module",
        5: "control_module",
    }
    data = {
        "schema_version": 1,
        "primary_assembly": "product",
        "review_dispatch_id": 90,
        "assemblies": [
            {
                "assembly_id": "product",
                "role": "product",
                "members": [
                    {"assembly_id": "skeleton", "transform": ZERO},
                    {"assembly_id": "display", "transform": ZERO},
                    {"assembly_id": "control", "transform": ZERO},
                    {"assembly_id": "pi", "transform": ZERO},
                ],
            },
            {
                "assembly_id": "skeleton",
                "role": "structural_skeleton",
                "members": [
                    {"part_id": 1, "transform": ZERO},
                    {"part_id": 2, "transform": ZERO},
                ],
            },
            {"assembly_id": "display", "role": "rack_module", "members": [{"part_id": 4, "transform": ZERO}]},
            {"assembly_id": "control", "role": "rack_module", "members": [{"part_id": 5, "transform": ZERO}]},
            {"assembly_id": "pi", "role": "rack_module", "members": [{"part_id": 3, "transform": ZERO}]},
        ],
        "interfaces": [],
        "views": [
            {
                "name": "front",
                "projection": "o",
                "camera": [0, 0, 0, 90, 0, 0, 800],
                "assembly_view": "product",
                "assembly_view_id": 0,
                "show_proxies": False,
            }
        ],
        "view_sets": {"compact": ["front"], "full": ["front"]},
        "geometry_exports": [
            {"name": "pi_span", "dispatch_id": 103, "minimum_span": [250, None, None]}
        ],
    }
    for name, owner, height in (("display", "display", 2), ("control", "control", 3), ("pi", "pi", 2)):
        data["interfaces"].append(
            {
                "interface_id": f"{name}_rack",
                "owner_assembly": owner,
                "type": "ten_inch_rack_module",
                "height_u": height,
                "split_policy": "continuous_across_seam",
                "local_frame": ZERO,
                "engages_parts": ["skeleton_left", "skeleton_right"],
            }
        )
    return data, parts


class AssemblyContractTests(unittest.TestCase):
    def test_valid_nested_contract(self):
        data, parts = valid_contract()
        result = contract.validate_contract(data, parts)
        self.assertEqual(result["primary"], "product")
        self.assertEqual(len(result["assemblies"]), 5)

    def test_omitted_printable_part_fails(self):
        data, parts = valid_contract()
        data["assemblies"][1]["members"].pop()
        with self.assertRaises(SystemExit):
            contract.validate_contract(data, parts)

    def test_one_sided_rack_interface_fails(self):
        data, parts = valid_contract()
        data["interfaces"][2]["engages_parts"] = ["skeleton_right"]
        with self.assertRaises(SystemExit):
            contract.validate_contract(data, parts)

    def test_missing_numeric_view_dispatch_fails(self):
        data, parts = valid_contract()
        del data["views"][0]["assembly_view_id"]
        with self.assertRaises(SystemExit):
            contract.validate_contract(data, parts)

    def test_undeclared_fabrication_subpart_fails(self):
        data, parts = valid_contract()
        parts[6] = "undeclared_module_half"
        with self.assertRaises(SystemExit):
            contract.validate_contract(data, parts)

    def test_half_width_export_fails_independent_span_check(self):
        data, parts = valid_contract()
        validated = contract.validate_contract(data, parts)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "pi_span.stl").write_text(
                "solid half\nfacet normal 0 0 1\nouter loop\n"
                "vertex -50 0 0\nvertex 51 0 0\nvertex -50 1 0\n"
                "endloop\nendfacet\nendsolid half\n",
                encoding="utf-8",
            )
            with self.assertRaises(SystemExit):
                contract.validate_geometry_exports(validated["geometry_exports"], root)

    def test_full_width_export_passes_independent_span_check(self):
        data, parts = valid_contract()
        validated = contract.validate_contract(data, parts)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "pi_span.stl").write_text(
                "solid full\nfacet normal 0 0 1\nouter loop\n"
                "vertex -127 0 0\nvertex 127 0 0\nvertex -127 1 0\n"
                "endloop\nendfacet\nendsolid full\n",
                encoding="utf-8",
            )
            contract.validate_geometry_exports(validated["geometry_exports"], root)

    def test_stale_review_manifest_fails(self):
        current = {
            "config": {"sha256": "a"},
            "parts_manifest": {"sha256": "b"},
            "assembly_contract": {"sha256": "c"},
            "source": {"sha256": "d"},
            "printable_build": {"sha256": "e"},
        }
        manifest = copy.deepcopy(current)
        manifest.update({"schema_version": 1, "view_set": "full"})
        manifest["source"]["sha256"] = "stale"
        with self.assertRaises(SystemExit):
            review.validate_manifest_inputs(manifest, current, "full")


if __name__ == "__main__":
    unittest.main()
