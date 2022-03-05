module MIPS #(parameter Instr_width=32, ReadData_width=32, ALUOut_width=32, WriteData_width=32, PC_width = 32) (
    output  wire    [(ReadData_width/2)-1 : 0]  test_value,
    input   wire                                clk, rst
);

wire    [ALUOut_width-1    : 0]     ALUOut ;
wire    [WriteData_width-1 : 0]     WriteData;
wire    [PC_width-1        : 0]     PC ;
wire                                zero_flag ;
wire    [ReadData_width-1  : 0]     ReadData ;
wire    [Instr_width-1     : 0]     Instr ;
wire    [2:0]                       ALUControl ;
wire                                ALUSrc, RegDst, RegWrite, Jump, PCSrc, MemtoReg, MemWrite ;


Datapath DP (
    .ALUOut(ALUOut),
    .WriteData(WriteData),
    .PC(PC),
    .zero_flag(zero_flag),
    .ReadData(ReadData),
    .Instr(Instr),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst), 
    .RegWrite(RegWrite), 
    .ALUControl(ALUControl), 
    .Jump(Jump), 
    .PCSrc(PCSrc), 
    .MemtoReg(MemtoReg),
    .clk(clk),
    .rst(rst)
);

Control_Unit CU (
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .RegWrite(RegWrite),
    .ALUControl(ALUControl), 
    .Jump(Jump), 
    .PCSrc(PCSrc), 
    .MemtoReg(MemtoReg), 
    .MemWrite(MemWrite),
    .Opcode(Instr[31:26]), 
    .Funct(Instr[5:0]),
    .zero_flag(zero_flag)
);

Instr_MEM IM (
    .Instr(Instr),
    .PC(PC)
);

Data_MEM DM (
    .RD(ReadData),
    .A(ALUOut),
    .WD(WriteData),
    .test_value(test_value),
    .WE(MemWrite),
    .clk(clk),
    .rst(rst)
);

endmodule