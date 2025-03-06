CXX       := g++
CXXFLAGS  := -std=c++14
CAPNP     := capnp
CAPNP_OPTS:= compile -oc++
CLANG_FMT := clang-format

LDFLAGS   := -lcapnp -lkj -lz
TARGET    := main

CPP_SRC   := main.cpp
CAPNP_SRC := capnp/PhysicalNetlist.capnp capnp/References.capnp
CAPNP_CPP := $(CAPNP_SRC:%=%.c++)
CAPNP_H   := $(CAPNP_SRC:%=%.h)

all: $(TARGET)

$(TARGET): $(CPP_SRC) $(CAPNP_CPP)
	$(CXX) $(CXXFLAGS) $(CPP_SRC) $(CAPNP_CPP) $(LDFLAGS) -o $(TARGET)

%.capnp.c++: %.capnp
	$(CAPNP) $(CAPNP_OPTS) $<

format:
	$(CLANG_FMT) -i $(CPP_SRC)

clean:
	rm -f $(TARGET) $(CAPNP_CPP) $(CAPNP_H)

.PHONY: all format clean
