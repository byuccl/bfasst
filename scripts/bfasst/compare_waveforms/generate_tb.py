import os
from random import randint
import sys
import os
from os.path import exists
import numpy as np
import spydrnet as sdn

#A basic data structure to store the parameters from the verilog file as well as their bit sizes.
data = {
    "inputList": [],
    "iBitsList": [],
    "outputList": [],
    "oBitsList": [],
    "totalList": [],
    "randList": []
}

fileName = []
file = []
fileNum = 0
PATH = "/home/edvenson/bfasst/build/waveform_comparison/"
SAMPLE_PATH = "/home/edvenson/bfasst/scripts/bfasst/compare_waveforms/sample_tb.v"

#A function that will reset all data inside the data structure for future files to fill up.
def refresh(data):
    data.clear()
    data = {
        "inputList": [],
        "iBitsList": [],
        "outputList": [],
        "oBitsList": [],
        "totalList": [],
        "randList": []
    }
    return data

#Returns the sizes of input, output, and the total list.
def inputNum():
    return(len(data["inputList"]))

def outputNum():
    return(len(data["outputList"]))

def totalNum():
    return(len(data["inputList"]) + len(data["outputList"]))

#A function to parse the arguments passed into the file and then open the files they point to. 
def openFiles(fileList):
    i = 0
    for f in fileList:
        if(i == 0):
            PATH = PATH + str(f) + "/"
        elif(i == 1):
            PATH = PATH + str(f) + "/"
        else:
            fileName[fileNum] + "/"
            fileName = f
        i = i + 1
    
    for x in fileName:
        file.append(open(PATH + str(x) + ".v"))

#Parses the file using spydrnet to find the inputs and outputs and their bit sizes. 
def parse(file):
    netlist = sdn.parse(file)
    library = netlist.libraries[0]
    definition = library.definitions[0]

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

#Creates a temporary file for reversed-netlists to find input/output order because many reversed netlists have components that are
#unable to be read by spydrnet. 
def parseReversed(file):
    file = open(file)
    if(exists("test.v")):
        os.remove("test.v")
    newFile = open("test.v", "x")

    i = 0

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
    parse(newFile.name)
    os.remove("test.v")

#A function to generate the intitial testbench. This function takes a sample testbench, fills in missing
#portions with data parsed earlier, and then adds in randomly generated data for the inputs to be set
#equal to every 5 ns.
def generateFirstTestbench(tb, line, tests):
    if "TB_NAME;" in line:
        line = ("module " + fileName[0] + "_tb;")
        tb.write(line)
        line = "\n"
    
    if "TB_NAME)" in line:
        line=("    $dumpvars(0," + fileName[0] + "_tb);\n")
    
    if "INPUTS" in line:
        i = 0
        while(i < inputNum()):
            if data["inputList"][i] != "clk":
                line = "reg [" + str(data["iBitsList"][i]) + ":0] " + data["inputList"][i] + " = 0;\n"
                tb.write(line)
            i = i+1
        line = ""

    if "OUTPUTS" in line:
        i = 0
        while(i < outputNum()):
            line = "wire [" + str(data["oBitsList"][i]) + ":0] " + data["outputList"][i] + ";\n"
            tb.write(line)
            i=i+1
        line = ""
    
    if "MODULE_NAME" in line:
        i = 0
        line = fileName[0] + " instanceOf ("
        while(i < totalNum()):
            if(i == totalNum() - 1):
                line = line + data["totalList"][i] + ");\n"
            else:
                line = line + data["totalList"][i] + ", "
            i = i + 1

    if "/*SIGNALS" in line:
        i = 0
        while(i < inputNum()):
            if data["iBitsList"][i] == 0:
                data["randList"].append(np.random.randint(low = 0, high = 2, size = int(tests)))
            else:
                data["randList"].append(np.random.randint(low = 0, high = (2**(int(data["iBitsList"][i]) + 1)-1), size = int(tests)))
            i=i+1
        i = 0
        j = 0
        while(i < int(tests)):
            while(j < inputNum()):
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

#This function takes the last test bench generated and changes all references to inputs, outputs, and everything else to
#what was found in the most recent file. This is done to preserve the random numbers from the first testbench so that
#each file can be compared to each other. The instanceOf module is fixed because reversed-netlists and golden-netlists
#can have different patterns for inputs and outputs, so this makes sure they will still work properly. 
def generateTestbench(tb, line):
    if fileName[fileNum-1] + "_tb;" in line:
        line = line.replace(fileName[fileNum-1], fileName[fileNum])
    
    if fileName[fileNum-1] + "_tb);" in line:
        line = "    $dumpvars(0," + fileName[fileNum] + "_tb);\n"
    
    if fileName[fileNum-1] + " instanceOf (" in line:
        line = fileName[fileNum] + " instanceOf ("
        i = 0
        while(i < totalNum()):
            if(i == totalNum() - 1):
                line = line + data["totalList"][i] + ");\n"
            else:
                line = line + data["totalList"][i] + ", "
            i = i + 1

    tb.write(line)

def generateFirstTCL():
    if(exists(PATH + fileName[fileNum] + "/" + fileName[fileNum] + ".tcl")):
        os.remove(PATH + fileName[fileNum] + "/" + fileName[fileNum] + ".tcl")
    TCL = open(PATH + fileName[fileNum] + "/" + fileName[fileNum] + ".tcl", "x")
    i=0
    line = "set filter [list "
    while(i < totalNum()):
        line = line + fileName[fileNum] + "_tb." + str(data["totalList"][i]).strip() + " "
        i=i+1
    line = line + "]\n"
    TCL.write(line)
    TCL.write("gtkwave::addSignalsFromList $filter\n")
    TCL.write('gtkwave::/File/Export/Write_VCD_File_As "' + str(PATH) + fileName[fileNum] + '.vcd"\n')
    TCL.write("gtkwave::File/Quit")

def generateTCL():
    if(exists(PATH + fileName[fileNum] + "/" + fileName[fileNum] + ".tcl")):
        os.remove(PATH + fileName[fileNum] + ".tcl")   
    TCL = open(PATH + fileName[fileNum] + ".tcl", "x")
    sample = open(PATH + fileName[fileNum-1] + ".tcl")
    for line in sample:
        if fileName[fileNum-1] in line:
            line = line.replace(fileName[fileNum-1], fileName[fileNum])
        TCL.write(line)


def main(fileList):
    PATH = "/home/edvenson/bfasst/build/waveform_comparison/"
    SAMPLE_PATH = "/home/edvenson/bfasst/scripts/bfasst/compare_waveforms/sample_tb.v"
    openFiles(fileList)

        

    for x in file:
        if(x.name.find("reversed") != -1):
            parseReversed(x.name)
        else:
            parse(x.name)

        if(exists(PATH + fileName[fileNum] + "_tb.v")): #Removes the previously generated testbench if it exists.
            os.remove(PATH + fileName[fileNum] + "_tb.v")

        if fileNum == 0: #Number of tests is only asked once because all future testbenches generated must have the same number of tests w/ the same values
            tests = input("How many tests would you like to run?\nPlease enter a number: ")
            sample = open(SAMPLE_PATH)
        else:
            sample = open(PATH + fileName[fileNum-1] + "_tb.v")
        tb = open(PATH + fileName[fileNum] + "_tb.v", "x")

        for line in sample:
            if(fileNum == 0):
                generateFirstTestbench(tb, line, tests)
            else:
                generateTestbench(tb, line)

        sample.close()
        tb.close()
        if (fileNum == 0):
            generateFirstTCL()
        else:
            generateTCL()

        data = refresh(data)
        fileNum = fileNum + 1