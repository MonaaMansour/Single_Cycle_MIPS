module Datapath #(parameter Instr_width=32, ReadData_width=32, ALUOut_width=32, WriteData_width=32, PC_width = 32) ( 
    output  wire    [ALUOut_width-1    : 0]     ALUOut,
    output  wire    [WriteData_width-1 : 0]     WriteData,
    output  wire    [PC_width-1        : 0]     PC,
    output  wire                                zero_flag,
    input   wire    [ReadData_width-1  : 0]     ReadData,
    input   wire    [Instr_width-1     : 0]     Instr,
    input   wire    [2:0]                       ALUControl,
    input   wire                                clk, rst, ALUSrc, RegDst, RegWrite, Jump, PCSrc, MemtoReg
);

wire [ALUOut_width-1 : 0]   SrcA, SrcB, Result, SignImm, SignImm_shift ;
wire [PC_width-1     : 0]   PC_old, MUXOut2, PCPlus4, PCBranch;
wire [4 : 0]                WriteReg; 


Reg_file U0 (
    .RD1(SrcA),
    .RD2(WriteData),
    .A1(Instr[25:21]),
    .A2(Instr[20:16]),
    .A3(WriteReg),
    .WD3(Result),
    .WE(RegWrite),
    .clk(clk),
    .rst(rst)
);

ALU U1 (
    .zero_flag(zero_flag),
    .ALUResult(ALUOut),
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl)
);

MUX MUX_ALU (
    .OUT(SrcB),
    .IN1(WriteData),
    .IN2(SignImm),
    .sel(ALUSrc)
);

MUX #(.width(5)) MUX_regfile (
    .OUT(WriteReg),
    .IN1(Instr[20:16]),
    .IN2(Instr[15:11]),
    .sel(RegDst)
);

MUX MUX_datamem(
    .OUT(Result),
    .IN1(ALUOut),
    .IN2(ReadData),
    .sel(MemtoReg)
);

MUX MUX_PC1 (
    .OUT(PC_old),
    .IN1(MUXOut2),
    .IN2( { PCPlus4[31:28] , Instr[25:0] , {2'b00} } ),
    .sel(Jump)
);

MUX MUX_PC2 (
    .OUT(MUXOut2),
    .IN1(PCPlus4),
    .IN2(PCBranch),
    .sel(PCSrc)
);

Adder Adder_4 (
    .C(PCPlus4),
    .A(PC),
    .B(32'd4)
);

Adder Adder_Branch (
    .C(PCBranch),
    .A(SignImm_shift),
    .B(PCPlus4)
);

Sign_Extend SE (
    .Instr(Instr[15:0]),
    .SignImm(SignImm)
);

Shift_left_twice S2 (
    .OUT(SignImm_shift),
    .IN(SignImm)
);

PC #(.PC_width(PC_width)) pc (
    .PC(PC),
    .PC_old(PC_old),
    .rst(rst),
    .clk(clk)
);

endmodule