module ALU
(
    input clk,
    input rst_b,
    input alu_enable,
    input [5:0] opcode,
    input [15:0] term1,
    input [15:0] term2,
    output reg [15:0] result,
    output reg fl_zero,
    output reg fl_negative,
    output reg fl_carry,
    output reg fl_overflow,
    output reg done
);

always @(negedge rst_b) begin
    result <= 0;
end

always @(*) begin
    // wire aux;
    if(alu_enable) begin
        done = 0;
        case(opcode)
            6'b000000:  result = term1 + term2; //ADD
            6'b000001:  result = term1 - term2; //SUB
            6'b000010:  result = term1 * term2; //MUL
            6'b000011:  result = term1 / term2; //DIV
            6'b000100:  result = term1 % term2; //MOD
            6'b000101:  result = term1 & term2; //AND
            6'b000110:  result = term1 | term2; //OR
            6'b000111:  result = term1 ^ term2; //XOR
            6'b001000:  result = ~term1;        //NOT
            6'b001001:  result = term1 - term2;    //CMP
            6'b001010:  result = term2;           //MOV
            6'b001011:  result = (term2 >> term1) | (term2 << (16'h10 - term1));   //RSR
            6'b001100:  result = (term2 << term1) | (term2 >> (16'h10 - term1));   //RSL
            6'b001101:  result = term1 >> term2;     //LSR
            6'b001110:  result = term1 << term2;     //LSL
            6'b001111:  result = (term1 >> term2) & 1;      //TST
            6'b010000:  result = term1 + 1;             // INC
            6'b010001:  result = term1 - 1;             // DEC
            default: result = term1; 
        endcase
        fl_zero = (result == 16'h0000);
        fl_negative = (result[15] == 1);
        if (opcode == 6'b001001) 
            result = term1;
        done = 1;
    end
end
endmodule