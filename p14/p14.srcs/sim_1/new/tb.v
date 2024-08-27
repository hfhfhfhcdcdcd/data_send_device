`timescale 1ns / 1ps
module tb;
reg sys_clk            ;
reg rst_n              ;
reg [2:0] time_set    ;
reg [7:0]  data        ;
reg send_en            ;
wire uart_tx           ;
wire tx_done           ;
/*---------------------------����-------------------------*/
send_byte s1(
       .sys_clk    (sys_clk)           ,
       .rst_n      (rst_n  )           ,
       .time_set   (time_set)          ,
       .data       (data   )           ,
       .send_en    (send_en)           ,
       .uart_tx    (uart_tx)           ,
       .tx_done    (tx_done)
    );
/*----------------------------ʱ�ӳ�ʼ��------------------------------------*/
initial 
sys_clk=0;
always #10 sys_clk=~sys_clk;
/*----------------------------����˿ڳ�ʼ��-------------------*/
initial begin
rst_n   =0;  
time_set=2;  
data    =8'd0;  
send_en =0;
#201;
rst_n   =1;   
#100;
/*------- 1 �� -----*/
data=8'b0101_0101;
send_en=1;
@(posedge tx_done)
send_en=0;
/*------- 2 �� -----*/
#20000;
data=8'b0000_1111;
send_en=1;
@(posedge tx_done)
send_en=0;
/*------- 3 �� -----*/
#20000;
data=8'b1111_1111;
send_en=1;
@(posedge tx_done)
send_en=0;
//��β
#20000;
send_en=1;
#20000;
$stop;
end
endmodule
