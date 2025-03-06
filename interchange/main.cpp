#include <capnp/serialize.h>
#include <kj/io.h>
#include <zlib.h>

#include <cassert>
#include <iostream>
#include <set>
#include <string>
#include <vector>

#include "capnp/PhysicalNetlist.capnp.h"

int main() {
  // using jpegencode for testing right now
  const char* filename = "jpegencode_phys.capnp";

  // open the GZIP compressed file (assuming GZIP compression since that's what
  // I think we've been generating and this worked in the python code)
  gzFile gz = gzopen(filename, "rb");
  if (!gz) {
    std::cerr << "Failed to open gzip file: " << filename << "\n";
    return 1;
  }

  // initialize buffer
  std::vector<char> buffer;
  char chunk[4096];
  int bytesRead;
  // read the whole file in in chunks, vector will resize if needed
  while ((bytesRead = gzread(gz, chunk, sizeof(chunk))) > 0) {
    buffer.insert(buffer.end(), chunk, chunk + bytesRead);
  }
  // close the file
  gzclose(gz);

  // double check that we didn't read in an empty file
  if (buffer.empty()) {
    std::cerr << "Decompressed file is empty.\n";
    return 1;
  }

  // calculate number of words in buffer (includes rounding up if needed)
  size_t wordCount =
      (buffer.size() + sizeof(capnp::word) - 1) / sizeof(capnp::word);
  // a pointer to the buffer as an array of capnp::word 's
  const capnp::word* words =
      reinterpret_cast<const capnp::word*>(buffer.data());

  // a kj array pointer. Not a memory manager but I think it it used to pass
  // around arrays with bound information
  kj::ArrayPtr<const capnp::word> arrayPtr(words, wordCount);

  // Create a FlatArrayMessageReader (some capnp class used for reading the
  // serialized data) using the decompressed data.
  capnp::FlatArrayMessageReader messageReader(arrayPtr);

  // get the top level struct
  auto netlist = messageReader.getRoot<PhysicalNetlist::PhysNetlist>();


  // successful run
  return 0;
}