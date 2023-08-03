"""Utility methods for getting flows"""
from importlib import import_module
from pathlib import Path


def get_flows():
    """Get all flows in the flows directory"""
    flows = [flow.stem for flow in Path(__file__).parent.glob("*.py") if flow.stem != "__init__"]
    return flows


def get_flow(flow_name):
    """Get a flow by name"""
    flow_module = import_module(f"bfasst.ninja_flows.{flow_name}")
    flow_class = "".join(word.capitalize() for word in flow_name.split("_"))
    return getattr(flow_module, flow_class)
