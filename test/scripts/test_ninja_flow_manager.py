"""Unit tests for the NinjaFlowManager class."""

import os
import subprocess
import unittest
from bfasst.ninja_flows.flow_utils import get_flows
from bfasst.paths import (
    DESIGNS_PATH,
    NINJA_BUILD_PATH,
    ROOT_PATH,
)
from bfasst.ninja_flows.vivado import Vivado

from bfasst.ninja_flows.ninja_flow_manager import NinjaFlowManager, get_design_basenames


class TestNinjaFlowManager(unittest.TestCase):
    """Unit tests for the NinjaFlowManager class."""

    @classmethod
    def setUpClass(cls):
        cls.flow_manager = NinjaFlowManager()

    def test_create_flows(self):
        """Test that the flow manager creates the correct flows."""
        self.flow_manager.create_flows("vivado", ["byu/alu", "byu/counter"])

        self.assertIsInstance(self.flow_manager.flows[0], Vivado)
        self.assertIsInstance(self.flow_manager.flows[1], Vivado)
        self.assertEqual(self.flow_manager.designs, ["byu/alu", "byu/counter"])
        self.assertEqual(self.flow_manager.flow_name, "vivado")

    def test_run_flows(self):
        """Test that the flow manager runs the flows correctly."""
        self.flow_manager.create_flows("vivado", ["byu/alu", "byu/counter"])
        self.flow_manager.run_flows()

        with open(NINJA_BUILD_PATH, "r") as f:
            ninja_build = f.read()

        self.assertIn(" configure\n", ninja_build)
        self.assertIn(f" configure {DESIGNS_PATH}/byu/alu {DESIGNS_PATH}/byu/counter ", ninja_build)

        build_statement_count = ninja_build.count("\nbuild ")
        # should have 1 configure build statement, and 5 each for the 2 flows = 11 total
        self.assertEqual(build_statement_count, 11)

    def test_ninja_rebuilds(self):
        """Test that the build.ninja file rebuilds itself if any flow or template changes."""
        flows = get_flows()
        for flow in flows:
            self.__check_all_rebuild_deps(flow)

    def __check_all_rebuild_deps(self, flow_name):
        """Check that modification of all flows and templates related to a given flow
        trigger a ninja rebuild"""
        self.flow_manager.create_flows(flow_name, ["byu/alu"])
        self.flow_manager.run_flows()

        deps = self.flow_manager.flows[0].add_ninja_deps()

        for dep in deps:
            self.__check_rebuild_dependency(dep.strip())

    def __check_rebuild_dependency(self, dependency_path):
        """Run the build.ninja file and check that it rebuilds if the given dependency changes."""
        # get the mtime of the build.ninja file
        old_mtime = NINJA_BUILD_PATH.stat().st_mtime

        # update the dependency file's mtime
        self.__update_file_mtime(dependency_path)

        # running the build.ninja file should rebuild it
        self.__run_ninja()
        new_mtime = NINJA_BUILD_PATH.stat().st_mtime

        self.assertGreater(new_mtime, old_mtime)

    def __update_file_mtime(self, file_path):
        """Update the mtime of the given file."""
        os.utime(file_path)

    def __run_ninja(self):
        """Run the build.ninja file and ensure it completes successfully."""
        proc = subprocess.Popen(
            "ninja", cwd=ROOT_PATH, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        proc.communicate()
        status = proc.wait()
        self.assertEqual(status, 0)

    def test_get_design_basenames(self):
        """Test that the design basenames are returned correctly."""
        designs = ["some/long/path/byu/alu", "another/path/byu/counter"]
        basenames = get_design_basenames(designs)
        self.assertEqual(basenames, ["byu/alu", "byu/counter"])


if __name__ == "__main__":
    unittest.main()
