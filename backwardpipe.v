`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/07 22:50:10
// Design Name: 
// Module Name: backwardpipe
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


module backwardpipe#(parameter L=8)(
    input clk,
	input rst,
	
	output reg ready_f,
	input valid_f,
	input  [L-1:0] data_f,
	
	input  ready_b,
	output valid_b,
	output  [L-1:0] data_b
	
);
    wire store;
	reg buffer_valid;
	reg [L-1:0] data_buffer;
	
	assign store =~ready_b && ready_f && valid_f;
	always @(posedge clk or negedge rst) begin
		if (!rst)begin
			buffer_valid <= 1'b0;
			end
			else begin
			buffer_valid<=buffer_valid? ~ready_b:store;
			end
		end
	
	always @(posedge clk or negedge rst) begin
		if (!rst)begin
			data_buffer <= {L{1'b0}};
			end
			else begin
			data_buffer<=store? data_f:data_buffer;
			end
		end
		always @(posedge clk or negedge rst) begin
		if (!rst)begin
			ready_f <= 1'b1;
			end
			else begin
			ready_f<=(~buffer_valid&&~store)||ready_b;
			end
		end
		/*always @(posedge clk or negedge rst) begin
		if (!rst)begin
			data_b <= {L{1'b0}};
			end
			else begin
			data_b <= ready_f ? data_f : data_buffer; 
			end
		end*/
	assign  valid_b = ready_f ? valid_f : buffer_valid;    
    assign data_b = ready_f ? data_f : data_buffer;
endmodule
