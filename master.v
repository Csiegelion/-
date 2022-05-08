`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/07 22:37:46
// Design Name: 
// Module Name: master
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


module  master#( parameter L= 8)(
	input clk,
	input rst,
	input ven,
	input ready,
	output reg valid,
	
	output reg [L-1:0] data_out
	
);
reg[7:0] rand;
 always@(posedge clk) begin
      rand <= $random(); //不指定随机种子
   end
always @(posedge clk or negedge rst) begin
		if (!rst) begin
			valid <= 1'b0;
		end
		else begin
			valid <= ven;
		end
	end
always @(posedge clk or negedge rst) begin
		if (!rst) begin
			data_out <= {L{1'b0}};
		end
		else if (valid & ready) begin
			data_out <= rand;
		end
		else begin data_out<= data_out;
		end
	end
	
endmodule
