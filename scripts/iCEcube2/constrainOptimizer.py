#!/usr/bin/env python

import sys
from tempfile import mkstemp
from shutil import move
from os import fdopen, remove

def constrainVerilog(srcFile):

    # create temporary file
    fh, absPath = mkstemp()

    # open new file for writing
    with fdopen(fh, 'w') as newFile:

        # open old file for reading
        with open(srcFile) as oldFile:

            # tracking block comments
            inBlock = False

            # consider each line in file
            for line in oldFile:

                # if we see /*, a block comment has started
                if "/*" in line:
                    inBlock = True

                # if we see */, a block comment has ended
                elif "*/" in line:
                    inBlock = False

                # if we're not in a block comment
                if not inBlock:

                    # if the line contains a reg or wire declaration
                    if "reg" in line or "wire" in line:

                        # if the declaration hasn't been constrained
                        if "syn_keep" not in line:

                            # do the deed
                            newFile.write(line.replace(";", " /* synthesis syn_keep = 1 */;"))
                    # don't change the line, but make sure it gets copied
                    else:
                        newFile.write(line)
    
                # don't change the line, but make sure it gets copied
                else:
                    newFile.write(line)


    # remove old file
    remove(srcFile)

    # move temp file to current directory
    move(absPath, srcFile)

def constrainVHDL(srcFile):

    # create temporary file
    fh, absPath = mkstemp()

    # open new file for writing
    with fdopen(fh, 'w') as newFile:

        # open old file for reading
        with open(srcFile) as oldFile:

            # tracking architecture blocks and signal names
            inArchBlock = False
            writeAttr = False
            signals = []

            # consider each line in file
            for line in oldFile:

                # because VHDL is case-insensitive, convert line to lowercase
                line = line.lower()

                # if line contains architecture declaration, start tracking signal names
                #if "architecture" in line and not "--" in line:
                if "architecture" in line:

                    # make sure comments come after "architecture" (we're not IN a comment... why would use architecture as a keyword???)
                    if not "--" in line or line.find("architecture") < line.find("--"):

                        # set arch block flag
                        print "entering arch block"
                        inArchBlock = True
                        writeAttr = True

                # if we're in an arch block and we find this, the file is already done
                if inArchBlock and "syn_keep" in line:
                    alreadyDone = True
                    print "already done"
                    return

                # if in an architecture block and we find the word "begin", drop the line
                if inArchBlock and "begin" in line:
                    print "leaving arch block"
                    inArchBlock = False;

                    # start new line
                    newFile.write("attribute syn_keep of ")

                    # add each signal name
                    first = True
                    for signal in signals:

                        if first:
                            first = False

                        else:
                            newFile.write(", ")
                            
                        newFile.write(signal)

                    newFile.write(" : signal is true;\n")

                # when in an arch block, look for the word "signal"
                if inArchBlock and "signal" in line:

                    # split line on whitespace
                    splitSignals = line.split()

                    # collect signal name (should be second word)
                    signals.append(splitSignals[1])

                    print "adding signal", splitSignals[1]

                # pass line to new file without changing it
                newFile.write(line)

                # if we just entered an attribute block
                if inArchBlock and writeAttr:

                    print "adding syn_keep attribute"

                    # don't come back here until we go out and back in
                    writeAttr = False

                    # add attribute line 
                    newFile.write("attribute syn_keep : boolean;\n")

    # remove old file
    remove(srcFile)

    # move temp file to current directory
    move(absPath, srcFile)

def main():

    # say hello 
    print "applying optimizer constraints..."

    # identify source file
    for rtlFile in sys.argv[1:]:

        if ".vhd" in rtlFile:
            
            constrainVHDL(rtlFile)
    
        elif ".v" in rtlFile:
    
            constrainVerilog(rtlFile)
    
        else:
    
            print "bad file name!"

if __name__=="__main__":
    main()
