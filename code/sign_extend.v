module SIGN_EXTEND
(
    input [8:0] imm,
    output [15:0] instruction
);

assign instruction = {{7{imm[8]}},imm};
endmodule