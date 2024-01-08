`include "cu.v"
`timescale 1ns/1ps

module CU_tb;

  reg clk;
  reg rst_b;
  reg fl_zero;
  reg fl_negative;
  reg fl_carry;
  reg fl_overflow;
  reg [15:0] instruction;
  reg [15:0] imm;
  reg [9:0] pc;
  reg [15:0] pop_out;
  reg pop_done;
  reg push_done;
  reg [15:0] alu_out;
  reg alu_done;

  wire [5:0] opcode;
  wire [9:0] pc_out;
  wire register_write_enable;
  wire [15:0] address;
  wire [15:0] push_data;
  wire [15:0] write_enable;
  wire [15:0] read_enable;
  wire [15:0] term1;
  wire [15:0] term2;
  wire alu_enable;
  wire branch;

  // Instanțierea modulului CU
  CU cu_inst (
    .clk(clk),
    .rst_b(rst_b),
    .fl_zero(fl_zero),
    .fl_negative(fl_negative),
    .fl_carry(fl_carry),
    .fl_overflow(fl_overflow),
    .instruction(instruction),
    .imm(imm),
    .pc(pc),
    .pop_out(pop_out),
    .pop_done(pop_done),
    .push_done(push_done),
    .alu_out(alu_out),
    .alu_done(alu_done),
    .opcode(opcode),
    .pc_out(pc_out),
    .register_write_enable(register_write_enable),
    .address(address),
    .push_data(push_data),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .term1(term1),
    .term2(term2),
    .alu_enable(alu_enable),
    .branch(branch)
  );

  // Generarea impulsurilor de ceas
  initial begin
    $dumpfile("cu_sim_dump.vcd");
    $dumpvars(0, CU_tb);

    clk = 0;
    rst_b = 1;
    fl_zero = 0;
    fl_negative = 0;
    fl_carry = 0;
    fl_overflow = 0;
    instruction = 16'h0000;
    imm = 16'h0000;
    pc = 10'b0000000000;
    pop_out = 16'h0000;
    pop_done = 0;
    push_done = 0;
    alu_out = 16'h0000;
    alu_done = 0;

    // Test Case 1: LOAD
    instruction = 16'h010010;
    register_write_enable = 0;
    x = 16'h1234;
    y = 16'h5678;
    acc = 16'h0000;
    #10;
    $display("LOAD Test: %d %d %d", x, y, acc);

    // Test Case 2: STORE
    instruction = 16'h010011;
    register_write_enable = 1;
    x = 16'h1234;
    y = 16'h5678;
    acc = 16'h0000;
    #10;
    $display("STORE Test: %d %d %d", x, y, acc);

    // Add more test cases for other instructions...

    $finish;
  end

endmodule
