`include "./component/cu.v"
`include "./component/alu.v"
`include "./component/sign_extend.v"
`include "./component/im.v"

module CPU
(
    input wire clk,
    input wire rst,
    input wire [15:0] imm,
    input wire [15:0] instr,
    input wire [5:0] opcode,
    output wire [7:0] readLen,
    output wire reg_write_en,
    output wire [3:0] reg_dest,
    output wire [5:0] writeData,
    output wire writeEnable,
    output wire push,
    output wire pop,
    output wire pop_done,
    output wire [15:0] dafa_in,
    output wire [15:0] address,
    output wire alu_done,
    output wire [15:0] alu_out,
    output wire zero,
    output wire negative,
    output wire carry,
    output wire overflow
);

    wire [7:0] flags;
    wire [9:0] pc;
    wire [15:0] pop_out;
    wire pop_done_int;
    wire push_done_int;
    wire [15:0] push_data;
    wire [15:0] write_enable;
    wire [15:0] read_enable;
    wire [15:0] term1;
    wire [15:0] term2;
    wire alu_enable;
    wire branch;

    reg x;
    reg y;
    reg acc;
    reg lr;
    reg sp;

    CU cu_inst (
        .clk(clk),
        .rst_b(rst),
        .fl_zero(zero),
        .fl_negative(negative),
        .fl_carry(carry),
        .fl_overflow(overflow),
        .instruction(instr),
        .imm(imm),
        .pc(pc),
        .pop_out(pop_out),
        .pop_done(pop_done_int),
        .push_done(push_done_int),
        .alu_out(alu_out),
        .alu_done(alu_done),
        .opcode(opcode[5:0]), // Adjust the width
        .pc_out(pc),
        .register_write_enable(reg_write_en),
        .address(address),
        .push_data(push_data),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .term1(term1),
        .term2(term2),
        .alu_enable(alu_enable),
        .branch(branch)
    );

    SIGN_EXTEND sign_extend_inst (
        .imm(imm[8:0]),
        .instruction(term1)
    );

    ALU alu_module (
        .clk(clk),
        .rst_b(rst),
        .alu_enable(alu_enable),
        .opcode(cu_inst.opcode),
        .term1(term1),
        .term2(term2),
        .result(alu_out),
        .fl_zero(zero),
        .fl_negative(negative),
        .fl_carry(carry),
        .fl_overflow(overflow),
        .done(alu_done)
    );

    IM instruction_memory(
        .PC(address),
        .instruction(instr)
    );

endmodule
