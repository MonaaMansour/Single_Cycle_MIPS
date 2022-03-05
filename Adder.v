module Adder (
    output  reg     [31:0]  C,
    input   wire    [31:0]  A,
    input   wire    [31:0]  B
);

always @(*)
    begin
        C = A+B ;
    end

endmodule