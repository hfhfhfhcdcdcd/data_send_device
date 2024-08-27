module byte_send(
input sys_clk,
input rst_n,
output uart_tx
);

reg [7:0] data        ;
reg send_en           ;
wire tx_done           ;

send_byte s1(   
.sys_clk      (sys_clk )   ,
.rst_n        (rst_n   )   ,
.time_set     (2)   ,
.data         (data    )   ,//之前是在tb文件里面给data，send_en，现在是在顶层模块给                            
.send_en      (send_en )   ,//顶层模块就是负责给子模块赋值的
.uart_tx      (uart_tx )   ,
.tx_done      (tx_done) 
);
/*--------------变量的声明-------------------*/
reg [31:0] cnt_10ms;
parameter time_10ms = 500_000;
/*-------------- 1 0 ms ---------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_10ms<=0;
    end
    else if (cnt_10ms==time_10ms-1) begin
        cnt_10ms<=0;
    end
    else
        cnt_10ms<=cnt_10ms+1;
end
/*--------------send_en--------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        send_en<=0;
    end
    else if (cnt_10ms==time_10ms-1) begin
        send_en<=1'b1;
    end
    else if (tx_done) begin
        send_en<=0;
    end
    else
        send_en<=send_en;
end
/*--------------data--------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        data<=0;
    end
    else if (send_en) begin
        data<=data;
    end
    else if (tx_done) begin
        data<=data+1;
    end
    else
        data<=data;
end
endmodule