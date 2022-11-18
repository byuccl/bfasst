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

    def refresh_directory(self, path):
        shutil.rmtree(path["build_dir"])
        Path(path["build_dir"]).mkdir()

    def test_1(self):

        """Performs a simple test on an ALU design. Should be equivalent."""

        path = self.path_layout("alu_test", "alu_impl.v", "alu_reversed.v")
        self.refresh_directory(path)
        compare_waveforms.generate_files(False, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), True)

    def test_2(self):

        """Performs a simple test on a corrupted design. Should be unequivalent."""

        path = self.path_layout("corrupt_alu_test", "alu_impl.v", "alu_reversed.v")
        self.refresh_directory(path)
        compare_waveforms.generate_files(False, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), False)

    def test_3(self):

        """Performs a simple test on a design with several verilog files. Should be equivalent."""

        path = self.path_layout("calc_test", "calc_impl.v", "calc_reversed.v")
        self.refresh_directory(path)
        compare_waveforms.generate_files(True, path, 100)
        self.assertEqual(compare_waveforms.run_test(path), True)

    def test_4(self):

        """Confirms ten thousand tests can be run. Should be equivalent."""

        path = self.path_layout("calc_test", "calc_impl.v", "calc_reversed.v")
        self.refresh_directory(path)
        compare_waveforms.generate_files(True, path, 10000)
        self.assertEqual(compare_waveforms.run_test(path), True)

    def test_5(self):

        """Confirms two designs with differing IOs will not produce a DSN file."""

        path = get_paths.get_paths(
        Path(f"{package}/../out"),
        Path(f"{package}/../third_party/yosys/cells_sim.v"),
        Path(f"{package}/../templates/sample_tb.v"),
        Path(f"{package}/alu_test/alu_impl.v"),
        Path(f"{package}/calc_test/calc_reversed.v")
    )
        self.refresh_directory(path)
        with self.assertRaises(FileNotFoundError):
            compare_waveforms.generate_files(True, path, 100)

    def test_6(self):

        """Confirms without a techlib that Iverilog will not function."""

        path = get_paths.get_paths(
        Path(f"{package}/../out"),
        Path(""),
        Path(f"{package}/../templates/sample_tb.v"),
        Path(f"{package}/alu_test/alu_impl.v"),
        Path(f"{package}/alu_test/alu_reversed.v")
    )
        self.refresh_directory(path)
        with self.assertRaises(FileNotFoundError):
            compare_waveforms.generate_files(True, path, 100)


if __name__ == '__main__':
    if __file__ != "compare_waveforms.py":
        package = Path(Path().absolute() / __file__[0 : len(__file__) - 25])
    else:
        package = Path().absolute()
    unittest.main()
