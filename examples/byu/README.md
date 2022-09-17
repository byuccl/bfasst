**Main Tests**

|     **File**     |**Works with Conformal?**|**Works with Yosys?**|**LUTs**|**FFs**|**IOs**|     **Other Components**     |               **Errors**                  |
|------------------|-------------------------|---------------------|--------|-------|-------|------------------------------|-------------------------------------------|
|      alu         |         Yes             |         Yes         |  546   |   0   |  101  |    **CARRY4:** 20            |    None                                   |
|   buttoncount    |         Yes             |       **No**        |   5    |   20  |   19  |    **BUFG:** 1 **CARRY4:** 4 | Has issues getting the proper led values  |
|      calc        |         Yes             |         Yes         |  199   |   18  |   38  |    **BUFG:** 1 **CARRY4:** 12 **MUXF7:** 3    |   None                   |
|    debouncer     |         Yes             |       **No**        |   11   |   21  |   4   |    **BUFG:** 1 **CARRY4:** 5 |    None                                   |
|    lightWave     |         Yes             |         Yes         |   3    |   3   |   19  |    **BUFG:** 1               |    None                                   |
|     mux8to1      |         Yes             |         Yes         |   16   |   0   |   75  |    **MUXF7:** 8              |    None                                   |
|     oneshot      |         Yes             |         Yes         |   3    |   2   |   4   |    **BUFG:** 1               |    None                                   |
|     regfile      |         Yes             |       **No**        |   612  |   0   |   112 |    **BUFG:** 12 **MUXF7:** 256 **MUXF8:** 128    | Writedata and the array of registers produce the wrong output |
| riscvSimpleDatapath |    **No**            |       **No**        |  1361  |  1088 |   201 |   **BUFG:** 1 **CARRY4:** 28 **MUXF7:** 258 **MUXF8:** 124    | Relies on regfile, which already doesn't work in Yosys         |
|   sevensegment   |         Yes             |         Yes         |   7    |   0   |   11  |    None                      |    None                                   |
|    shiftReg      |         Yes             |         Yes         |   59   |   20  |   36  |    **BUFG:** 1               |    None                                   |
|    stopwatch     |         Yes             |       **No**        |   45   |   52  |   15  |    **BUFG:** 1 **CARRY4:** 10|    None                                   |
| UpDownButtonCount|         Yes             |         Yes         |   49   |   24  |   38  |    **BUFG:** 1 **CARRY4:** 12|    None                                   |
| riscv_final      |         **No**          |    **No**           |   958  |   365 |   229 |  **LUTRAM:** 48  **BUFG:** 1 | 33 Outputs and 136 FFs are incorrect      |
| rx               |         **No**          |    **No**           |   19   |   31  |   14  |   **BUFG:** 1                | 6 FFs are unequivalent                    |
| tx               |         **No**          |    **No**           |   20   |   23  |   13  |   **BUFG:** 1                |    3 FFs are not Equivalent               |


**Tests with Waveform Comparison Tool**

|     **File**     | **Works with Tool?** |               **Possible Causes of Errors**                  |
|------------------|----------------------|--------------------------------------------------------------|
|        alu       |          Yes         |                       None                                   |
| buttoncount      |          Yes         |                       None                                   |
| calc             |          Yes         |                       None                                   |
| debouncer        |          Yes         |                       None                                   |
| lightWave        |          Yes         |                       None                                   |
| mux8to1          |          Yes         |                       None                                   |
| oneshot          |          **No**      |  Oneshot has a clk signal as it's first signal, this may be a potential cause |
| regfile          |          Yes         |  For some reason, the part wont change and it has too many IOs  |
| riscvSimpleDatapath |       **No**      |    Similar to Oneshot                                        |
| sevensegment     |          Yes         |                       None                                   |
| shiftReg         |          Yes         |                       None                                   |
|  stopwatch       |          ???         | It comes back as equivalent, but the anode signal never changes. Needs to be further looked at. |
| UpDownButtonCount |     **No**          |      Similar issues to oneshot                               |
| riscv_final      |  **No**              |     Similar to Oneshot                                       |
|   rx             |          Yes         |                       None                                   |
|   tx             |       **No**         |    Requires further analysis                                 |