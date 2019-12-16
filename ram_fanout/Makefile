ICESTORM := /home/jgoeders/icestorm

BITFILE := mem_a_bitmap.bin
UNPACKED := unpacked.asc
REVERSED := reversed.v
EXPLAINED := explained.log
PCF := mem_a_sbt.pcf

move_bit: $(BITFILE)


./$(BITFILE): proj/ram_fanout/ram_fanout_Implmnt/sbt/outputs/bitmap/$(BITFILE)
	cp proj/ram_fanout/ram_fanout_Implmnt/sbt/outputs/bitmap/$(BITFILE) $@

$(PCF): proj/ram_fanout/ram_fanout_Implmnt/sbt/outputs/placer/$(PCF)
	cp proj/ram_fanout/ram_fanout_Implmnt/sbt/outputs/placer/$(PCF) $@

unpack: $(UNPACKED)

$(UNPACKED): $(BITFILE) 
	$(ICESTORM)/icepack/iceunpack ./$(BITFILE) > $@

reverse: $(REVERSED) $(EXPLAINED)

$(REVERSED): $(UNPACKED) $(PCF)
	$(ICESTORM)/icebox/icebox_vlog.py -s -P $(PCF) $< > $@

explain: $(EXPLAINED)

$(EXPLAINED): $(UNPACKED)
	$(ICESTORM)/icebox/icebox_explain.py  $< > $@
