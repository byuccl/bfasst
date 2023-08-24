"""
Setup script for pip install
"""

from setuptools import setup, find_packages

setup(
    name="bfasst",
    packages=find_packages(),
    version="1.0.0",
    description="Tools for FPGA Assurance Flows",
    author="BYU Configurable Computing Lab",
    author_email="jgoeders@byu.edu",
)
