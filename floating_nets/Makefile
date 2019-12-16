ICESTORM := /home/jgoeders/icestorm

BITFILE := IF_stage_bitmap.bin
UNPACKED := unpacked.asc
REVERSED := reversed.v
EXPLAINED := explained.log
PCF := IF_stage_sbt.pcf

move_bit: $(BITFILE)


./$(BITFILE): proj/test_Implmnt/sbt/outputs/bitmap/$(BITFILE)
	cp proj/test_Implmnt/sbt/outputs/bitmap/$(BITFILE) $@

$(PCF): proj/test_Implmnt/sbt/outputs/placer/$(PCF)
	cp proj/test_Implmnt/sbt/outputs/placer/$(PCF) $@

unpack: $(UNPACKED)

$(UNPACKED): $(BITFILE) 
	$(ICESTORM)/icepack/iceunpack ./$(BITFILE) > $@

reverse: $(REVERSED) $(EXPLAINED)

$(REVERSED): $(UNPACKED) $(PCF) Makefile $(ICESTORM)/icebox/icebox_vlog.py
	$(ICESTORM)/icebox/icebox_vlog.py -D -s -P $(PCF) $< > $@

explain: $(EXPLAINED)

$(EXPLAINED): $(UNPACKED)
	$(ICESTORM)/icebox/icebox_explain.py  $< > $@
