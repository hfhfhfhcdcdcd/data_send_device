module send_byte (                           
input sys_clk         ,          
input rst_n           ,          
input [2:0] time_set  ,   //����������������       
input [7:0] data      ,          
input send_en         ,          
output reg uart_tx    ,          
output reg tx_done  
    );
/*-----------------------����������-----------------------------*/
reg [31:0] cnt;//����������
reg [3:0] cnt2;//2����ʱ�� 
reg [31:0] time_cnt;

/*-----------------------����ʱ����-----------------------------*/ 
always@(*)
if(!rst_n)
    time_cnt<=434;
else 
    case(time_set)  
        0:time_cnt<=10416;                 //4800; 
        1:time_cnt<=5208;                  //9600; 
        2:time_cnt<=434;                   //115200;
        default:time_cnt<=434;             //115200;
    endcase
/*-----------------------����������-----------------------------*/
always@(posedge sys_clk or negedge rst_n)
if(!rst_n)
    cnt<=32'd0;
else if(send_en)
    if(cnt==time_cnt-1)
        cnt<=32'd0;
    else
        cnt<=cnt+1;
else//!send_en
    cnt<=32'd0;     
/*-----------------------2��������-----------------------------*/
always@(posedge sys_clk or negedge rst_n)
if(!rst_n)
    cnt2<=4'd0;//Ĭ�Ϸ�startλ
else if(send_en)begin
    if((cnt2>=0)&&(cnt2<10))begin
        if(cnt==time_cnt-1)
            cnt2<=cnt2+1;
        else  
            cnt2<=cnt2;
     end
     else if(cnt2==10)
        cnt2<=0;//cnt2������
     else  
            cnt2<=cnt2;
end
else //!send_en
    cnt2<=4'd0;
/*-----------------------uart_tx-----------------------------*/
always@(posedge sys_clk or negedge rst_n)
if(!rst_n)
    uart_tx<=0;
else if(send_en)
    case(cnt2)
        0: begin uart_tx<=0;  end                        
        1:  uart_tx<=data[0] ;                  
        2:  uart_tx<=data[1] ;                  
        3:  uart_tx<=data[2] ;                  
        4:  uart_tx<=data[3] ;                  
        5:  uart_tx<=data[4] ;                  
        6:  uart_tx<=data[5] ;                  
        7:  uart_tx<=data[6] ;                  
        8:  uart_tx<=data[7] ;                  
        9:  uart_tx<=1 ;       
        default:uart_tx<=1;    
      endcase
else//!send_en
    uart_tx<=uart_tx;                                          
/*-----------------------tx_done-----------------------------*/
always@(posedge sys_clk or negedge rst_n)
if(!rst_n)
    tx_done<=0;
else if(cnt2==9 && cnt == time_cnt-1)                                    
        tx_done<=1;     
else if(send_en)
        tx_done<=0;                
else
        tx_done<=0;
endmodule                                         
