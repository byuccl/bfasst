"""A set of unit tests to confirm functionality for the WaFoVe."""

import shutil
import unittest
from pathlib import Path
from bfasst.compare_waveforms.templates import get_paths
from bfasst.compare_waveforms import compare_waveforms

class TestCompareWaveforms(unittest.TestCase):

    """Performs unit tests to confirm the waveform tool works properly."""

    def path_layout(self, folder, design_a, design_b):
        return(get_paths.get_paths(
        Path(f"{package}/../out"),
        Path(f"{package}/../third_party/yosys/cells_sim.v"),
        Path(f"{package}/../templates/sample_tb.v"),
        Path(f"{package}/{folder}/{design_a}"),
        Path(f"{package}/{folder}/{design_b}")
    ))

    def test_alu(self):

        """Performs a simple test on an ALU design. Should be equivalent."""

        path = self.path_layout("alu_test", "alu_impl.v", "alu_reversed.v")
        shutil.rmtree(path["build_dir"])
        Path(path["build_dir"]).mkdir()
        compare_waveforms.generate_files(False, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), True)

    def test_corrupted_design(self):

        """Performs a simple test on a corrupted design. Should be unequivalent."""

        path = self.path_layout("corrupt_alu_test", "alu_impl.v", "alu_reversed.v")
        shutil.rmtree(path["build_dir"])
        Path(path["build_dir"]).mkdir()
        compare_waveforms.generate_files(False, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), False)

    def test_multiple_files(self):

        """Performs a simple test on a design with several verilog files. Should be equivalent."""

        path = self.path_layout("calc_test", "calc_impl.v", "calc_reversed.v")
        shutil.rmtree(path["build_dir"])
        Path(path["build_dir"]).mkdir()
        compare_waveforms.generate_files(True, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), True)

if __name__ == '__main__':
    if __file__ != "compare_waveforms.py":
        package = Path(Path().absolute() / __file__[0 : len(__file__) - 25])
    else:
        package = Path().absolute()
    unittest.main()
