module Instr_MEM #( parameter mem_width = 32, parameter mem_depth = 100) (
    output  reg    [mem_width-1: 0]    Instr,
    input   wire   [31         : 0]    PC
);

reg [mem_width-1 : 0]  ROM [0 : mem_depth-1] ;

initial 
    begin
        $readmemh("Program 2_Machine Code.txt", ROM) ;
    end
always @(*)
    begin
        Instr = ROM [PC>>2] ;
    end

endmodule