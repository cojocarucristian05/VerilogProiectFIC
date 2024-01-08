`include "../component/cu.v"
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
    wire register_bit;
    reg [15:0] x;
    reg [15:0] y;
    reg [15:0] acc;
    reg [9:0] lr;
    reg [15:0] sp;

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
    instruction = 16'h4834;
    x = 16'h1234;
    y = 16'h4321;
    acc = 16'h0000;
    #10;
    $display("LOAD Test: %h %h %h", x, y, acc);

    // Test Case 2: STORE
    instruction = 16'h4F11;
    x = 16'h1234;
    y = 16'h4321;
    acc = 16'h0000;
    #10;
    $display("STORE Test: %h %h %h", x, y, acc);

    // Test Case 3: INP
    instruction = 16'h6812;
    imm = 16'h00A5; // Some input data
    #10;
    $display("INP Test: %h", acc);

    // Test Case 4: OUT
    instruction = 16'h6C12;
    #10;
    $display("OUT Test: instruction=%h acc=%h", instruction, acc);

    // Test Case 5: BRZ
    instruction = 16'h8012;
    fl_zero = 1;
    #10;
    $display("BRZ Test: instruction=%h fl_zero=%b branch=%b", instruction, fl_zero, branch);

    // Test Case 6: BRN
    instruction = 16'h8412;
    fl_negative = 1;
    #10;
    $display("BRN Test: instruction=%h fl_negative=%b branch=%b", instruction, fl_negative, branch);

    // Test Case 7: BRC
    instruction = 16'h8812;
    fl_carry = 1;
    #10;
    $display("BRC Test: instruction=%h fl_carry=%b branch=%b", instruction, fl_carry, branch);

    // Test Case 8: BRO
    instruction = 16'h8C12;
    fl_overflow = 1;
    #10;
    $display("BRO Test: instruction=%h fl_overflow=%b branch=%b", instruction, fl_overflow, branch);

    // Test Case 9: BRA
    instruction = 16'h9012;
    #10;
    $display("BRA Test: instruction=%h branch=%b", instruction, branch);

    // Test Case 10: JMP
    instruction = 16'h9412;
    #10;
    $display("JMP Test: instruction=%h branch=%b lr=%h", instruction, branch, lr);

    $finish;
  end

endmodule
