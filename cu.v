module CU
(
    input clk,
    input rst_b,
    input fl_zero,
    input fl_negative,
    input fl_carry,
    input fl_overflow,
    input [15:0] instrunction,
    input [15:0] pc,
    input [15:0] x,
    input [15:0] y,
    input [15:0] sp,
    input [15:0] acc,
    input [15:0] lr,
    input [15:0] pop_out,
    input pop_done,
    input push_done,
    input [15:0] alu_out,
    input alu_done,
    output reg [5:0] opcode,
    output reg [15:0] pc_out,
    output reg [15:0] x_out,
    output reg [15:0] sp_out,
    output reg [15:0] acc_out,
    output reg [15:0] lr_out,
    output reg register_write_enable,
    output reg [15:0] address,
    output reg [15:0] push_data,
    output reg [15:0] write_enable,
    output reg [15:0] read_enable,
    output reg [15:0] term1,
    output reg [15:0] term2,
    output reg alu_enable
);
endmodule

always @(*) begin
    
end