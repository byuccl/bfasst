#!/usr/bin/env python

import sys
from os import listdir
from os.path import isfile, join, abspath, dirname

class Benchmark:

	def __init__(self):
		self.name = ""
		self.keyPointsGolden = 0
		self.keyPointsRevised = 0
		self.unreachableGolden = 0
		self.unmappedGolden = 0
		self.unreachableRevised = 0
		self.unmappedRevised = 0
		self.equivalencies = 0
		self.nonEquivalencies = 0

	def toString(self):
		return self.name + '\t' + str(self.unreachableGolden) + '\t' + str(self.unreachableRevised) + '\t' +  str(self.unmappedGolden) + '\t' + str(self.unmappedRevised) + '\t' + str(self.equivalencies) + '\t' + str(self.nonEquivalencies) 

def parseFile(curResultsFile, design):

	if isfile(curResultsFile):

		# flag certain contents
		unmappedPointsFlag = False
		goldenFlag = False
		revisdFlag = False

		# create a new benchmark object and name it
		curBenchmark = Benchmark()
		curBenchmark.name = design

		for line in open(curResultsFile):

			if "Unmapped points:" in line:

				unmappedPointsFlag = True

			elif "Golden" in line and unmappedPointsFlag: 
				goldenFlag = True

			elif "Revised" in line and unmappedPointsFlag:

				revisdFlag = True
				goldenFlag = False
				
			elif "Unreachable" in line:

				if goldenFlag:
					curBenchmark.unreachableGolden = line.split()[-1]

				elif revisdFlag:
					curBenchmark.unreachableRevised = line.split()[-1]
			
			elif "Not-mapped" in line:

				if goldenFlag:
					curBenchmark.unmappedGolden = line.split()[-1]
					goldenFlag = False

				elif revisdFlag:
					curBenchmark.unmappedRevised = line.split()[-1]

			elif "Equivalent" in line:

				curBenchmark.equivalencies = line.split()[-1]

			elif "Non-equivalent" in line:

				curBenchmark.nonEquivalencies = line.split()[-1]

		return curBenchmark.toString()

def main():

	# validate inputs
	if len(sys.argv[1:]) < 2:
		print "usage: compile_results <path_to_top_results_directory> <name_of_results_file>"
		exit(1)

	# capture inputs
	designDir = sys.argv[1]
	resultsFile = sys.argv[2]

	# remove existing results file and open new file
	with open("results", "w+") as f:

		# add header to file output
		f.write('design:\tunreachable golden:\tunreachable revised:\tunmapped golden:\tunmapped revised:\tequivalencies:\tnon-equivalencies:\n')

		# consider each design
		for design in listdir(designDir):

			# look for the results file
			curResultsFile = join(designDir, design, resultsFile)

			# parse file and record results
			f.write(parseFile(curResultsFile, design))

			# don't forget the newline
			f.write('\n')
			
if __name__=="__main__":
	main()
