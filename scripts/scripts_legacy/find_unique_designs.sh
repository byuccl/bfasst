#!/bin/bash

DIRS=$(ls -d */)

for d_i in $DIRS; do

		echo "Looking at dir $d_i"
		
		for d_j in $DIRS; do

				if [ $d_i = $d_j ]; then
						continue
				fi

				NUM_DIFFS=$(diff -rq $d_i $d_j -x "*.yaml" | wc -l)
				
				if [ $NUM_DIFFS -eq 0 ]; then
						echo "  probably matches $d_j"
				fi
				
		done
		
done
