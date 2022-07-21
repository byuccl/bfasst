import bfasst 
import subprocess
import pathlib
import sys
import os
import re
import fileinput
from bfasst.compare.base import CompareTool
from bfasst.status import Status, CompareStatus
from bfasst.tool import ToolProduct
from random import randint
from os.path import exists
import numpy as np
import spydrnet as sdn

data = {
    "inputList": [],
    "iBitsList": [],
    "outputList": [],
    "oBitsList": [],
    "totalList": [],
    "randList": []
}

def refresh(data):
    data["inputList"].clear()
    data["iBitsList"].clear()
    data["outputList"].clear()
    data["oBitsList"].clear()
    data["totalList"].clear()
    data["randList"].clear()


class Waveform_CompareTool(CompareTool):

    TOOL_WORK_DIR = "waveform"
    LOG_FILE_NAME = "log.txt"
    CELLS_SIM = str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v" + "; "
    #Note: Impl design = str(design.impl_netlist_path)
    #Reversed design = str(design.reversed_netlist_path)
    def compare_netlists(self, design, print_to_stdout=True):
        self.print_to_stdout = print_to_stdout
        log_path = self.work_dir / self.LOG_FILE_NAME
        generate_comparison = ToolProduct(None, log_path, self.check_compare_status)
        status = self.get_prev_run_status(
            tool_products=(generate_comparison,),
            dependency_modified_time=max(
                pathlib.Path(__file__).stat().st_mtime, design.reversed_netlist_path.stat().st_mtime
            ),
        )

        if status is not None:
            if self.print_to_stdout:
                self.print_skipping_compare()
            return status
        
        if self.print_to_stdout:
            self.print_running_compare()

        #Create TestBench, TCL, etc. 
        IMPL_NAME = design.impl_netlist_path.name[0: len(design.impl_netlist_path.name)-2]
        REVERSED_NAME = design.reversed_netlist_path.name[0: len(design.reversed_netlist_path.name)-2]
        print("Module 1: " + IMPL_NAME)
        print("Module 2: " + REVERSED_NAME)

        self.generate_files(design)

        if(self.runTest(design)):
            return self.success_status
        else:
            return Status(CompareStatus.NOT_EQUIVALENT)

    #Returns the sizes of input, output, and the total list.
    def inputNum(self):
        return(len(data["inputList"]))

    def outputNum(self):
        return(len(data["outputList"]))

    def totalNum(self):
        return(len(data["inputList"]) + len(data["outputList"]))

    def fix_file(self, PATH, fileName, isReversed):
        fin = open(PATH + fileName + ".v", "r")
        fileData = fin.read()
        if(isReversed):
            fileData = fileData.replace("module top(", "module " + fileName + "(")
        else:
            fileData = fileData.replace("module " + fileName[0:len(fileName)-5] + "\n", "module " + fileName)
        fin.close()
        fin = open(PATH + fileName + ".v", "w")
        fin.write(fileData)
        fin.close()

    def parse(self, file):
        netlist = sdn.parse(file)
        library = netlist.libraries[0]
        definition = library.definitions[0] #CHANGE THIS FOR MULTIPLE-MODULE DESIGNS.

        i = 0
        while(i < len(definition.ports)):
            if(str(definition.ports[i].direction) == "Direction.OUT"):
                data["outputList"].append(definition.ports[i].name)
                data["totalList"].append(definition.ports[i].name)
                data["oBitsList"].append(len(definition.ports[i].pins)-1)
            elif (str(definition.ports[i].direction) == "Direction.IN"):
                data["inputList"].append(definition.ports[i].name)
                data["totalList"].append(definition.ports[i].name)
                data["iBitsList"].append(len(definition.ports[i].pins)-1)
            i = i + 1

    def parseReversed(self, path, file):
        file = open(file)
        if(exists(path + "test.v")):
            os.remove(path + "test.v")
        newFile = open(path + "test.v", "x")
        i=0

        for line in file:
            if "module" in line:
                newFile.write(line)
            elif "input" in line:
                newFile.write(line)
            elif "output" in line:
                newFile.write(line)
            else:
                if (i == 0):
                    i = 1
                    newFile.write(line)
        file.close()
        newFile.close()
        self.parse(newFile.name)
        os.remove(path + "test.v")

    def generateFirstTestbench(self, tb, line, tests, fileName):
        if "TB_NAME;" in line:
            line = ("module " + fileName[0] + "_tb;")
            tb.write(line)
            line = "\n"
        
        if "TB_NAME)" in line:
            line=("    $dumpvars(0," + fileName[0] + "_tb);\n")
        
        if "INPUTS" in line:
            i = 0
            while(i < self.inputNum()):
                if data["inputList"][i] != "clk":
                    line = "reg [" + str(data["iBitsList"][i]) + ":0] " + data["inputList"][i] + " = 0;\n"
                    tb.write(line)
                i = i+1
            line = ""

        if "OUTPUTS" in line:
            i = 0
            while(i < self.outputNum()):
                line = "wire [" + str(data["oBitsList"][i]) + ":0] " + data["outputList"][i] + ";\n"
                tb.write(line)
                i=i+1
            line = ""
        
        if "MODULE_NAME" in line:
            i = 0
            line = fileName[0] + " instanceOf ("
            while(i < self.totalNum()):
                if(i == self.totalNum() - 1):
                    line = line + data["totalList"][i] + ");\n"
                else:
                    line = line + data["totalList"][i] + ", "
                i = i + 1

        if "/*SIGNALS" in line:
            i = 0
            while(i < self.inputNum()):
                if data["iBitsList"][i] == 0:
                    data["randList"].append(np.random.randint(low = 0, high = 2, size = int(tests)))
                else:
                    data["randList"].append(np.random.randint(low = 0, high = (2**(int(data["iBitsList"][i]) + 1)-1), size = int(tests)))
                i=i+1
            i = 0
            j = 0
            while(i < int(tests)):
                while(j < self.inputNum()):
                    if(j == 0):
                        line = "    # 5 " + str(data["inputList"][j]) + " = " + str(data["randList"][j][i]) + ";\n"
                    else:
                        line = "    " + str(data["inputList"][j]) + " = " + str(data["randList"][j][i]) + ";\n"
                    j=j+1
                    tb.write(line)
                j=0
                i=i+1
                tb.write("\n")
            line = "    # 5 $finish;"

        tb.write(line)

    def generateTestbench(self, tb, line, fileName, fileNum):
        if fileName[fileNum-1] + "_tb;" in line:
            line = line.replace(fileName[fileNum-1], fileName[fileNum])
        
        if fileName[fileNum-1] + "_tb);" in line:
            line = "    $dumpvars(0," + fileName[fileNum] + "_tb);\n"
        
        if fileName[fileNum-1] + " instanceOf (" in line:
            line = fileName[fileNum] + " instanceOf ("
            i = 0
            while(i < self.totalNum()):
                if(i == self.totalNum() - 1):
                    line = line + data["totalList"][i] + ");\n"
                else:
                    line = line + data["totalList"][i] + ", "
                i = i + 1

        tb.write(line)

    def generateFirstTCL(self, PATH, fileName, fileNum):
        if(exists(PATH + fileName[fileNum] + ".tcl")):
            os.remove(PATH+ fileName[fileNum] + ".tcl")
        TCL = open(PATH + fileName[fileNum] + ".tcl", "x")
        i=0
        line = "set filter [list "
        while(i < self.totalNum()):
            line = line + fileName[fileNum] + "_tb." + str(data["totalList"][i]).strip() + " "
            i=i+1
        line = line + "]\n"
        TCL.write(line)
        TCL.write("gtkwave::addSignalsFromList $filter\n")
        TCL.write('gtkwave::/File/Export/Write_VCD_File_As "' + str(PATH) + fileName[fileNum] + '.vcd"\n')
        TCL.write("gtkwave::File/Quit")

    def generateTCL(self, PATH, fileName, fileNum):
        if(exists(PATH + fileName[fileNum] + ".tcl")):
            os.remove(PATH + fileName[fileNum] + ".tcl")   
        TCL = open(PATH + fileName[fileNum] + ".tcl", "x")
        sample = open(PATH + fileName[fileNum-1] + ".tcl")
        for line in sample:
            if fileName[fileNum-1] in line:
                line = line.replace(fileName[fileNum-1], fileName[fileNum])
            TCL.write(line)
        

    def generate_files(self, design):
        TESTS = 100 #Note: change this number to however many tests the testbench should run.
        SAMPLE_PATH = str(pathlib.Path.cwd()) + "/scripts/bfasst/compare_waveforms/sample_tb.v"
        fileName = [design.impl_netlist_path.name[0: len(design.impl_netlist_path.name)-2], 
        design.reversed_netlist_path.name[0: len(design.reversed_netlist_path.name)-2]]
        file = [open(design.impl_netlist_path), open(design.reversed_netlist_path)]
        fileNum = 0
        PATH = str(design.impl_netlist_path)
        PATH = PATH[0: len(PATH) - len(design.impl_netlist_path.name)]

        for x in file:

            if(x.name.find("reversed") != -1):
                self.fix_file(PATH, fileName[fileNum], True)
                self.parseReversed(PATH, x.name)
            else:
                self.fix_file(PATH, fileName[fileNum], False)
                self.parse(x.name)
            
            if(exists(PATH + fileName[fileNum] + "_tb.v")):
                os.remove(PATH + fileName[fileNum] + "_tb.v")
            
            if fileNum == 0:
                sample = open(SAMPLE_PATH)
            else:
                sample = open(PATH + fileName[fileNum-1] + "_tb.v")
            tb = open(PATH + fileName[fileNum] + "_tb.v", "x")

            for line in sample:
                if(fileNum == 0):
                    self.generateFirstTestbench(tb, line, TESTS, fileName)
                else:
                    self.generateTestbench(tb, line, fileName, fileNum)
            
            sample.close()
            tb.close()

            if (fileNum == 0):
                self.generateFirstTCL(PATH, fileName, fileNum)
            else:
                self.generateTCL(PATH, fileName, fileNum)

            fileNum = fileNum + 1
            refresh(data)

    def runTest(self, design):
        isEquivalent = False
        IMPL_NAME = design.impl_netlist_path.name[0: len(design.impl_netlist_path.name)-2]
        PATH = str(design.impl_netlist_path)
        PATH = PATH[0: len(PATH) - len(design.impl_netlist_path.name)]
        string = "iverilog -o " + PATH + "dsn " + PATH + IMPL_NAME + "_tb.v " 
        string = string + PATH + design.impl_netlist_path.name + " " + str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v"
        os.system(string)
        os.system("vvp " + PATH + "dsn")
        os.system("mv test.vcd " + PATH + IMPL_NAME + "_temp.vcd")
        #os.system("gtkwave -T " + PATH + IMPL_NAME + ".tcl -o " + PATH + IMPL_NAME + "_temp.vcd")

        REVERSED_NAME = design.reversed_netlist_path.name[0: len(design.reversed_netlist_path.name)-2]
        string = "iverilog -o " + PATH + "dsn " + PATH + REVERSED_NAME + "_tb.v " 
        string = string + PATH + design.reversed_netlist_path.name + " " + str(pathlib.Path.cwd()) + "/third_party/yosys/techlibs/xilinx/cells_sim.v"
        os.system(string)
        os.system("vvp " + PATH + "dsn")
        os.system("mv test.vcd " + PATH + REVERSED_NAME + "_temp.vcd")
        os.system("echo do_initial_zoom_fit 1 >> .gtkwaverc")
        os.system("gtkwave -T " + PATH + REVERSED_NAME + ".tcl -o " + PATH + REVERSED_NAME + "_temp.vcd & gtkwave -T " + PATH + IMPL_NAME + ".tcl -o " + PATH + IMPL_NAME + "_temp.vcd")
        os.remove(".gtkwaverc")
        os.system("diff " + PATH + IMPL_NAME + ".vcd " + PATH + REVERSED_NAME + ".vcd >> " + PATH + "diff.txt")

        file = open(PATH + "diff.txt")
        lines = 0
        for line in file:
            lines = lines + 1

        if(lines > 8):
            print("NOT EQUIVALENT! See " + PATH + "diff.txt for more info!")
            os.remove(PATH + IMPL_NAME + "_temp.vcd")
            os.remove(PATH + REVERSED_NAME + "_temp.vcd")
            os.remove(PATH + IMPL_NAME + "_temp.vcd.fst")
            os.remove(PATH + REVERSED_NAME + "_temp.vcd.fst") 
            os.remove(PATH + IMPL_NAME + ".tcl")
            os.remove(PATH + REVERSED_NAME + ".tcl")
            os.system("diff -c " + PATH + IMPL_NAME + ".vcd " + PATH + REVERSED_NAME + ".vcd")
        else:
            isEquivalent = True
            print("WAVEFORMS EQUIVALENT!")
            os.remove(PATH + IMPL_NAME + "_temp.vcd")
            os.remove(PATH + REVERSED_NAME + "_temp.vcd")
            os.remove(PATH + IMPL_NAME + ".vcd")
            os.remove(PATH + REVERSED_NAME + ".vcd")
            os.remove(PATH + IMPL_NAME + "_temp.vcd.fst")
            os.remove(PATH + REVERSED_NAME + "_temp.vcd.fst") 
            os.remove(PATH + IMPL_NAME + ".tcl")
            os.remove(PATH + REVERSED_NAME + ".tcl")
            os.remove(PATH + "dsn")
            os.remove(PATH + "diff.txt")
        return(isEquivalent)




    def check_compare_status(self, log_path):
        log_text = open(log_path).read()

        # Check for timeout
        if re.search(r"^Timeout$", log_text, re.M):
            return Status(CompareStatus.TIMEOUT)

        # Regex search for result
        m = re.search(r"Equivalence successfully proven!", log_text, re.M)
        if m:
            return Status(CompareStatus.SUCCESS)

        m = re.search(r"ERROR", log_text, re.M)
        if m:
            return Status(CompareStatus.NOT_EQUIVALENT)