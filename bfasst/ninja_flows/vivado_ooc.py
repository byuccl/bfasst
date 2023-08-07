"""Wrapper for Vivado class that returns instance for out-of-context run"""
from argparse import ArgumentParser
from bfasst.ninja_flows.flow_utils import create_build_file
from bfasst.ninja_flows.vivado import Vivado
from bfasst.paths import NINJA_BUILD_PATH


class VivadoOoc:
    """Wrapper for Vivado class that returns instance for out-of-context run"""

    def __new__(self, design):
        return Vivado(design, ooc=True)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--design", type=str, required=True, help="Design to run")
    args = parser.parse_args()
    flow = VivadoOoc(args.design)
    create_build_file()
    flow.create_rule_snippets()
    flow.create_build_snippets()
