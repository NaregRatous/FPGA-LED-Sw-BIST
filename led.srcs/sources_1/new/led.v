`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/28 15:04:30
// Design Name: 
// Module Name: led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led(
    input sys_clk,
    input rst_n,
    input [3:0] sw,
    output reg [3:0] led
    );
reg[31:0] timer_cnt=0;
reg sclk = 0;

always@(posedge sys_clk)
begin
  timer_cnt <=timer_cnt + 1;
  if(timer_cnt > 25_999_999)
    begin
      timer_cnt <= 0;
      sclk <= ~sclk;
    end
end

reg flag = 0;
always@(posedge sys_clk)
begin
  if(sw == 4'b1111)
    flag =0;
  else
    flag = 1;

end
integer i=0;
always@(posedge sclk)
begin
  if(flag == 0)
  begin
    if(i<4)
      begin
        led <={1'b1, led[3:1]}; //shift one in right direction
        i <= i +1;
      end
    else if(i<8)
      begin
        led <={led[2:0], 1'b0};
        i <= i+1;
      end
    else
      begin
        i <=0;
        led <=4'b1000;
      end
  end
  else
    led <= sw;
    
end

////Instantiate ila in source file
//ila ila_inst(
//  .clk(sys_clk),
//  .probe0(timer_cnt),
//  .probe1(led)
//  );

endmodule
