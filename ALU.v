module ALU (
    output  wire             zero_flag,
    output  reg     [31:0]   ALUResult,
    input   wire    [31:0]   SrcA,
    input   wire    [31:0]   SrcB,
    input   wire    [2:0]    ALUControl
);

always @(*)
    begin
        case(ALUControl)
        3'b000 : ALUResult = SrcA & SrcB ;
        3'b001 : ALUResult = SrcA | SrcB ;
        3'b010 : ALUResult = SrcA + SrcB ;
        3'b100 : ALUResult = SrcA - SrcB ;
        3'b101 : ALUResult = SrcA * SrcB ;
        3'b110 : begin
                    if(SrcA < SrcB)
                        begin
                            ALUResult = 32'd1 ;
                        end
                    else
                        begin
                           ALUResult = 32'd0 ; 
                        end
                end
        default : ALUResult = 32'd0 ; 
        endcase
    end

assign zero_flag = (ALUResult == 32'd0) ;
endmodule