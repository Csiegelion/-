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


module backwardskidbuffer#(parameter L=8)(
    input clk,
	input rst,
	
	output reg ready_f,
	input valid_f,
	input  [L-1:0] data_f,
	
	input  ready_b,
	output  reg valid_b,
	output  reg [L-1:0] data_b
	
);
    wire store;
   // reg tim;
	reg buffer_valid;
	reg [L-1:0] data_buffer;
	
	assign store =~ready_b && ready_f && valid_f;//�д�������ݣ�����û׼����
	always @(posedge clk or negedge rst) begin
	//tim=0;
		if (!rst)begin
			buffer_valid <= 1'b0;
			end
			
			else if(store) begin
			buffer_valid<=1'b1;
			end
			else if(ready_f) begin
			buffer_valid<=0'b0;
			end
		end
	/*always @(posedge clk or negedge rst) begin
	tim=0;
	#3 tim=1;
	end*/
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
		always @(*) begin
		data_b <= ready_f ? data_f : data_buffer; 
		valid_b <=  valid_f || buffer_valid ;
		end
		
	//assign  valid_b <= ready_f ? valid_f : buffer_valid;    
    //assign data_b <= ready_f ? data_f : data_buffer;
	/*	always@(posedge clk)begin
            if(!rst)
            valid_b <= 1'b0;
            else if(ready_f && valid_f)
            valid_b <= valid_f;
            else
            valid_b<=buffer_valid;
            end

		always@(posedge clk)begin
            if(!rst)
            data_b <=8'b0;
            else if(!valid_b)
            data_b <= data_b;
            else
            data_b = ready_f ? data_f : data_buffer;
            end*/

    

endmodule