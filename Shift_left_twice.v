module Shift_left_twice #( parameter IN_width= 32, parameter OUT_width= 32) (
    output  reg     [OUT_width-1  : 0]   OUT,
    input   wire    [IN_width-1   : 0]   IN
);
always @(*)
    begin
        OUT = IN<<2 ;
    end

endmodule