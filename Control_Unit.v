module Control_Unit (
    output  reg                       MemtoReg, MemWrite,  
    output  reg                       ALUSrc, RegDst, RegWrite, 
    output  reg            [2:0]      ALUControl,
    output  reg                       Jump,
    output  wire                      PCSrc,
    input   wire           [5:0]      Opcode, Funct,
    input   wire                      zero_flag
    
);

reg     [1:0]   ALUOp  ;
reg             Branch ;

assign PCSrc = Branch & zero_flag ;

always @(*)
    begin
        Jump     = 1'b0 ;
        MemWrite = 1'b0 ;
        RegWrite = 1'b0 ;
        RegDst   = 1'b0 ;
        ALUSrc   = 1'b0 ;
        MemtoReg = 1'b0 ;
        Branch   = 1'b0 ;
        ALUOp    = 2'b00;
        case(Opcode)
        6'b10_0011 : begin
                        RegWrite = 1'b1 ;
                        ALUSrc   = 1'b1 ;
                        MemtoReg = 1'b1 ;
                     end
        6'b10_1011 : begin
                        MemWrite = 1'b1 ;
                        ALUSrc   = 1'b1 ;
                        MemtoReg = 1'b1 ;
                     end
        6'b00_0000 : begin
                        ALUOp    = 2'b10 ;
                        RegWrite = 1'b1 ;
                        RegDst   = 1'b1 ;
                     end
        6'b00_1000 : begin
                        RegWrite = 1'b1 ;
                        ALUSrc   = 1'b1 ;
                     end
        6'b00_0100 : begin
                        ALUOp    = 2'b01 ;
                        Branch   = 1'b1 ;
                     end
        6'b00_0010 : begin
                        Jump     = 1'b1 ;
                     end
        default    : begin
                        Jump     = 1'b0 ;
                        MemWrite = 1'b0 ;
                        RegWrite = 1'b0 ;
                        RegDst   = 1'b0 ;
                        ALUSrc   = 1'b0 ;
                        MemtoReg = 1'b0 ;
                        Branch   = 1'b0 ;
                        ALUOp    = 2'b00;
                     end        
        endcase     

    end

always @(*)
    begin
        case (ALUOp)
        2'b00 : ALUControl = 3'b010 ;
        2'b01 : ALUControl = 3'b100 ;
        2'b10 : begin
                    case(Funct)
                    6'b10_0000 : ALUControl = 3'b010 ;
                    6'b10_0010 : ALUControl = 3'b100 ;
                    6'b10_1010 : ALUControl = 3'b110 ;
                    6'b01_1100 : ALUControl = 3'b101 ;
                    default    : ALUControl = 3'b010 ;
                    endcase
                end
        default: ALUControl = 3'b010 ;
        endcase        
    end

endmodule