module MUX #(parameter width = 32) (
    output  reg     [width-1 : 0]   OUT,
    input   wire    [width-1 : 0]   IN1,
    input   wire    [width-1 : 0]   IN2,
    input   wire                    sel
);

always @(*)
    begin
        if(sel == 1'b0)
            begin
                OUT = IN1 ;
            end
        else
            begin
                OUT = IN2 ;
            end    
    end

endmodule