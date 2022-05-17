|     **File**     |**Works with Conformal?**|**Works with Yosys?**|**LUTs**|**FFs**|**IOs**|     **Other Components**      |                  **Errors**                     |
|------------------|-------------------------|---------------------|--------|-------|-------|-------------------------------|-------------------------------------------------|
|       add4       |         Yes             |         Yes         |   5    |   0   |   12  |    None                       |    None                                         |
|      add4_r      |         Yes             |         Yes         |   5    |   4   |   13  |    **BUFG:** 1                |    None                                         |
|    add4_r_rst    |         Yes             |         Yes         |   5    |   4   |   14  |    **BUFG:** 1                |    None                                         |
|    add8_r_rst    |         Yes             |         Yes         |   8    |   8   |   26  |    **BUFG:** 1 **CARRY4:** 2  |    None                                         |
|    add16_r_rst   |         Yes             |         Yes         |   16   |   16  |   50  |    **BUFG:** 1 **CARRY4:** 4  |    None                                         |
|    add32_r_rst   |         Yes             |         Yes         |   32   |   32  |   98  |    **BUFG:** 1 **CARRY4:** 8  |    None                                         |
|       and3       |         Yes             |         Yes         |   1    |   0   |   4   |    None                       |    None                                         |
|      and3_r      |         Yes             |         Yes         |   1    |   1   |   5   |    **BUFG:** 1                |    None                                         |
|    and3_r_rst    |         Yes             |         Yes         |   1    |   1   |   6   |    **BUFG:** 1                |    None                                         |
|   bram_dp_synch  |         Yes             |       **No**        |   0    |   10  |   24  |    **BUFG:** 1 **RAM32M:** 2  |    Isn't using Block RAM, 8 unproven cells      |
|   bram_sp_asynch |         Yes             |       **No**        |   0    |   0   |   15  |    **BUFG:** 1 **RAM32X1S:** 4|    Isn't using Block RAM, 4 unproven cells      |
|       ff         |         Yes             |         Yes         |   0    |   1   |   3   |    **BUFG:** 1                |    None                                         |
|       rom        |         Yes             |       **No**        |   0    |   0   |   28  |    **BUFG:** 1 **RAMB18E1:** 1|    20 unproven $equiv cells in Yosys            |