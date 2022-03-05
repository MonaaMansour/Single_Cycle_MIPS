module PC #( parameter PC_width = 32) (
    output  reg   [PC_width-1 : 0]  PC,
    input   wire  [PC_width-1 : 0]  PC_old,
    input   wire                    rst,
    input   wire                    clk 
);

always @(posedge clk, negedge rst)
    begin
        if(!rst)
            begin
                PC <= { (PC_width) {1'b0} } ;
            end
        else
            begin
                PC <= PC_old ;
            end
    end

endmodule