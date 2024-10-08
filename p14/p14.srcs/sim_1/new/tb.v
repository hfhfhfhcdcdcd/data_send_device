`timescale 1ns/1ps
module tb ;
reg  sys_clk;
reg  rst_n;  
wire uart_tx ;

byte_send b1(
. sys_clk(sys_clk),
. rst_n  (rst_n  ),  
. uart_tx(uart_tx) 
);
/*-----------------sys_clk-----------------*/
initial 
    sys_clk=0;
    always #10 sys_clk=~sys_clk;
/*-------------------rst_n-----------------*/
initial begin
    rst_n=0;
    #201
    rst_n=1;
    #500_000_0;
    $stop;
end 


endmodule
