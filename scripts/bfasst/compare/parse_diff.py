from pathlib import Path
import subprocess

vcd_test = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/bit_num_reg_1/bit_num_reg_1_impl.vcd")
diff_test = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/bit_num_reg_1/diff.txt")
parsed_diff = Path("/home/edvenson/bfasst/build/xilinx_yosys_waveform/byu/bit_num_reg_1/parsed_diff.txt")

newWord = False
words = []
symbols = []
signals = []

isPound = False
isDollar = False


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

        firstDif = True
        isDif = False
        for line in file:
            isParsed = False
            for symbol,signal in zip(symbols, signals):
                if symbol == "#":
                    if(isParsed == False):
                        if "#\n" in line:
                            line = line.replace(symbol," " + signal)
                            isParsed = True
                        elif "#" in line:
                            if(line[line.index("#") + 1] != " "):
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


        
        
