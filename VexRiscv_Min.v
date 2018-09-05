// Generator : SpinalHDL v1.1.6    git head : 2643ea2afba86dc6321cd50da8126412cf13d7ec
// Date      : 06/09/2018, 01:17:42
// Component : VexRiscv_Min


`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_PC_INCREMENT 2'b10

`define EnvCtrlEnum_binary_sequancial_type [1:0]
`define EnvCtrlEnum_binary_sequancial_NONE 2'b00
`define EnvCtrlEnum_binary_sequancial_EBREAK 2'b01
`define EnvCtrlEnum_binary_sequancial_MRET 2'b10

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

module StreamFifoLowLatency (
      input   io_push_valid,
      output  io_push_ready,
      input   io_push_payload_error,
      input  [31:0] io_push_payload_inst,
      output  io_pop_valid,
      input   io_pop_ready,
      output reg  io_pop_payload_error,
      output reg [31:0] io_pop_payload_inst,
      input   io_flush,
      output [0:0] io_occupancy,
      input   clk,
      input   reset);
  wire  _zz_5;
  reg  _zz_6;
  wire [0:0] _zz_7;
  reg  _zz_1;
  reg  pushPtr_willIncrement;
  reg  pushPtr_willClear;
  wire  pushPtr_willOverflowIfInc;
  wire  pushPtr_willOverflow;
  reg  popPtr_willIncrement;
  reg  popPtr_willClear;
  wire  popPtr_willOverflowIfInc;
  wire  popPtr_willOverflow;
  wire  ptrMatch;
  reg  risingOccupancy;
  wire  empty;
  wire  full;
  wire  pushing;
  wire  popping;
  wire [32:0] _zz_2;
  wire [32:0] _zz_3;
  reg [32:0] _zz_4;
  assign io_push_ready = _zz_5;
  assign io_pop_valid = _zz_6;
  assign _zz_7 = _zz_2[0 : 0];
  always @ (*) begin
    _zz_1 = 1'b0;
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      _zz_1 = 1'b1;
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
      popPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = 1'b1;
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = 1'b1;
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  assign ptrMatch = 1'b1;
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && _zz_5);
  assign popping = (_zz_6 && io_pop_ready);
  assign _zz_5 = (! full);
  always @ (*) begin
    if((! empty))begin
      _zz_6 = 1'b1;
      io_pop_payload_error = _zz_7[0];
      io_pop_payload_inst = _zz_2[32 : 1];
    end else begin
      _zz_6 = io_push_valid;
      io_pop_payload_error = io_push_payload_error;
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign _zz_2 = _zz_3;
  assign io_occupancy = (risingOccupancy && ptrMatch);
  assign _zz_3 = _zz_4;
  always @ (posedge clk) begin
    if(reset) begin
      risingOccupancy <= 1'b0;
    end else begin
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_1)begin
      _zz_4 <= {io_push_payload_inst,io_push_payload_error};
    end
  end

endmodule

module VexRiscv_Min (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input  [31:0] externalInterruptArray,
      output  iBusWishbone_CYC,
      output  iBusWishbone_STB,
      input   iBusWishbone_ACK,
      output  iBusWishbone_WE,
      output [29:0] iBusWishbone_ADR,
      input  [31:0] iBusWishbone_DAT_MISO,
      output [31:0] iBusWishbone_DAT_MOSI,
      output [3:0] iBusWishbone_SEL,
      input   iBusWishbone_ERR,
      output [1:0] iBusWishbone_BTE,
      output [2:0] iBusWishbone_CTI,
      output  dBusWishbone_CYC,
      output  dBusWishbone_STB,
      input   dBusWishbone_ACK,
      output  dBusWishbone_WE,
      output [29:0] dBusWishbone_ADR,
      input  [31:0] dBusWishbone_DAT_MISO,
      output [31:0] dBusWishbone_DAT_MOSI,
      output reg [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset);
  wire  _zz_157;
  wire  _zz_158;
  reg [31:0] _zz_159;
  reg [31:0] _zz_160;
  wire  _zz_161;
  wire  _zz_162;
  reg [31:0] _zz_163;
  wire  _zz_164;
  wire  _zz_165;
  wire  _zz_166;
  wire [31:0] _zz_167;
  wire [0:0] _zz_168;
  wire  _zz_169;
  wire  _zz_170;
  wire  _zz_171;
  wire  _zz_172;
  wire  _zz_173;
  wire  _zz_174;
  wire  _zz_175;
  wire [1:0] _zz_176;
  wire  _zz_177;
  wire [1:0] _zz_178;
  wire [1:0] _zz_179;
  wire [2:0] _zz_180;
  wire [31:0] _zz_181;
  wire [2:0] _zz_182;
  wire [0:0] _zz_183;
  wire [2:0] _zz_184;
  wire [0:0] _zz_185;
  wire [2:0] _zz_186;
  wire [0:0] _zz_187;
  wire [2:0] _zz_188;
  wire [0:0] _zz_189;
  wire [2:0] _zz_190;
  wire [0:0] _zz_191;
  wire [0:0] _zz_192;
  wire [0:0] _zz_193;
  wire [0:0] _zz_194;
  wire [0:0] _zz_195;
  wire [0:0] _zz_196;
  wire [0:0] _zz_197;
  wire [0:0] _zz_198;
  wire [0:0] _zz_199;
  wire [0:0] _zz_200;
  wire [2:0] _zz_201;
  wire [11:0] _zz_202;
  wire [11:0] _zz_203;
  wire [31:0] _zz_204;
  wire [31:0] _zz_205;
  wire [31:0] _zz_206;
  wire [31:0] _zz_207;
  wire [1:0] _zz_208;
  wire [31:0] _zz_209;
  wire [1:0] _zz_210;
  wire [1:0] _zz_211;
  wire [31:0] _zz_212;
  wire [32:0] _zz_213;
  wire [19:0] _zz_214;
  wire [11:0] _zz_215;
  wire [11:0] _zz_216;
  wire [2:0] _zz_217;
  wire [3:0] _zz_218;
  wire [4:0] _zz_219;
  wire [31:0] _zz_220;
  wire [0:0] _zz_221;
  wire [0:0] _zz_222;
  wire [0:0] _zz_223;
  wire [0:0] _zz_224;
  wire [0:0] _zz_225;
  wire [0:0] _zz_226;
  wire [6:0] _zz_227;
  wire [0:0] _zz_228;
  wire  _zz_229;
  wire [1:0] _zz_230;
  wire [1:0] _zz_231;
  wire  _zz_232;
  wire [0:0] _zz_233;
  wire [15:0] _zz_234;
  wire [31:0] _zz_235;
  wire  _zz_236;
  wire  _zz_237;
  wire [31:0] _zz_238;
  wire [31:0] _zz_239;
  wire [0:0] _zz_240;
  wire [0:0] _zz_241;
  wire [0:0] _zz_242;
  wire [0:0] _zz_243;
  wire  _zz_244;
  wire [0:0] _zz_245;
  wire [11:0] _zz_246;
  wire [31:0] _zz_247;
  wire [31:0] _zz_248;
  wire [31:0] _zz_249;
  wire  _zz_250;
  wire [0:0] _zz_251;
  wire [1:0] _zz_252;
  wire [0:0] _zz_253;
  wire [0:0] _zz_254;
  wire [2:0] _zz_255;
  wire [2:0] _zz_256;
  wire  _zz_257;
  wire [0:0] _zz_258;
  wire [8:0] _zz_259;
  wire [31:0] _zz_260;
  wire [31:0] _zz_261;
  wire [31:0] _zz_262;
  wire  _zz_263;
  wire [31:0] _zz_264;
  wire [31:0] _zz_265;
  wire [31:0] _zz_266;
  wire [31:0] _zz_267;
  wire  _zz_268;
  wire [0:0] _zz_269;
  wire [0:0] _zz_270;
  wire [0:0] _zz_271;
  wire [0:0] _zz_272;
  wire [1:0] _zz_273;
  wire [1:0] _zz_274;
  wire  _zz_275;
  wire [0:0] _zz_276;
  wire [6:0] _zz_277;
  wire [31:0] _zz_278;
  wire [31:0] _zz_279;
  wire [31:0] _zz_280;
  wire [31:0] _zz_281;
  wire [31:0] _zz_282;
  wire [31:0] _zz_283;
  wire [31:0] _zz_284;
  wire [31:0] _zz_285;
  wire [31:0] _zz_286;
  wire [31:0] _zz_287;
  wire  _zz_288;
  wire [0:0] _zz_289;
  wire [0:0] _zz_290;
  wire [0:0] _zz_291;
  wire [0:0] _zz_292;
  wire  _zz_293;
  wire [0:0] _zz_294;
  wire [4:0] _zz_295;
  wire [0:0] _zz_296;
  wire [1:0] _zz_297;
  wire  _zz_298;
  wire [1:0] _zz_299;
  wire [1:0] _zz_300;
  wire  _zz_301;
  wire [0:0] _zz_302;
  wire [0:0] _zz_303;
  wire [31:0] _zz_304;
  wire [31:0] _zz_305;
  wire [31:0] _zz_306;
  wire [31:0] _zz_307;
  wire [31:0] _zz_308;
  wire [31:0] _zz_309;
  wire [31:0] _zz_310;
  wire [31:0] _zz_311;
  wire [31:0] _zz_312;
  wire [0:0] _zz_313;
  wire [1:0] _zz_314;
  wire [31:0] _zz_315;
  wire [31:0] _zz_316;
  wire [31:0] _zz_317;
  wire  _zz_318;
  wire [0:0] _zz_319;
  wire [10:0] _zz_320;
  wire [31:0] _zz_321;
  wire [31:0] _zz_322;
  wire [31:0] _zz_323;
  wire  _zz_324;
  wire [0:0] _zz_325;
  wire [4:0] _zz_326;
  wire [31:0] _zz_327;
  wire [31:0] _zz_328;
  wire [31:0] _zz_329;
  wire [31:0] _zz_330;
  wire [31:0] _zz_331;
  wire  decode_SRC_USE_SUB_LESS;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_1;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_2;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_3;
  wire  decode_CSR_READ_OPCODE;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_4;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_5;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_6;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  execute_BRANCH_DO;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_7;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_8;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_9;
  wire [31:0] decode_RS1;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_10;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_11;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_12;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_13;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_14;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_15;
  wire  decode_CSR_WRITE_OPCODE;
  wire [31:0] execute_BRANCH_CALC;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_16;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_17;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_18;
  wire [31:0] decode_RS2;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [31:0] memory_PC;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_19;
  wire `AluCtrlEnum_binary_sequancial_type _zz_20;
  wire `AluCtrlEnum_binary_sequancial_type _zz_21;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire  decode_IS_CSR;
  wire  _zz_22;
  wire  _zz_23;
  wire `EnvCtrlEnum_binary_sequancial_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_24;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_25;
  wire [31:0] execute_PC;
  wire [31:0] execute_RS1;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_26;
  wire  _zz_27;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] _zz_28;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_29;
  wire  _zz_30;
  wire [31:0] _zz_31;
  wire [31:0] _zz_32;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_33;
  wire `Src2CtrlEnum_binary_sequancial_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_34;
  wire [31:0] _zz_35;
  wire `Src1CtrlEnum_binary_sequancial_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_36;
  wire [31:0] _zz_37;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_38;
  wire [31:0] _zz_39;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_40;
  wire [31:0] _zz_41;
  wire  _zz_42;
  reg  _zz_43;
  wire [31:0] _zz_44;
  wire [31:0] _zz_45;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_46;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_47;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_48;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_49;
  wire  _zz_50;
  wire  _zz_51;
  wire  _zz_52;
  wire  _zz_53;
  wire  _zz_54;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_55;
  wire  _zz_56;
  wire  _zz_57;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_58;
  wire  _zz_59;
  wire  _zz_60;
  wire `AluCtrlEnum_binary_sequancial_type _zz_61;
  wire  _zz_62;
  reg [31:0] _zz_63;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_64;
  wire [1:0] _zz_65;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  _zz_66;
  reg [31:0] _zz_67;
  wire [31:0] _zz_68;
  wire  _zz_69;
  wire [31:0] _zz_70;
  wire [31:0] _zz_71;
  wire [31:0] _zz_72;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  wire [31:0] decode_INSTRUCTION /* verilator public */ ;
  reg  decode_arbitration_haltItself /* verilator public */ ;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  reg  decode_arbitration_flushAll /* verilator public */ ;
  wire  decode_arbitration_redoIt;
  wire  decode_arbitration_isValid /* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  reg  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  wire  execute_arbitration_redoIt;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  reg  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  reg  memory_arbitration_flushAll;
  wire  memory_arbitration_redoIt;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  wire  writeBack_arbitration_redoIt;
  reg  writeBack_arbitration_isValid /* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring /* verilator public */ ;
  wire  _zz_73;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  wire [31:0] iBus_cmd_payload_pc;
  wire  iBus_rsp_valid;
  wire  iBus_rsp_payload_error;
  wire [31:0] iBus_rsp_payload_inst;
  wire  decode_exception_agregat_valid;
  wire [3:0] decode_exception_agregat_payload_code;
  wire [31:0] decode_exception_agregat_payload_badAddr;
  wire  _zz_74;
  wire [31:0] _zz_75;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_76;
  reg [31:0] _zz_77;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_78;
  wire  IBusSimplePlugin_jump_pcLoad_valid;
  wire [31:0] IBusSimplePlugin_jump_pcLoad_payload;
  wire [1:0] _zz_79;
  wire  _zz_80;
  wire  IBusSimplePlugin_fetchPc_preOutput_valid;
  wire  IBusSimplePlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusSimplePlugin_fetchPc_preOutput_payload;
  wire  _zz_81;
  wire  IBusSimplePlugin_fetchPc_output_valid;
  wire  IBusSimplePlugin_fetchPc_output_ready;
  wire [31:0] IBusSimplePlugin_fetchPc_output_payload;
  reg [31:0] IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusSimplePlugin_fetchPc_inc;
  reg [31:0] IBusSimplePlugin_fetchPc_pc;
  reg  IBusSimplePlugin_fetchPc_samplePcNext;
  reg  _zz_82;
  wire  IBusSimplePlugin_iBusRsp_input_valid;
  wire  IBusSimplePlugin_iBusRsp_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_input_payload;
  wire  IBusSimplePlugin_iBusRsp_inputPipeline_0_valid;
  reg  IBusSimplePlugin_iBusRsp_inputPipeline_0_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_inputPipeline_0_payload;
  wire  _zz_83;
  reg  _zz_84;
  reg [31:0] _zz_85;
  reg  IBusSimplePlugin_iBusRsp_readyForError;
  wire  IBusSimplePlugin_iBusRsp_output_valid;
  wire  IBusSimplePlugin_iBusRsp_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire  IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire  IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire  IBusSimplePlugin_injector_decodeInput_valid;
  wire  IBusSimplePlugin_injector_decodeInput_ready;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire  IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire  IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg  _zz_86;
  reg [31:0] _zz_87;
  reg  _zz_88;
  reg [31:0] _zz_89;
  reg  _zz_90;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_0;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_1;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_2;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_3;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_4;
  reg  IBusSimplePlugin_injector_decodeRemoved;
  reg [31:0] IBusSimplePlugin_injector_formal_rawInDecode;
  reg [2:0] IBusSimplePlugin_pendingCmd;
  wire [2:0] IBusSimplePlugin_pendingCmdNext;
  wire  _zz_91;
  reg [2:0] IBusSimplePlugin_rsp_discardCounter;
  wire [31:0] IBusSimplePlugin_rsp_fetchRsp_pc;
  reg  IBusSimplePlugin_rsp_fetchRsp_rsp_error;
  wire [31:0] IBusSimplePlugin_rsp_fetchRsp_rsp_inst;
  wire  IBusSimplePlugin_rsp_fetchRsp_isRvc;
  wire  IBusSimplePlugin_rsp_issueDetected;
  wire  _zz_92;
  wire  _zz_93;
  wire  IBusSimplePlugin_rsp_join_valid;
  wire  IBusSimplePlugin_rsp_join_ready;
  wire [31:0] IBusSimplePlugin_rsp_join_payload_pc;
  wire  IBusSimplePlugin_rsp_join_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_rsp_join_payload_rsp_inst;
  wire  IBusSimplePlugin_rsp_join_payload_isRvc;
  wire  _zz_94;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [1:0] dBus_cmd_payload_size;
  wire  dBus_rsp_ready;
  wire  dBus_rsp_error;
  wire [31:0] dBus_rsp_data;
  reg [31:0] _zz_95;
  reg [3:0] _zz_96;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_97;
  reg [31:0] _zz_98;
  wire  _zz_99;
  reg [31:0] _zz_100;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [22:0] _zz_101;
  wire  _zz_102;
  wire  _zz_103;
  wire  _zz_104;
  wire  _zz_105;
  wire  _zz_106;
  wire `AluCtrlEnum_binary_sequancial_type _zz_107;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_108;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_109;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_110;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_111;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_112;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_113;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_114;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_115;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_116;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_117;
  reg [31:0] _zz_118;
  wire  _zz_119;
  reg [19:0] _zz_120;
  wire  _zz_121;
  reg [19:0] _zz_122;
  reg [31:0] _zz_123;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_124;
  reg  _zz_125;
  reg  _zz_126;
  reg  _zz_127;
  reg [4:0] _zz_128;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_129;
  reg  _zz_130;
  reg  _zz_131;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  _zz_132;
  reg [10:0] _zz_133;
  wire  _zz_134;
  reg [19:0] _zz_135;
  wire  _zz_136;
  reg [18:0] _zz_137;
  reg [31:0] _zz_138;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  wire [1:0] CsrPlugin_misa_base;
  wire [25:0] CsrPlugin_misa_extensions;
  reg [31:0] CsrPlugin_mtvec;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mbadaddr;
  reg [63:0] CsrPlugin_mcycle = 64'b1010110011011010001110101110011111000111011010000010001010111011;
  reg [63:0] CsrPlugin_minstret = 64'b1010111111101001110011000011001001001000011111010000001001110010;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_writeBackWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  _zz_139;
  reg  execute_CsrPlugin_illegalAccess;
  wire [31:0] execute_CsrPlugin_writeSrc;
  reg [31:0] execute_CsrPlugin_readData;
  reg  execute_CsrPlugin_readDataRegValid;
  reg [31:0] execute_CsrPlugin_writeData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  wire [11:0] execute_CsrPlugin_csrAddress;
  reg [31:0] _zz_140;
  reg [31:0] _zz_141;
  wire [31:0] _zz_142;
  reg `AluCtrlEnum_binary_sequancial_type decode_to_execute_ALU_CTRL;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [31:0] decode_to_execute_RS2;
  reg `ShiftCtrlEnum_binary_sequancial_type decode_to_execute_SHIFT_CTRL;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_IS_CSR;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg `EnvCtrlEnum_binary_sequancial_type decode_to_execute_ENV_CTRL;
  reg [31:0] memory_to_writeBack_MEMORY_READ_DATA;
  reg `Src1CtrlEnum_binary_sequancial_type decode_to_execute_SRC1_CTRL;
  reg [31:0] decode_to_execute_RS1;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type decode_to_execute_ALU_BITWISE_CTRL;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  execute_to_memory_BRANCH_DO;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg `Src2CtrlEnum_binary_sequancial_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg `BranchCtrlEnum_binary_sequancial_type decode_to_execute_BRANCH_CTRL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  wire  _zz_143;
  reg  _zz_144;
  reg [31:0] _zz_145;
  wire  _zz_146;
  wire  _zz_147;
  wire  _zz_148;
  wire [31:0] _zz_149;
  reg  _zz_150;
  reg  _zz_151;
  reg  _zz_152;
  reg [31:0] _zz_153;
  reg [31:0] _zz_154;
  reg [1:0] _zz_155;
  reg [3:0] _zz_156;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign iBusWishbone_CYC = _zz_161;
  assign dBusWishbone_WE = _zz_162;
  assign _zz_169 = (CsrPlugin_exception || CsrPlugin_interruptJump);
  assign _zz_170 = (! execute_arbitration_isStuckByOthers);
  assign _zz_171 = (IBusSimplePlugin_fetchPc_preOutput_valid && IBusSimplePlugin_fetchPc_preOutput_ready);
  assign _zz_172 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_173 = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  assign _zz_174 = (! _zz_150);
  assign _zz_175 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET));
  assign _zz_176 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_177 = execute_INSTRUCTION[13];
  assign _zz_178 = (_zz_79 & (~ _zz_179));
  assign _zz_179 = (_zz_79 - (2'b01));
  assign _zz_180 = {IBusSimplePlugin_fetchPc_inc,(2'b00)};
  assign _zz_181 = {29'd0, _zz_180};
  assign _zz_182 = (IBusSimplePlugin_pendingCmd + _zz_184);
  assign _zz_183 = (iBus_cmd_valid && iBus_cmd_ready);
  assign _zz_184 = {2'd0, _zz_183};
  assign _zz_185 = iBus_rsp_valid;
  assign _zz_186 = {2'd0, _zz_185};
  assign _zz_187 = (iBus_rsp_valid && (IBusSimplePlugin_rsp_discardCounter != (3'b000)));
  assign _zz_188 = {2'd0, _zz_187};
  assign _zz_189 = iBus_rsp_valid;
  assign _zz_190 = {2'd0, _zz_189};
  assign _zz_191 = _zz_101[2 : 2];
  assign _zz_192 = _zz_101[3 : 3];
  assign _zz_193 = _zz_101[6 : 6];
  assign _zz_194 = _zz_101[7 : 7];
  assign _zz_195 = _zz_101[10 : 10];
  assign _zz_196 = _zz_101[11 : 11];
  assign _zz_197 = _zz_101[12 : 12];
  assign _zz_198 = _zz_101[13 : 13];
  assign _zz_199 = _zz_101[14 : 14];
  assign _zz_200 = execute_SRC_LESS;
  assign _zz_201 = (3'b100);
  assign _zz_202 = execute_INSTRUCTION[31 : 20];
  assign _zz_203 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_204 = ($signed(_zz_205) + $signed(_zz_209));
  assign _zz_205 = ($signed(_zz_206) + $signed(_zz_207));
  assign _zz_206 = execute_SRC1;
  assign _zz_207 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_208 = (execute_SRC_USE_SUB_LESS ? _zz_210 : _zz_211);
  assign _zz_209 = {{30{_zz_208[1]}}, _zz_208};
  assign _zz_210 = (2'b01);
  assign _zz_211 = (2'b00);
  assign _zz_212 = (_zz_213 >>> 1);
  assign _zz_213 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_214 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_215 = execute_INSTRUCTION[31 : 20];
  assign _zz_216 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_217 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_218 = {1'd0, _zz_217};
  assign _zz_219 = execute_INSTRUCTION[19 : 15];
  assign _zz_220 = {27'd0, _zz_219};
  assign _zz_221 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_222 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_223 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_224 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_225 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_226 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_227 = ({3'd0,_zz_156} <<< _zz_149[1 : 0]);
  assign _zz_228 = _zz_80;
  assign _zz_229 = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000001000000));
  assign _zz_230 = {((decode_INSTRUCTION & _zz_235) == (32'b00000000000000000001000000000000)),_zz_106};
  assign _zz_231 = (2'b00);
  assign _zz_232 = ({_zz_106,{_zz_236,_zz_237}} != (3'b000));
  assign _zz_233 = ((_zz_238 == _zz_239) != (1'b0));
  assign _zz_234 = {({_zz_240,_zz_241} != (2'b00)),{(_zz_242 != _zz_243),{_zz_244,{_zz_245,_zz_246}}}};
  assign _zz_235 = (32'b00000000000000000001000000000000);
  assign _zz_236 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_237 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_238 = (decode_INSTRUCTION & (32'b00000000000000000111000001010100));
  assign _zz_239 = (32'b00000000000000000101000000010000);
  assign _zz_240 = ((decode_INSTRUCTION & _zz_247) == (32'b01000000000000000001000000010000));
  assign _zz_241 = ((decode_INSTRUCTION & _zz_248) == (32'b00000000000000000001000000010000));
  assign _zz_242 = ((decode_INSTRUCTION & _zz_249) == (32'b00000000000000000000000000000000));
  assign _zz_243 = (1'b0);
  assign _zz_244 = ({_zz_250,{_zz_251,_zz_252}} != (4'b0000));
  assign _zz_245 = ({_zz_253,_zz_254} != (2'b00));
  assign _zz_246 = {(_zz_255 != _zz_256),{_zz_257,{_zz_258,_zz_259}}};
  assign _zz_247 = (32'b01000000000000000011000001010100);
  assign _zz_248 = (32'b00000000000000000111000001010100);
  assign _zz_249 = (32'b00000000000000000000000001010000);
  assign _zz_250 = ((decode_INSTRUCTION & _zz_260) == (32'b00000000000000000000000000000000));
  assign _zz_251 = (_zz_261 == _zz_262);
  assign _zz_252 = {_zz_102,_zz_263};
  assign _zz_253 = (_zz_264 == _zz_265);
  assign _zz_254 = (_zz_266 == _zz_267);
  assign _zz_255 = {_zz_268,{_zz_269,_zz_270}};
  assign _zz_256 = (3'b000);
  assign _zz_257 = ({_zz_271,_zz_272} != (2'b00));
  assign _zz_258 = (_zz_273 != _zz_274);
  assign _zz_259 = {_zz_275,{_zz_276,_zz_277}};
  assign _zz_260 = (32'b00000000000000000000000001000100);
  assign _zz_261 = (decode_INSTRUCTION & (32'b00000000000000000000000000011000));
  assign _zz_262 = (32'b00000000000000000000000000000000);
  assign _zz_263 = ((decode_INSTRUCTION & _zz_278) == (32'b00000000000000000001000000000000));
  assign _zz_264 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_265 = (32'b00000000000000000010000000000000);
  assign _zz_266 = (decode_INSTRUCTION & (32'b00000000000000000101000000000000));
  assign _zz_267 = (32'b00000000000000000001000000000000);
  assign _zz_268 = ((decode_INSTRUCTION & _zz_279) == (32'b00000000000000000000000001000000));
  assign _zz_269 = (_zz_280 == _zz_281);
  assign _zz_270 = (_zz_282 == _zz_283);
  assign _zz_271 = (_zz_284 == _zz_285);
  assign _zz_272 = (_zz_286 == _zz_287);
  assign _zz_273 = {_zz_106,_zz_288};
  assign _zz_274 = (2'b00);
  assign _zz_275 = ({_zz_289,_zz_290} != (2'b00));
  assign _zz_276 = (_zz_291 != _zz_292);
  assign _zz_277 = {_zz_293,{_zz_294,_zz_295}};
  assign _zz_278 = (32'b00000000000000000101000000000100);
  assign _zz_279 = (32'b00000000000000000000000001000100);
  assign _zz_280 = (decode_INSTRUCTION & (32'b01000000000000000000000000110000));
  assign _zz_281 = (32'b01000000000000000000000000110000);
  assign _zz_282 = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_283 = (32'b00000000000000000010000000010000);
  assign _zz_284 = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_285 = (32'b00000000000000000000000000100000);
  assign _zz_286 = (decode_INSTRUCTION & (32'b00000000000000000000000001010100));
  assign _zz_287 = (32'b00000000000000000000000001000000);
  assign _zz_288 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_289 = _zz_106;
  assign _zz_290 = _zz_105;
  assign _zz_291 = _zz_103;
  assign _zz_292 = (1'b0);
  assign _zz_293 = ({_zz_106,{_zz_105,{_zz_296,_zz_297}}} != (5'b00000));
  assign _zz_294 = (_zz_104 != (1'b0));
  assign _zz_295 = {(_zz_298 != (1'b0)),{(_zz_299 != _zz_300),{_zz_301,{_zz_302,_zz_303}}}};
  assign _zz_296 = ((decode_INSTRUCTION & _zz_304) == (32'b00000000000000000001000000010000));
  assign _zz_297 = {(_zz_305 == _zz_306),(_zz_307 == _zz_308)};
  assign _zz_298 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100));
  assign _zz_299 = {(_zz_309 == _zz_310),(_zz_311 == _zz_312)};
  assign _zz_300 = (2'b00);
  assign _zz_301 = (_zz_103 != (1'b0));
  assign _zz_302 = ({_zz_313,_zz_314} != (3'b000));
  assign _zz_303 = (_zz_102 != (1'b0));
  assign _zz_304 = (32'b00000000000000000001000000010000);
  assign _zz_305 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_306 = (32'b00000000000000000010000000010000);
  assign _zz_307 = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_308 = (32'b00000000000000000000000000010000);
  assign _zz_309 = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_310 = (32'b00000000000000000001000001010000);
  assign _zz_311 = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_312 = (32'b00000000000000000010000001010000);
  assign _zz_313 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000));
  assign _zz_314 = {((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100)),((decode_INSTRUCTION & (32'b00000000000000000011000000000100)) == (32'b00000000000000000001000000000000))};
  assign _zz_315 = (32'b00000000000000000010000001111111);
  assign _zz_316 = (decode_INSTRUCTION & (32'b00000000001000000000000001111111));
  assign _zz_317 = (32'b00000000000000000000000001101111);
  assign _zz_318 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_319 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011));
  assign _zz_320 = {((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_321) == (32'b00000000000000000100000001100011)),{(_zz_322 == _zz_323),{_zz_324,{_zz_325,_zz_326}}}}}};
  assign _zz_321 = (32'b00000000000000000100000101111111);
  assign _zz_322 = (decode_INSTRUCTION & (32'b00000000000000000010000101111111));
  assign _zz_323 = (32'b00000000000000000000000001100011);
  assign _zz_324 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000000000001100111));
  assign _zz_325 = ((decode_INSTRUCTION & (32'b11111110000000000000000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_326 = {((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & (32'b11111100000000000011000001111111)) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & _zz_327) == (32'b00000000000000000101000000110011)),{(_zz_328 == _zz_329),(_zz_330 == _zz_331)}}}};
  assign _zz_327 = (32'b10111110000000000111000001111111);
  assign _zz_328 = (decode_INSTRUCTION & (32'b10111110000000000111000001111111));
  assign _zz_329 = (32'b00000000000000000000000000110011);
  assign _zz_330 = (decode_INSTRUCTION & (32'b11111111111111111111111111111111));
  assign _zz_331 = (32'b00110000001000000000000001110011);
  always @ (posedge clk) begin
    if(_zz_43) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_114) begin
      _zz_159 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_115) begin
      _zz_160 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rsp_rspBuffer ( 
    .io_push_valid(_zz_157),
    .io_push_ready(_zz_164),
    .io_push_payload_error(iBus_rsp_payload_error),
    .io_push_payload_inst(iBus_rsp_payload_inst),
    .io_pop_valid(_zz_165),
    .io_pop_ready(_zz_93),
    .io_pop_payload_error(_zz_166),
    .io_pop_payload_inst(_zz_167),
    .io_flush(_zz_158),
    .io_occupancy(_zz_168),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_228)
      1'b0 : begin
        _zz_163 = _zz_77;
      end
      default : begin
        _zz_163 = _zz_75;
      end
    endcase
  end

  assign decode_SRC_USE_SUB_LESS = _zz_53;
  assign decode_BRANCH_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign decode_CSR_READ_OPCODE = _zz_22;
  assign decode_SRC2_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_56;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_60;
  assign execute_BRANCH_DO = _zz_27;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_39;
  assign decode_ALU_BITWISE_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign decode_RS1 = _zz_45;
  assign decode_SRC1_CTRL = _zz_10;
  assign _zz_11 = _zz_12;
  assign memory_MEMORY_READ_DATA = _zz_64;
  assign decode_ENV_CTRL = _zz_13;
  assign _zz_14 = _zz_15;
  assign decode_CSR_WRITE_OPCODE = _zz_23;
  assign execute_BRANCH_CALC = _zz_25;
  assign decode_SRC_LESS_UNSIGNED = _zz_52;
  assign decode_MEMORY_ENABLE = _zz_50;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_68;
  assign decode_SHIFT_CTRL = _zz_16;
  assign _zz_17 = _zz_18;
  assign decode_RS2 = _zz_44;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_65;
  assign memory_PC = execute_to_memory_PC;
  assign decode_ALU_CTRL = _zz_19;
  assign _zz_20 = _zz_21;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign decode_IS_CSR = _zz_59;
  assign execute_ENV_CTRL = _zz_24;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_BRANCH_CTRL = _zz_26;
  assign decode_RS2_USE = _zz_54;
  assign decode_RS1_USE = _zz_51;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_28 = execute_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_haltItself = 1'b0;
    memory_arbitration_flushAll = 1'b0;
    _zz_76 = 1'b0;
    _zz_77 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_172)begin
      _zz_28 = _zz_124;
      if(_zz_170)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
    if(_zz_169)begin
      _zz_76 = 1'b1;
      _zz_77 = CsrPlugin_mtvec;
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_175)begin
      if(_zz_173)begin
        execute_arbitration_haltItself = 1'b1;
      end else begin
        _zz_76 = 1'b1;
        _zz_77 = CsrPlugin_mepc;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_readDataRegValid)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_28 = execute_CsrPlugin_readData;
    end
  end

  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_SHIFT_CTRL = _zz_29;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_33 = execute_PC;
  assign execute_SRC2_CTRL = _zz_34;
  assign execute_SRC1_CTRL = _zz_36;
  assign execute_SRC_ADD_SUB = _zz_32;
  assign execute_SRC_LESS = _zz_30;
  assign execute_ALU_CTRL = _zz_38;
  assign execute_SRC2 = _zz_35;
  assign execute_SRC1 = _zz_37;
  assign execute_ALU_BITWISE_CTRL = _zz_40;
  assign _zz_41 = writeBack_INSTRUCTION;
  assign _zz_42 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_43 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_43 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_72;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_57;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_62;
  assign decode_INSTRUCTION_READY = _zz_69;
  always @ (*) begin
    _zz_63 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_63 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_SRC_ADD = _zz_31;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_ALIGNEMENT_FAULT = _zz_66;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  always @ (*) begin
    _zz_67 = memory_FORMAL_PC_NEXT;
    if(_zz_74)begin
      _zz_67 = _zz_75;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_71;
  assign decode_INSTRUCTION = _zz_70;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if((decode_arbitration_isValid && (_zz_125 || _zz_126)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(((decode_arbitration_isValid && decode_IS_CSR) && (execute_arbitration_isValid || memory_arbitration_isValid)))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute)begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if((CsrPlugin_interrupt && decode_arbitration_isValid))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_exception_agregat_valid)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_redoIt = 1'b0;
  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory)begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(_zz_74)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_haltByOther = 1'b0;
    if(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack)begin
      memory_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_exception_agregat_valid)begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_redoIt = 1'b0;
  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  assign _zz_73 = 1'b0;
  assign IBusSimplePlugin_jump_pcLoad_valid = (_zz_74 || _zz_76);
  assign _zz_79 = {_zz_74,_zz_76};
  assign _zz_80 = _zz_178[1];
  assign IBusSimplePlugin_jump_pcLoad_payload = _zz_163;
  assign _zz_81 = (! 1'b0);
  assign IBusSimplePlugin_fetchPc_output_valid = (IBusSimplePlugin_fetchPc_preOutput_valid && _zz_81);
  assign IBusSimplePlugin_fetchPc_preOutput_ready = (IBusSimplePlugin_fetchPc_output_ready && _zz_81);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_181);
    IBusSimplePlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_samplePcNext = 1'b1;
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    if(_zz_171)begin
      IBusSimplePlugin_fetchPc_samplePcNext = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_preOutput_valid = _zz_82;
  assign IBusSimplePlugin_fetchPc_preOutput_payload = IBusSimplePlugin_fetchPc_pc;
  assign IBusSimplePlugin_iBusRsp_input_ready = ((1'b0 && (! _zz_83)) || IBusSimplePlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_83 = _zz_84;
  assign IBusSimplePlugin_iBusRsp_inputPipeline_0_valid = _zz_83;
  assign IBusSimplePlugin_iBusRsp_inputPipeline_0_payload = _zz_85;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_iBusRsp_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_86;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_87;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_88;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_89;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_90;
  assign _zz_72 = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_iBusRsp_output_payload_rsp_inst);
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  assign decode_arbitration_isValid = (IBusSimplePlugin_injector_decodeInput_valid && (! IBusSimplePlugin_injector_decodeRemoved));
  assign _zz_71 = IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign _zz_70 = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign _zz_69 = 1'b1;
  assign _zz_68 = (decode_PC + (32'b00000000000000000000000000000100));
  assign IBusSimplePlugin_pendingCmdNext = (_zz_182 - _zz_186);
  assign _zz_91 = (iBus_cmd_valid && iBus_cmd_ready);
  assign IBusSimplePlugin_fetchPc_output_ready = (IBusSimplePlugin_iBusRsp_input_ready && _zz_91);
  assign IBusSimplePlugin_iBusRsp_input_valid = (IBusSimplePlugin_fetchPc_output_valid && _zz_91);
  assign IBusSimplePlugin_iBusRsp_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  assign iBus_cmd_valid = ((IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_iBusRsp_input_ready) && (IBusSimplePlugin_pendingCmd != (3'b111)));
  assign iBus_cmd_payload_pc = {IBusSimplePlugin_fetchPc_output_payload[31 : 2],(2'b00)};
  assign _zz_157 = (iBus_rsp_valid && (! (IBusSimplePlugin_rsp_discardCounter != (3'b000))));
  assign _zz_158 = (IBusSimplePlugin_jump_pcLoad_valid || _zz_73);
  assign IBusSimplePlugin_rsp_fetchRsp_pc = IBusSimplePlugin_iBusRsp_inputPipeline_0_payload;
  always @ (*) begin
    IBusSimplePlugin_rsp_fetchRsp_rsp_error = _zz_166;
    if((! _zz_165))begin
      IBusSimplePlugin_rsp_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rsp_fetchRsp_rsp_inst = _zz_167;
  assign IBusSimplePlugin_rsp_issueDetected = 1'b0;
  assign _zz_93 = (_zz_92 && IBusSimplePlugin_rsp_join_ready);
  assign _zz_92 = (IBusSimplePlugin_iBusRsp_inputPipeline_0_valid && _zz_165);
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_inputPipeline_0_ready = _zz_93;
    if((! IBusSimplePlugin_iBusRsp_inputPipeline_0_valid))begin
      IBusSimplePlugin_iBusRsp_inputPipeline_0_ready = 1'b1;
    end
  end

  assign IBusSimplePlugin_rsp_join_valid = _zz_92;
  assign IBusSimplePlugin_rsp_join_payload_pc = IBusSimplePlugin_rsp_fetchRsp_pc;
  assign IBusSimplePlugin_rsp_join_payload_rsp_error = IBusSimplePlugin_rsp_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rsp_join_payload_rsp_inst = IBusSimplePlugin_rsp_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rsp_join_payload_isRvc = IBusSimplePlugin_rsp_fetchRsp_isRvc;
  assign _zz_94 = (! IBusSimplePlugin_rsp_issueDetected);
  assign IBusSimplePlugin_rsp_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_94);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rsp_join_valid && _zz_94);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rsp_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rsp_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rsp_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rsp_join_payload_isRvc;
  assign _zz_66 = 1'b0;
  assign dBus_cmd_valid = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign dBus_cmd_payload_wr = execute_INSTRUCTION[5];
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_95 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_95 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_95 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_95;
  assign _zz_65 = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_96 = (4'b0001);
      end
      2'b01 : begin
        _zz_96 = (4'b0011);
      end
      default : begin
        _zz_96 = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_96 <<< dBus_cmd_payload_address[1 : 0]);
  assign _zz_64 = dBus_rsp_data;
  always @ (*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_97 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_98[31] = _zz_97;
    _zz_98[30] = _zz_97;
    _zz_98[29] = _zz_97;
    _zz_98[28] = _zz_97;
    _zz_98[27] = _zz_97;
    _zz_98[26] = _zz_97;
    _zz_98[25] = _zz_97;
    _zz_98[24] = _zz_97;
    _zz_98[23] = _zz_97;
    _zz_98[22] = _zz_97;
    _zz_98[21] = _zz_97;
    _zz_98[20] = _zz_97;
    _zz_98[19] = _zz_97;
    _zz_98[18] = _zz_97;
    _zz_98[17] = _zz_97;
    _zz_98[16] = _zz_97;
    _zz_98[15] = _zz_97;
    _zz_98[14] = _zz_97;
    _zz_98[13] = _zz_97;
    _zz_98[12] = _zz_97;
    _zz_98[11] = _zz_97;
    _zz_98[10] = _zz_97;
    _zz_98[9] = _zz_97;
    _zz_98[8] = _zz_97;
    _zz_98[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_99 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_100[31] = _zz_99;
    _zz_100[30] = _zz_99;
    _zz_100[29] = _zz_99;
    _zz_100[28] = _zz_99;
    _zz_100[27] = _zz_99;
    _zz_100[26] = _zz_99;
    _zz_100[25] = _zz_99;
    _zz_100[24] = _zz_99;
    _zz_100[23] = _zz_99;
    _zz_100[22] = _zz_99;
    _zz_100[21] = _zz_99;
    _zz_100[20] = _zz_99;
    _zz_100[19] = _zz_99;
    _zz_100[18] = _zz_99;
    _zz_100[17] = _zz_99;
    _zz_100[16] = _zz_99;
    _zz_100[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_176)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_98;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_100;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_102 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_103 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign _zz_104 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_105 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign _zz_106 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_101 = {(((decode_INSTRUCTION & (32'b00000000000000000011000001010000)) == (32'b00000000000000000000000001010000)) != (1'b0)),{1'b0,{(_zz_104 != (1'b0)),{(_zz_229 != (1'b0)),{(_zz_230 != _zz_231),{_zz_232,{_zz_233,_zz_234}}}}}}};
  assign _zz_62 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000001000001111111)) == (32'b00000000000000000001000001110011)),{((decode_INSTRUCTION & _zz_315) == (32'b00000000000000000010000001110011)),{(_zz_316 == _zz_317),{_zz_318,{_zz_319,_zz_320}}}}}}} != (18'b000000000000000000));
  assign _zz_107 = _zz_101[1 : 0];
  assign _zz_61 = _zz_107;
  assign _zz_60 = _zz_191[0];
  assign _zz_59 = _zz_192[0];
  assign _zz_108 = _zz_101[5 : 4];
  assign _zz_58 = _zz_108;
  assign _zz_57 = _zz_193[0];
  assign _zz_56 = _zz_194[0];
  assign _zz_109 = _zz_101[9 : 8];
  assign _zz_55 = _zz_109;
  assign _zz_54 = _zz_195[0];
  assign _zz_53 = _zz_196[0];
  assign _zz_52 = _zz_197[0];
  assign _zz_51 = _zz_198[0];
  assign _zz_50 = _zz_199[0];
  assign _zz_110 = _zz_101[16 : 15];
  assign _zz_49 = _zz_110;
  assign _zz_111 = _zz_101[18 : 17];
  assign _zz_48 = _zz_111;
  assign _zz_112 = _zz_101[20 : 19];
  assign _zz_47 = _zz_112;
  assign _zz_113 = _zz_101[22 : 21];
  assign _zz_46 = _zz_113;
  assign decode_exception_agregat_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decode_exception_agregat_payload_code = (4'b0010);
  assign decode_exception_agregat_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_114 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_159;
  assign _zz_115 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_160;
  assign _zz_45 = decode_RegFilePlugin_rs1Data;
  assign _zz_44 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_42 && writeBack_arbitration_isFiring);
    if(_zz_116)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_41[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_63;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequancial_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequancial_XOR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = execute_SRC1;
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequancial_BITWISE : begin
        _zz_117 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_117 = {31'd0, _zz_200};
      end
      default : begin
        _zz_117 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_39 = _zz_117;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_118 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_PC_INCREMENT : begin
        _zz_118 = {29'd0, _zz_201};
      end
      default : begin
        _zz_118 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_37 = _zz_118;
  assign _zz_119 = _zz_202[11];
  always @ (*) begin
    _zz_120[19] = _zz_119;
    _zz_120[18] = _zz_119;
    _zz_120[17] = _zz_119;
    _zz_120[16] = _zz_119;
    _zz_120[15] = _zz_119;
    _zz_120[14] = _zz_119;
    _zz_120[13] = _zz_119;
    _zz_120[12] = _zz_119;
    _zz_120[11] = _zz_119;
    _zz_120[10] = _zz_119;
    _zz_120[9] = _zz_119;
    _zz_120[8] = _zz_119;
    _zz_120[7] = _zz_119;
    _zz_120[6] = _zz_119;
    _zz_120[5] = _zz_119;
    _zz_120[4] = _zz_119;
    _zz_120[3] = _zz_119;
    _zz_120[2] = _zz_119;
    _zz_120[1] = _zz_119;
    _zz_120[0] = _zz_119;
  end

  assign _zz_121 = _zz_203[11];
  always @ (*) begin
    _zz_122[19] = _zz_121;
    _zz_122[18] = _zz_121;
    _zz_122[17] = _zz_121;
    _zz_122[16] = _zz_121;
    _zz_122[15] = _zz_121;
    _zz_122[14] = _zz_121;
    _zz_122[13] = _zz_121;
    _zz_122[12] = _zz_121;
    _zz_122[11] = _zz_121;
    _zz_122[10] = _zz_121;
    _zz_122[9] = _zz_121;
    _zz_122[8] = _zz_121;
    _zz_122[7] = _zz_121;
    _zz_122[6] = _zz_121;
    _zz_122[5] = _zz_121;
    _zz_122[4] = _zz_121;
    _zz_122[3] = _zz_121;
    _zz_122[2] = _zz_121;
    _zz_122[1] = _zz_121;
    _zz_122[0] = _zz_121;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_123 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_123 = {_zz_120,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_123 = {_zz_122,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_123 = _zz_33;
      end
    endcase
  end

  assign _zz_35 = _zz_123;
  assign execute_SrcPlugin_addSub = _zz_204;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_32 = execute_SrcPlugin_addSub;
  assign _zz_31 = execute_SrcPlugin_addSub;
  assign _zz_30 = execute_SrcPlugin_less;
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_binary_sequancial_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_124 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_124 = _zz_212;
      end
    endcase
  end

  always @ (*) begin
    _zz_125 = 1'b0;
    _zz_126 = 1'b0;
    if(_zz_127)begin
      if((_zz_128 == decode_INSTRUCTION[19 : 15]))begin
        _zz_125 = 1'b1;
      end
      if((_zz_128 == decode_INSTRUCTION[24 : 20]))begin
        _zz_126 = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! 1'b1)))begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_125 = 1'b1;
        end
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_126 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_125 = 1'b1;
        end
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_126 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_125 = 1'b1;
        end
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_126 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_125 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_126 = 1'b0;
    end
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_129 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_129 == (3'b000))) begin
        _zz_130 = execute_BranchPlugin_eq;
    end else if((_zz_129 == (3'b001))) begin
        _zz_130 = (! execute_BranchPlugin_eq);
    end else if((((_zz_129 & (3'b101)) == (3'b101)))) begin
        _zz_130 = (! execute_SRC_LESS);
    end else begin
        _zz_130 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_131 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_131 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_131 = 1'b1;
      end
      default : begin
        _zz_131 = _zz_130;
      end
    endcase
  end

  assign _zz_27 = _zz_131;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? execute_RS1 : execute_PC);
  assign _zz_132 = _zz_214[19];
  always @ (*) begin
    _zz_133[10] = _zz_132;
    _zz_133[9] = _zz_132;
    _zz_133[8] = _zz_132;
    _zz_133[7] = _zz_132;
    _zz_133[6] = _zz_132;
    _zz_133[5] = _zz_132;
    _zz_133[4] = _zz_132;
    _zz_133[3] = _zz_132;
    _zz_133[2] = _zz_132;
    _zz_133[1] = _zz_132;
    _zz_133[0] = _zz_132;
  end

  assign _zz_134 = _zz_215[11];
  always @ (*) begin
    _zz_135[19] = _zz_134;
    _zz_135[18] = _zz_134;
    _zz_135[17] = _zz_134;
    _zz_135[16] = _zz_134;
    _zz_135[15] = _zz_134;
    _zz_135[14] = _zz_134;
    _zz_135[13] = _zz_134;
    _zz_135[12] = _zz_134;
    _zz_135[11] = _zz_134;
    _zz_135[10] = _zz_134;
    _zz_135[9] = _zz_134;
    _zz_135[8] = _zz_134;
    _zz_135[7] = _zz_134;
    _zz_135[6] = _zz_134;
    _zz_135[5] = _zz_134;
    _zz_135[4] = _zz_134;
    _zz_135[3] = _zz_134;
    _zz_135[2] = _zz_134;
    _zz_135[1] = _zz_134;
    _zz_135[0] = _zz_134;
  end

  assign _zz_136 = _zz_216[11];
  always @ (*) begin
    _zz_137[18] = _zz_136;
    _zz_137[17] = _zz_136;
    _zz_137[16] = _zz_136;
    _zz_137[15] = _zz_136;
    _zz_137[14] = _zz_136;
    _zz_137[13] = _zz_136;
    _zz_137[12] = _zz_136;
    _zz_137[11] = _zz_136;
    _zz_137[10] = _zz_136;
    _zz_137[9] = _zz_136;
    _zz_137[8] = _zz_136;
    _zz_137[7] = _zz_136;
    _zz_137[6] = _zz_136;
    _zz_137[5] = _zz_136;
    _zz_137[4] = _zz_136;
    _zz_137[3] = _zz_136;
    _zz_137[2] = _zz_136;
    _zz_137[1] = _zz_136;
    _zz_137[0] = _zz_136;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_138 = {{_zz_133,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_138 = {_zz_135,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_138 = {{_zz_137,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_138;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_25 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_74 = (memory_arbitration_isFiring && memory_BRANCH_DO);
  assign _zz_75 = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (_zz_75[1 : 0] != (2'b00)));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = _zz_75;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(decode_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign CsrPlugin_interruptRequest = ((((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) || (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE)) || (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE)) && CsrPlugin_mstatus_MIE);
  assign CsrPlugin_interrupt = (CsrPlugin_interruptRequest && 1'b1);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && 1'b1);
  assign CsrPlugin_writeBackWasWfi = 1'b0;
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusSimplePlugin_injector_nextPcCalc_valids_4);
    if(((CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptCode = ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_218);
  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  assign contextSwitching = _zz_76;
  assign _zz_23 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_22 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_140;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b001100000101 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b001101000011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mbadaddr;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_142;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b001101000010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      default : begin
      end
    endcase
    if((_zz_78 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_220 : execute_SRC1);
  always @ (*) begin
    case(_zz_177)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_CsrPlugin_writeSrc;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (memory_REGFILE_WRITE_DATA & (~ execute_CsrPlugin_writeSrc)) : (memory_REGFILE_WRITE_DATA | execute_CsrPlugin_writeSrc));
      end
    endcase
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && execute_CsrPlugin_readDataRegValid);
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_readDataRegValid));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_142 = (_zz_140 & _zz_141);
  assign externalInterrupt = (_zz_142 != (32'b00000000000000000000000000000000));
  assign _zz_21 = decode_ALU_CTRL;
  assign _zz_19 = _zz_61;
  assign _zz_38 = decode_to_execute_ALU_CTRL;
  assign _zz_18 = decode_SHIFT_CTRL;
  assign _zz_16 = _zz_49;
  assign _zz_29 = decode_to_execute_SHIFT_CTRL;
  assign _zz_15 = decode_ENV_CTRL;
  assign _zz_13 = _zz_46;
  assign _zz_24 = decode_to_execute_ENV_CTRL;
  assign _zz_12 = decode_SRC1_CTRL;
  assign _zz_10 = _zz_58;
  assign _zz_36 = decode_to_execute_SRC1_CTRL;
  assign _zz_9 = decode_ALU_BITWISE_CTRL;
  assign _zz_7 = _zz_48;
  assign _zz_40 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_6 = decode_SRC2_CTRL;
  assign _zz_4 = _zz_55;
  assign _zz_34 = decode_to_execute_SRC2_CTRL;
  assign _zz_3 = decode_BRANCH_CTRL;
  assign _zz_1 = _zz_47;
  assign _zz_26 = decode_to_execute_BRANCH_CTRL;
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBus_cmd_ready = ((1'b1 && (! _zz_143)) || (_zz_143 && iBusWishbone_ACK));
  assign _zz_143 = _zz_144;
  assign iBusWishbone_ADR = (_zz_145 >>> 2);
  assign iBusWishbone_CTI = (3'b000);
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign _zz_161 = _zz_143;
  assign iBusWishbone_STB = _zz_143;
  assign iBus_rsp_valid = (_zz_161 && iBusWishbone_ACK);
  assign iBus_rsp_payload_inst = iBusWishbone_DAT_MISO;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_146 = _zz_150;
  assign _zz_148 = _zz_152;
  assign _zz_149 = _zz_153;
  assign dBus_cmd_ready = _zz_151;
  assign dBusWishbone_ADR = (_zz_149 >>> 2);
  assign dBusWishbone_CTI = (3'b000);
  assign dBusWishbone_BTE = (2'b00);
  always @ (*) begin
    case(_zz_155)
      2'b00 : begin
        _zz_156 = (4'b0001);
      end
      2'b01 : begin
        _zz_156 = (4'b0011);
      end
      default : begin
        _zz_156 = (4'b1111);
      end
    endcase
  end

  always @ (*) begin
    dBusWishbone_SEL = _zz_227[3:0];
    if((! _zz_148))begin
      dBusWishbone_SEL = (4'b1111);
    end
  end

  assign _zz_162 = _zz_148;
  assign dBusWishbone_DAT_MOSI = _zz_154;
  assign _zz_147 = (_zz_146 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_146;
  assign dBusWishbone_STB = _zz_146;
  assign dBus_rsp_ready = ((_zz_146 && (! _zz_162)) && dBusWishbone_ACK);
  assign dBus_rsp_data = dBusWishbone_DAT_MISO;
  assign dBus_rsp_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_78 <= (2'b11);
      IBusSimplePlugin_fetchPc_pcReg <= externalResetVector;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      _zz_82 <= 1'b0;
      _zz_84 <= 1'b0;
      _zz_86 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      IBusSimplePlugin_pendingCmd <= (3'b000);
      IBusSimplePlugin_rsp_discardCounter <= (3'b000);
      _zz_116 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_127 <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mip_MEIP <= 1'b0;
      CsrPlugin_mip_MTIP <= 1'b0;
      CsrPlugin_mip_MSIP <= 1'b0;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      _zz_140 <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_144 <= 1'b0;
      _zz_150 <= 1'b0;
      _zz_151 <= 1'b1;
    end else begin
      if(IBusSimplePlugin_jump_pcLoad_valid)begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_171)begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_samplePcNext)begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      _zz_82 <= 1'b1;
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        _zz_84 <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_input_ready)begin
        _zz_84 <= IBusSimplePlugin_iBusRsp_input_valid;
      end
      if(IBusSimplePlugin_iBusRsp_output_ready)begin
        _zz_86 <= IBusSimplePlugin_iBusRsp_output_valid;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        _zz_86 <= 1'b0;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusSimplePlugin_iBusRsp_inputPipeline_0_ready)))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusSimplePlugin_injector_decodeInput_ready)))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= IBusSimplePlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      end
      IBusSimplePlugin_pendingCmd <= IBusSimplePlugin_pendingCmdNext;
      IBusSimplePlugin_rsp_discardCounter <= (IBusSimplePlugin_rsp_discardCounter - _zz_188);
      if((IBusSimplePlugin_jump_pcLoad_valid || _zz_73))begin
        IBusSimplePlugin_rsp_discardCounter <= (IBusSimplePlugin_pendingCmd - _zz_190);
      end
      _zz_116 <= 1'b0;
      if(_zz_172)begin
        if(_zz_170)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_127 <= (_zz_42 && writeBack_arbitration_isFiring);
      CsrPlugin_mip_MEIP <= externalInterrupt;
      CsrPlugin_mip_MTIP <= timerInterrupt;
      if((! decode_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
      end
      if(_zz_169)begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_78;
      end
      if(_zz_175)begin
        if(! _zz_173) begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_78 <= CsrPlugin_mstatus_MPP;
        end
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= memory_REGFILE_WRITE_DATA;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_140 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_221[0];
            CsrPlugin_mstatus_MIE <= _zz_222[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_223[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_224[0];
            CsrPlugin_mie_MTIE <= _zz_225[0];
            CsrPlugin_mie_MSIE <= _zz_226[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(iBus_cmd_ready)begin
        _zz_144 <= iBus_cmd_valid;
      end
      if(_zz_174)begin
        _zz_150 <= dBus_cmd_valid;
        _zz_151 <= (! dBus_cmd_valid);
      end else begin
        _zz_150 <= (! _zz_147);
        _zz_151 <= _zz_147;
      end
    end
  end

  always @ (posedge clk) begin
    if(IBusSimplePlugin_iBusRsp_input_ready)begin
      _zz_85 <= IBusSimplePlugin_iBusRsp_input_payload;
    end
    if(IBusSimplePlugin_iBusRsp_output_ready)begin
      _zz_87 <= IBusSimplePlugin_iBusRsp_output_payload_pc;
      _zz_88 <= IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
      _zz_89 <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
      _zz_90 <= IBusSimplePlugin_iBusRsp_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready)begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow writeback stage stall when read happend");
    end
    if(_zz_172)begin
      if(_zz_170)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    _zz_128 <= _zz_41[11 : 7];
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(decode_exception_agregat_valid)begin
      if((! (((1'b0 || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack)))begin
        CsrPlugin_exceptionPortCtrl_exceptionContext_code <= decode_exception_agregat_payload_code;
        CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= decode_exception_agregat_payload_badAddr;
      end
    end
    if(memory_exception_agregat_valid)begin
      if((! (1'b0 || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack)))begin
        CsrPlugin_exceptionPortCtrl_exceptionContext_code <= memory_exception_agregat_payload_code;
        CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= memory_exception_agregat_payload_badAddr;
      end
    end
    if(_zz_169)begin
      CsrPlugin_mepc <= writeBack_PC;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interruptJump;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_interruptCode;
    end
    _zz_139 <= CsrPlugin_exception;
    if(_zz_139)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    _zz_141 <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_20;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_33;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_17;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_67;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_14;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_11;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_8;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_28;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000100 : begin
      end
      12'b001101000011 : begin
      end
      12'b111111000000 : begin
      end
      12'b001100000100 : begin
      end
      12'b001101000010 : begin
      end
      default : begin
      end
    endcase
    if(iBus_cmd_ready)begin
      _zz_145 <= iBus_cmd_payload_pc;
    end
    if(_zz_174)begin
      _zz_152 <= dBus_cmd_payload_wr;
      _zz_153 <= dBus_cmd_payload_address;
      _zz_154 <= dBus_cmd_payload_data;
      _zz_155 <= dBus_cmd_payload_size;
    end
  end

endmodule

