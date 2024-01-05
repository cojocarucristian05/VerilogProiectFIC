`include "cu.v"
`timescale 1ns / 1ps

module CU_tb;

    // Inputs
    reg clk;
    reg rst_b;
    reg [15:0] instruction;
    reg [15:0] pc;
    reg [15:0] x;
    reg [15:0] y;
    reg [15:0] sp;
    reg [15:0] acc;
    reg [15:0] lr;
    reg [15:0] pop_out;
    reg pop_done;
    reg push_done;
    reg [15:0] alu_out;
    reg alu_done;

    // Outputs
    wire [5:0] opcode;
    wire [15:0] pc_out;
    wire [15:0] x_out;
    wire [15:0] sp_out;
    wire [15:0] acc_out;
    wire [15:0] lr_out;
    wire register_write_enable;
    wire [15:0] address;
    wire [15:0] push_data;
    wire [15:0] write_enable;
    wire [15:0] read_enable;
    wire [15:0] term1;
    wire [15:0] term2;
    wire alu_enable;

    // Instantiate the CU module
    CU uut (
        .clk(clk),
        .rst_b(rst_b),
        .fl_zero(),
        .fl_negative(),
        .fl_carry(),
        .fl_overflow(),
        .instruction(instruction),
        .pc(pc),
        .x(x),
        .y(y),
        .sp(sp),
        .acc(acc),
        .lr(lr),
        .pop_out(pop_out),
        .pop_done(pop_done),
        .push_done(push_done),
        .alu_out(alu_out),
        .alu_done(alu_done),
        .opcode(opcode),
        .pc_out(pc_out),
        .x_out(x_out),
        .sp_out(sp_out),
        .acc_out(acc_out),
        .lr_out(lr_out),
        .register_write_enable(register_write_enable),
        .address(address),
        .push_data(push_data),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .term1(term1),
        .term2(term2),
        .alu_enable(alu_enable)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initial values
    initial begin
        rst_b = 1;
        instruction = 16'h0000;
        pc = 16'h0000;
        // Set other initial values as needed
    end

    // Test scenario
    initial begin
        // Apply inputs for the test scenario
        #10 instruction = 16'h1234;  // Replace with your desired instruction
        #10 rst_b = 0;               // Release reset

        // Add more test steps as needed

        #100 $stop;  // Stop the simulation after a certain period
    end

endmodule
