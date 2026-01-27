"Generate Java stubs for RapidWright and its dependencies."

from argparse import ArgumentParser

import stubgenj

import rapidwright as _
import com.xilinx.rapidwright
import java

if __name__ == "__main__":
    parser = ArgumentParser(description="Generate Java stubs for RapidWright and its dependencies.")
    parser.add_argument("outputDir", type=str, help="Output directory for the generated stubs.")
    args = parser.parse_args()
    stubgenj.generateJavaStubs(
        [java, com.xilinx.rapidwright],
        outputDir=args.outputDir,
        includeJavadoc=False,
        useStubsSuffix=False,
    )
