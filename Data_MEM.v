module Data_MEM #( parameter mem_width =32, parameter mem_depth =100) (
    output  reg     [mem_width-1 : 0]        RD,
    output  reg     [(mem_width/2)-1 : 0]    test_value,
    input   wire    [31 : 0]                 A,
    input   wire    [mem_width-1 : 0]        WD,
    input   wire                             clk, rst, WE
);

reg     [mem_width-1 : 0]   RAM   [0 : mem_depth-1 ] ;
integer i;

always@(*)
    begin
        RD = RAM[A] ;
    end

always @(*)
    begin
        test_value = RAM[32'd0] ;
    end

always @(posedge clk, negedge rst)
    begin
        if(!rst)
            begin
                for(i=0 ; i != mem_depth ; i=i+1)
                    begin
                        RAM[i] <= { (mem_width) {1'b0}} ;
                    end
            end
        else 
            begin
                if(WE)
                    begin
                        RAM[A] <= WD ;
                    end
            end
    end
endmodule