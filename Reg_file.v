module Reg_file #( parameter reg_file_width=32, parameter reg_file_depth=32 ) (
    output  reg     [reg_file_width-1 : 0]           RD1, RD2,
    input   wire    [$clog2 (reg_file_depth) -1:0]   A1, A2, A3,
    input   wire                                     rst,
    input   wire                                     clk,
    input   wire                                     WE,
    input   wire    [reg_file_width-1 : 0]           WD3
);

reg     [reg_file_width-1 : 0]  reg_file  [0 : reg_file_depth-1] ;
integer    i;

always @(*)
    begin
        RD1 = reg_file [A1] ;
    end

always @(*)
    begin
        RD2 = reg_file [A2] ;
    end

always @(posedge clk, negedge rst)
    begin
        if(!rst)
            begin
                for (i = 0 ; i != reg_file_depth ; i=i+1 ) 
                    begin
                        reg_file[i] <={ (reg_file_width) {1'b0} } ;
                    end
            end 
        else
            begin
                if(WE)
                    begin
                        reg_file[A3] <= WD3 ;
                    end
            end    
    end

endmodule
