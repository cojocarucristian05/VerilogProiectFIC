`include "cpu.v"
`timescale 1ns/1ps

module CPU_TB;

  reg clk;
  reg rst;
  reg [15:0] imm;
  reg [15:0] instr;
  reg [5:0] opcode;
  wire [7:0] readLen;
  wire reg_write_en;
  wire [3:0] reg_dest;
  wire [5:0] writeData;
  wire writeEnable;
  wire push;
  wire pop;
  wire pop_done;
  wire [15:0] dafa_in;
  wire [15:0] address;
  wire alu_done;
  wire [15:0] alu_out;
  wire zero;
  wire negative;
  wire carry;
  wire overflow;

  CPU cpu_inst (
    .clk(clk),
    .rst(rst),
    .imm(imm),
    .instr(instr),
    .opcode(opcode),
    .readLen(readLen),
    .reg_write_en(reg_write_en),
    .reg_dest(reg_dest),
    .writeData(writeData),
    .writeEnable(writeEnable),
    .push(push),
    .pop(pop),
    .pop_done(pop_done),
    .dafa_in(dafa_in),
    .address(address),
    .alu_done(alu_done),
    .alu_out(alu_out),
    .zero(zero),
    .negative(negative),
    .carry(carry),
    .overflow(overflow)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    // Initialize inputs
    rst = 1;
    imm = 16'h1234;
    instr = 16'h0100; // Example instruction, adjust as needed
    opcode = 6'b010010; // Example opcode, adjust as needed

    // Apply reset
    #10 rst = 0;

    // Wait for a few clock cycles
    #20;

    // Apply test scenario
    // You can modify the inputs and timing as needed for your specific tests
    imm = 16'h5678;
    instr = 16'h0111; // Another example instruction
    opcode = 6'b010011; // Another example opcode
    #50;

    // Add more test scenarios as needed

    // Finish simulation
    $stop;
  end

endmodule
