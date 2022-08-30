from pathlib import Path
import subprocess


def parse_diff(vcd_test, diff_test, parsed_diff):
    #For now, make these the paths to your vcd file, diff.txt file, and where you want the parsed_diff.txt file stored.
    #This will be automated in the future once this parser has been debugged.
    #vcd_test = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/flipflops/waveform/flipflops_impl.vcd")
    #diff_test = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/flipflops/waveform/diff.txt")
    #parsed_diff = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/flipflops/waveform/parsed_diff.txt")

    newWord = False
    words = []
    symbols = []
    signals = []

    with vcd_test.open("r") as file:
        for line in file:
            if "$var wire" in line:
                word = ""
                for i in line:
                    if i == " ":
                        newWord = True
                    if newWord == False:
                        word = word + i
                    else:
                        if((word != "$var") & (word != "wire")):
                            if "[" in word:
                                word = word[0:word.index("[")]
                            words.append(word)
                            #print(word)
                            word = ""
                            newWord = False
                        else:
                            word = ""
                            newWord = False

    j = 0
    for i in words:
        if j == 0:
            j = j + 1
        elif j == 1:
            print(i)
            symbols.append(i)
            j = j+1
        elif j == 2:
            print(i)
            signals.append(i)
            j = 0

    if(parsed_diff.exists()):
        parsed_diff.unlink()

    for symbol, signal in zip(symbols, signals):
        print("Symbol: " + symbol + " is " + signal)

    with diff_test.open("r") as file:
        with parsed_diff.open("x") as output:
            output.write("HOW TO READ: \n")
            output.write("+ indicates this data was added and is not present in the other file.\n")
            output.write("- indicates this data was removed and is present in the other file.\n")
            output.write("All differences are seperated by file. The Implicit and Reversed Files are labeled as such.\n")
            output.write("To better debug, re-open the VCD files using the Compare Waveforms script and use this file to find where to look for differences.\n")
            output.write("For further confirmation, open both testbenches with Vivado and compare the results to this diff file.\n\n")
            firstDif = True
            isDif = False
            for line in file:
                isParsed = False
                for symbol,signal in zip(symbols, signals):
                    if symbol == "#":
                        if "#\n" in line:
                            line = line.replace(symbol," " + signal)
                            isParsed = True
                        elif "#" in line:
                            print(line)
                            if(line[line.index("#") + 1] != ' '):
                                if(line[len(line)-1] == "\n"):
                                    num = line[line.index("#")+1:line.index("\n")]
                                    num = int(num)
                                    num = int(num / 1000)
                                    line = " " + str(num) + " ns\n"
                                    isParsed = True
                                else:
                                    num = line[line.index("#")+1:]
                                    num = int(num)
                                    num = int(num / 1000)
                                    line = " " + str(num) + " ns\n"
                                    isParsed = True
                    elif symbol == "$":
                        if "$scope" not in line:
                            if "$var wire" not in line:
                                if "$timescale" not in line:
                                    if "$end" not in line:
                                        if(isParsed == False):
                                            line = line.replace(symbol," " + signal)
                                            isParsed = True
                    elif symbol in line:
                        if(line[line.index(symbol):]==(symbol + "\n")):
                            line = line.replace(symbol," " + signal) 
                            isParsed = True

                if firstDif:
                    if isDif:
                        if "*****" in line:
                            firstDif = False
                        else:
                            line = ""
                    else:
                        if "*****" in line:
                            line = ""
                            isDif = True
                        else:
                            line = ""
                else:
                    if "*****" in line:
                        line = "*******************\n"

                    if "*** " in line:
                        if line[line.index(" ") + 1] == "/":
                            line = "*** IMPL: " + line[line.index(" ") + 1:]
                        else:
                            line = "*** IMPL: " + line[line.index(" ") + 1:]

                    if "--- " in line:
                        if line[line.index(" ") + 1] == "/":
                            line = "--- REVERSED: " + line[line.index(" ") + 1:]
                        else:
                            line = "--- REVERSED: " + line[line.index(" ") + 1:]
                    
                output.write(line)


        
        
