|     **File**     |**Works with Conformal?**|**Works with Yosys?**|**LUTs**|**FFs**|**IOs**|**BUFGs**|               **Errors**                                       |
|------------------|-------------------------|---------------------|--------|-------|-------|---------|----------------------------------------------------------------|
|UpDownButtonCount |         Yes             |         Yes         |  48    |   24  |   38  |    1    |                  None                                          |
|      alu         |         Yes             |         Yes         |  493   |   0   |  101  |    0    |                  None                                          |
|   buttoncount    |         Yes             |       **No**        |   -    |   -   |   -   |    -    | Has issues getting the proper led values                       |
|      calc        |         Yes             |         Yes         |  178   |   18  |   38  |    1    |                  None                                          |
|      mux8to1     |         Yes             |         Yes         |   -    |   -   |   -   |    -    |                  None                                          |
|     oneshot      |         Yes             |         Yes         |   2    |   2   |   2   |    1    |                  None                                          |
|     regfile      |         Yes             |       **No**        |   -    |   -   |   -   |    -    |  Writedata and the array of registers produce the wrong output.|
|  sevensegment    |         Yes             |         Yes         |   -    |   -   |   -   |    -    |                  None                                          |
|     shiftReg     |         Yes             |         Yes         |   51   |   20  |   36  |    1    |                  None                                          |
