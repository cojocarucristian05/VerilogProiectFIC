module IM
(
    input [15:0] PC,
    output reg [15:0] instruction
);
    integer file;
    reg [15:0] line;
    integer k;

    reg [15:0] instructions[255:0];
    initial begin
        file = $fopen("input.txt", "r");

        if(file) begin
        $display("Fisierul a fost deschis.\n");
        k = 0;

        while(!$feof(file)) begin
            $fscanf(file, "%b", line);
            $display("Valorile citite: %6b %10b", line[15:10], line[9:0]);

            instructions[k] <= line;
            k = k + 1;
        end
        $fclose(file);
        end
        else $display("Fisierul nu a fost deschis!\n");
    end

    always @(PC) begin 
        instruction <= instructions[PC];
    end

endmodule