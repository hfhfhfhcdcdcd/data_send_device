module byte_send(
input sys_clk,
input rst_n,
output byte_send
);



send_byte s1(   
.sys_clk      (sys_clk )   ,
.rst_n        (rst_n   )   ,
.time_set     (time_set)   ,
.data         (data    )   ,
.send_en      (send_en )   ,
.uart_tx      (uart_tx )   ,
.tx_done      (tx_done) 
);

endmodule