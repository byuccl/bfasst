|     **File**     |**Works with Conformal?**|**Works with Yosys?**|**LUTs**|**FFs**|**IOs**|**BUFGs**|               **Errors**                                       |
|------------------|-------------------------|---------------------|--------|-------|-------|---------|----------------------------------------------------------------|
|      alu         |         Yes             |         Yes         |  493   |   0   |  101  |    0    |                  None                                          |
|   buttoncount    |         Yes             |       **No**        |   -    |   -   |   -   |    -    | Has issues getting the proper led values                       |
|      calc        |         Yes             |         Yes         |  178   |   18  |   38  |    1    |                  None                                          |
|      debouncer   |         Yes             |       **No**        |    -   |   -   |   -   |    -    |                  None                                          |
|      lightWave   |         Yes             |         Yes         |   2    |   3   |   19  |    1    |                  None                                          |
|      mux8to1     |         Yes             |         Yes         |   -    |   -   |   -   |    -    |                  None                                          |
|     oneshot      |         Yes             |         Yes         |   2    |   2   |   2   |    1    |                  None                                          |
|     regfile      |         Yes             |        Yes          |   34   |   32  |   108 |    1    |                  None                                          |
| riscvSimpleDatapath |      **NO**          |       Yes           |  1198  |   32  |   201 |   12    | Relies on regfile, which already doesn't work in yosys         |
|  sevensegment    |         Yes             |         Yes         |   -    |   -   |   -   |    -    |                  None                                          |
|     shiftReg     |         Yes             |         Yes         |   51   |   20  |   36  |    1    |                  None                                          |
|      stopwatch   |         Yes             |       **No**        |    -   |   -   |   -   |    -    |                  None                                          |
|UpDownButtonCount |         Yes             |         Yes         |  48    |   24  |   38  |    1    |                  None                                          |
