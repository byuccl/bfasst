
 add_fsm_encoding \
       {spi_ctl.spiif_cs} \
       { }  \
       {{0000 000} {0001 001} {0010 010} {0011 011} {0100 100} {0101 101} {1111 110} }

 add_fsm_encoding \
       {uart_txfsm.txstate} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} }

 add_fsm_encoding \
       {uart_rxfsm.rxstate} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} {101 101} }
