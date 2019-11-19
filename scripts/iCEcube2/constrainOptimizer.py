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
                        if "syn_preserve" not in line:

                            # do the deed
                            newFile.write(line.replace(";", " /* synthesis syn_preserve=1 */;"))
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
            inEntity = False
            inGeneric = False
            signals = []

            # consider each line in file
            for line in oldFile:

                # because VHDL is case-insensitive, convert line to lowercase
                line = line.lower()

                # strip comments
                line = line.split("--", 1)[0]

                # if line contains architecture declaration, start tracking signal names
                #if "architecture" in line and not "--" in line:
                if "entity" in line:

                    # set arch block flag
                    print "entering entity"
                    inEntity = True

                if "generic" in line:

                    inGeneric = True

                # if we're in an arch block and we find this, the file is already done
                if inEntity and "syn_preserve" in line:
                    alreadyDone = True
                    print "already done"
                    return

                # if in an architecture block and we find the word "begin", drop the line
                if inEntity and "end" in line:
                    print "leaving entity"
                    inEntity = False;

                    # make sure there were new signals
                    if signals:

                        # add attribute
                        newFile.write("\tattribute syn_preserve : boolean;\n")
                        # start new line
                        newFile.write("\tattribute syn_preserve of ")
    
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
                #if inEntity and ":" in line:
                if inEntity:

                    # trim everything after the first occurence of ":"
                    signalLine = line.split(":", 1)[0]

                    # remove occurrences of keywords
                    dontRead = ["entity", "function", "alias", "component", "generic", "constant", "port"]
                    if all(reservedWord not in signalLine for reservedWord in dontRead):

                        # split line on whitespace and collect signal names
                        for maybeSignal in signalLine.split():

                            # don't include reserved words
                            reservedWords = ["signal",  "is", "of", "attribute", "variable", "process", "procedure"]
                            if all(maybeSignal != reservedWord for reservedWord in reservedWords):

                                # strip commas, semicolons, and close parenthesis
                                signal = maybeSignal.split(",", 1)[0]
                                signal = signal.split(";", 1)[0]
                                signal = signal.split(")", 1)[0]

                                if signal.strip():
                                    print "adding signal", signal
                                    signals.append(signal)

                # pass non-empty line to new file without otherwise changing it
                if line.strip():

                    if line.endswith("\n"):

                        newFile.write(line)

                    else:

                        newFile.write(line + "\n")

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
