module CU
(
    input clk,
    input rst_b,
    input fl_zero,
    input fl_negative,
    input fl_carry,
    input fl_overflow,
    input [15:0] instruction,
    input [15:0] imm,
    input [9:0] pc,
    input [15:0] pop_out,
    input pop_done,
    input push_done,
    input [15:0] alu_out,
    input alu_done,
    output reg [5:0] opcode,
    output reg [9:0] pc_out,
    output reg register_write_enable,
    output reg [15:0] address,
    output reg [15:0] push_data,
    output reg [15:0] write_enable,
    output reg [15:0] read_enable,
    output reg [15:0] term1,
    output reg [15:0] term2,
    output reg alu_enable,
    output reg branch
);

reg register_bit;
reg [15:0] x;
reg [15:0] y;
reg [15:0] acc;
reg [9:0] lr;
reg [15:0] sp;

always @(*) begin
    branch = 0;
    opcode = instruction[15:10];
    register_bit = instruction[9];
    term1 = instruction[8:0];
    if (opcode <= 17) begin
        term1 = acc;
        if (register_bit == 0)
            term2 = x;
        else
            term2 = y;
        alu_enable = 1;
    end
    case(opcode)
        6'b010010: begin                         //LOAD
            if (register_bit == 0)
                acc = x;
            else
                acc = y;
        end
        6'b010011: begin                         //STORE
            if (register_bit == 0)
                x = acc;
            else
                y = acc;
        end
        6'b011010: begin                         //INP
            acc = imm;
        end
        6'b011011: begin                         //OUT
            $display("%d", acc);
        end
        6'b100000: begin                         //BRZ
            branch = fl_zero;
        end
        6'b100001: begin                         //BRN
            branch = fl_negative;
        end
        6'b100010: begin                         //BRC
            branch = fl_carry;
        end
        6'b100011: begin                         //BRO
            branch = fl_overflow;
        end
        6'b100100: begin                         //BRA
            branch = 1;
        end
        6'b100101: begin                         //JMP
            branch = 1;
            lr = pc;
        end
        6'b100110: begin                         //RET
            branch = 0;
            pc_out = lr;
        end
    endcase
    if (opcode >= 32 && opcode <= 37) begin
       pc_out = imm;
    end
end
endmodule