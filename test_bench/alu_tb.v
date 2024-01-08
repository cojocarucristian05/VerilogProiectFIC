`include "../code/alu.v"
`timescale 1ns/1ps

module ALU_tb;

  reg clk;
  reg rst_b;
  reg alu_enable;
  reg [5:0] opcode;
  reg [15:0] term1;
  reg [15:0] term2;
  wire [15:0] result;
  wire fl_zero;
  wire fl_negative;
  wire fl_carry;
  wire fl_overflow;
  wire done;

  // Instanțierea modulului ALU
  ALU alu_inst (
    .clk(clk),
    .rst_b(rst_b),
    .alu_enable(alu_enable),
    .opcode(opcode),
    .term1(term1),
    .term2(term2),
    .result(result),
    .fl_zero(fl_zero),
    .fl_negative(fl_negative),
    .fl_carry(fl_carry),
    .fl_overflow(fl_overflow),
    .done(done)
  );

  // Generarea impulsurilor de ceas
  initial begin
    clk = 0;
    rst_b = 1;
    alu_enable = 0;
    opcode = 6'b000000;
    term1 = 16'h0000;
    term2 = 16'h0000;
    $display("========== ARITHMETIC OPERATION ======");
    $display("alu_enable op\t    term1 term2\tresult");
    $display("%d\t   ADD\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 1: ADD
    alu_enable = 1;
    opcode = 6'b000000;
    term1 = 16'h0005;
    term2 = 16'h000A;
    #10;
    $display("%d\t   ADD\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 2: ADD
    alu_enable = 1;
    opcode = 6'b000000;
    term1 = -12;        // FFF4 = 1111 1111 1111 0100
    term2 = 10;   
    #10;
    $display("%d\t   ADD\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 3: SUB
    alu_enable = 1;
    opcode = 6'b000001;
    term1 = 16'h0010;
    term2 = 16'h000A;
    #10;
    $display("%d\t   SUB\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 4: MUL
    alu_enable = 1;
    opcode = 6'b000010;
    term1 = 16'h0005;
    term2 = 16'h000A;
    #10;
    $display("%d\t   MUL\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 5: MUL
    alu_enable = 1;
    opcode = 6'b000010;
    term1 = 16'hFFFF;
    term2 = 16'h000A;
    #10;
    $display("%d\t   MUL\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));
    // Add more test cases for other opcodes and scenarios...

    // Test Case 6: DIV
    alu_enable = 1;
    opcode = 6'b000011;
    term1 = 16'h001E;
    term2 = 16'h0003;
    #10;
    $display("%d\t   DIV\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 7: MOD
    alu_enable = 1;
    opcode = 6'b000100;
    term1 = 16'h001E;
    term2 = 16'h0003;
    #10;
    $display("%d\t   MOD\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    // Test Case 8: MOD
    alu_enable = 1;
    opcode = 6'b000100;
    term1 = 16'h001E;
    term2 = 16'h0007;
    #10;
    $display("%d\t   MOD\t%d %d %d", alu_enable, $signed(term1), $signed(term2), $signed(result));

    $display("\n========== LOGIC OPERATION ===========");
    $display("alu_enable op\t    term1\t      term2\t        result");
    
    // Test Case 9: AND
    alu_enable = 1;
    opcode = 6'b000101;
    term1 = 16'h00F0;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   AND\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 10: OR
    alu_enable = 1;
    opcode = 6'b000110;
    term1 = 16'h00F0;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   OR \t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 11: XOR
    alu_enable = 1;
    opcode = 6'b000111;
    term1 = 16'h00F0;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   XOR\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 12: NOT
    alu_enable = 1;
    opcode = 6'b001000;
    term1 = 16'h00F0;
    #10;
    $display("%d\t   NOT\t    %b  ----------------  %b", alu_enable, term1, result);

    // Test Case 13: CMP
    alu_enable = 1;
    opcode = 6'b001001;
    term1 = 16'h0030;
    term2 = 16'h0020;
    #10;
    $display("%d\t   CMP\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 14: MOV
    alu_enable = 1;
    opcode = 6'b001010;
    term2 = 16'h00AA;
    #10;
    $display("%d\t   MOV\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 15: RSR
    alu_enable = 1;
    opcode = 6'b001011;
    term1 = 4;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   RSR\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 16: RSL
    alu_enable = 1;
    opcode = 6'b001100;
    term1 = 4;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   RSL\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 17: LSR
    alu_enable = 1;
    opcode = 6'b001101;
    term1 = 4;
    term2 = 16'h0002;
    #10;
    $display("%d\t   LSR\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 18: LSL
    alu_enable = 1;
    opcode = 6'b001110;
    term1 = 4;
    term2 = 16'h0002;
    #10;
    $display("%d\t   LSL\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 19: TST
    alu_enable = 1;
    opcode = 6'b001111;
    term1 = 4;
    term2 = 16'h0F00;
    #10;
    $display("%d\t   TST\t    %b  %b  %b", alu_enable, term1, term2, result);

    // Test Case 20: Increment
    alu_enable = 1;
    opcode = 6'b010000;
    term1 = 16'h0001;
    #10;
    $display("%d\t   INC\t    %b  ----------------  %b", alu_enable, term1, result);

    // Test Case 21: Decrement
    alu_enable = 1;
    opcode = 6'b010001;
    term1 = 16'h0001;
    #10;
    $display("%d\t   DEC\t    %b  ----------------  %b", alu_enable, term1, result);

    $finish;
  end

endmodule
