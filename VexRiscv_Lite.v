// Generator : SpinalHDL v1.1.6    git head : 2643ea2afba86dc6321cd50da8126412cf13d7ec
// Date      : 06/09/2018, 01:17:26
// Component : VexRiscv_Lite


`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_PC_INCREMENT 2'b10

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define EnvCtrlEnum_binary_sequancial_type [1:0]
`define EnvCtrlEnum_binary_sequancial_NONE 2'b00
`define EnvCtrlEnum_binary_sequancial_EBREAK 2'b01
`define EnvCtrlEnum_binary_sequancial_MRET 2'b10

module InstructionCache (
      input   io_flush_cmd_valid,
      output  io_flush_cmd_ready,
      output  io_flush_rsp,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
      input   io_cpu_fetch_isRemoved,
      input  [31:0] io_cpu_fetch_pc,
      output [31:0] io_cpu_fetch_data,
      output  io_cpu_fetch_mmuBus_cmd_isValid,
      output [31:0] io_cpu_fetch_mmuBus_cmd_virtualAddress,
      output  io_cpu_fetch_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_fetch_mmuBus_rsp_physicalAddress,
      input   io_cpu_fetch_mmuBus_rsp_isIoAccess,
      input   io_cpu_fetch_mmuBus_rsp_allowRead,
      input   io_cpu_fetch_mmuBus_rsp_allowWrite,
      input   io_cpu_fetch_mmuBus_rsp_allowExecute,
      input   io_cpu_fetch_mmuBus_rsp_allowUser,
      input   io_cpu_fetch_mmuBus_rsp_miss,
      input   io_cpu_fetch_mmuBus_rsp_hit,
      output  io_cpu_fetch_mmuBus_end,
      output [31:0] io_cpu_fetch_physicalAddress,
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output [31:0] io_cpu_decode_physicalAddress,
      output [31:0] io_cpu_decode_data,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuMiss,
      output  io_cpu_decode_illegalAccess,
      input   io_cpu_decode_isUser,
      input   io_cpu_fill_valid,
      input  [31:0] io_cpu_fill_payload,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [22:0] _zz_13;
  reg [31:0] _zz_14;
  wire  _zz_15;
  wire  _zz_16;
  wire  _zz_17;
  wire [0:0] _zz_18;
  wire [0:0] _zz_19;
  wire [22:0] _zz_20;
  reg  _zz_1;
  reg  _zz_2;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg [6:0] lineLoader_flushCounter;
  reg  _zz_3;
  reg  lineLoader_flushFromInterface;
  wire  _zz_4;
  reg  _zz_5;
  reg  lineLoader_cmdSent;
  reg  lineLoader_wayToAllocate_willIncrement;
  wire  lineLoader_wayToAllocate_willClear;
  wire  lineLoader_wayToAllocate_willOverflowIfInc;
  wire  lineLoader_wayToAllocate_willOverflow;
  reg [2:0] lineLoader_wordIndex;
  wire  lineLoader_write_tag_0_valid;
  wire [5:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [20:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [8:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  _zz_6;
  wire [5:0] _zz_7;
  wire  _zz_8;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [20:0] fetchStage_read_waysValues_0_tag_address;
  wire [22:0] _zz_9;
  wire [8:0] _zz_10;
  wire  _zz_11;
  wire [31:0] fetchStage_read_waysValues_0_data;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_allowUser;
  reg  decodeStage_mmuRsp_miss;
  reg  decodeStage_mmuRsp_hit;
  reg  decodeStage_hit_tags_0_valid;
  reg  decodeStage_hit_tags_0_error;
  reg [20:0] decodeStage_hit_tags_0_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_valid;
  wire  decodeStage_hit_error;
  reg [31:0] _zz_12;
  wire [31:0] decodeStage_hit_data;
  wire [31:0] decodeStage_hit_word;
  reg [22:0] ways_0_tags [0:63];
  reg [31:0] ways_0_datas [0:511];
  assign io_flush_cmd_ready = _zz_15;
  assign io_mem_cmd_valid = _zz_16;
  assign _zz_17 = (! lineLoader_flushCounter[6]);
  assign _zz_18 = _zz_9[0 : 0];
  assign _zz_19 = _zz_9[1 : 1];
  assign _zz_20 = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_20;
    end
  end

  always @ (posedge clk) begin
    if(_zz_8) begin
      _zz_13 <= ways_0_tags[_zz_7];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_11) begin
      _zz_14 <= ways_0_datas[_zz_10];
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(lineLoader_write_data_0_valid)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2 = 1'b0;
    if(lineLoader_write_tag_0_valid)begin
      _zz_2 = 1'b1;
    end
  end

  always @ (*) begin
    io_cpu_prefetch_haltIt = 1'b0;
    if(lineLoader_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(_zz_17)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if((! _zz_3))begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush_cmd_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  always @ (*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid)begin
      if((lineLoader_wordIndex == (3'b111)))begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  assign _zz_15 = (! (lineLoader_valid || io_cpu_fetch_isValid));
  assign _zz_4 = lineLoader_flushCounter[6];
  assign io_flush_rsp = ((_zz_4 && (! _zz_5)) && lineLoader_flushFromInterface);
  assign _zz_16 = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],(5'b00000)};
  assign io_mem_cmd_payload_size = (3'b101);
  always @ (*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(lineLoader_fire)begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign _zz_6 = 1'b1;
  assign lineLoader_write_tag_0_valid = ((_zz_6 && lineLoader_fire) || (! lineLoader_flushCounter[6]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[6] ? lineLoader_address[10 : 5] : lineLoader_flushCounter[5 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[6];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 11];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_6);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[10 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_7 = io_cpu_prefetch_pc[10 : 5];
  assign _zz_8 = (! io_cpu_fetch_isStuck);
  assign _zz_9 = _zz_13;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_18[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_19[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_9[22 : 2];
  assign _zz_10 = io_cpu_prefetch_pc[10 : 2];
  assign _zz_11 = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_14;
  assign io_cpu_fetch_data = fetchStage_read_waysValues_0_data[31 : 0];
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 11]));
  assign decodeStage_hit_valid = (decodeStage_hit_hits_0 != (1'b0));
  assign decodeStage_hit_error = decodeStage_hit_tags_0_error;
  assign decodeStage_hit_data = _zz_12;
  assign decodeStage_hit_word = decodeStage_hit_data[31 : 0];
  assign io_cpu_decode_data = decodeStage_hit_word;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuMiss = decodeStage_mmuRsp_miss;
  assign io_cpu_decode_illegalAccess = ((! decodeStage_mmuRsp_allowExecute) || (io_cpu_decode_isUser && (! decodeStage_mmuRsp_allowUser)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushCounter <= (7'b0000000);
      lineLoader_flushFromInterface <= 1'b0;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= (3'b000);
    end else begin
      if(lineLoader_fire)begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire)begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(_zz_17)begin
        lineLoader_flushCounter <= (lineLoader_flushCounter + (7'b0000001));
      end
      if(io_flush_cmd_valid)begin
        if(_zz_15)begin
          lineLoader_flushCounter <= (7'b0000000);
          lineLoader_flushFromInterface <= 1'b1;
        end
      end
      if((_zz_16 && io_mem_cmd_ready))begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire)begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid)begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + (3'b001));
        if(io_mem_rsp_payload_error)begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(io_cpu_fill_valid)begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    _zz_3 <= lineLoader_flushCounter[6];
    _zz_5 <= _zz_4;
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_allowUser <= io_cpu_fetch_mmuBus_rsp_allowUser;
      decodeStage_mmuRsp_miss <= io_cpu_fetch_mmuBus_rsp_miss;
      decodeStage_mmuRsp_hit <= io_cpu_fetch_mmuBus_rsp_hit;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if((! io_cpu_decode_isStuck))begin
      _zz_12 <= fetchStage_read_waysValues_0_data;
    end
  end

endmodule

module VexRiscv_Lite (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input  [31:0] externalInterruptArray,
      output  iBusWishbone_CYC,
      output reg  iBusWishbone_STB,
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
  reg  _zz_199;
  wire  _zz_200;
  wire  _zz_201;
  wire  _zz_202;
  wire  _zz_203;
  wire  _zz_204;
  wire  _zz_205;
  wire  _zz_206;
  wire  _zz_207;
  wire  _zz_208;
  reg [31:0] _zz_209;
  reg [31:0] _zz_210;
  reg  _zz_211;
  wire  _zz_212;
  reg [31:0] _zz_213;
  reg [3:0] _zz_214;
  reg [31:0] _zz_215;
  wire  _zz_216;
  wire  _zz_217;
  wire  _zz_218;
  wire [31:0] _zz_219;
  wire [31:0] _zz_220;
  wire  _zz_221;
  wire [31:0] _zz_222;
  wire  _zz_223;
  wire  _zz_224;
  wire  _zz_225;
  wire  _zz_226;
  wire  _zz_227;
  wire [31:0] _zz_228;
  wire  _zz_229;
  wire [31:0] _zz_230;
  wire  _zz_231;
  wire [31:0] _zz_232;
  wire [2:0] _zz_233;
  wire  _zz_234;
  wire  _zz_235;
  wire  _zz_236;
  wire  _zz_237;
  wire  _zz_238;
  wire  _zz_239;
  wire  _zz_240;
  wire  _zz_241;
  wire  _zz_242;
  wire  _zz_243;
  wire  _zz_244;
  wire  _zz_245;
  wire  _zz_246;
  wire [1:0] _zz_247;
  wire  _zz_248;
  wire [3:0] _zz_249;
  wire [2:0] _zz_250;
  wire [31:0] _zz_251;
  wire [11:0] _zz_252;
  wire [31:0] _zz_253;
  wire [19:0] _zz_254;
  wire [11:0] _zz_255;
  wire [0:0] _zz_256;
  wire [0:0] _zz_257;
  wire [0:0] _zz_258;
  wire [0:0] _zz_259;
  wire [0:0] _zz_260;
  wire [0:0] _zz_261;
  wire [0:0] _zz_262;
  wire [0:0] _zz_263;
  wire [0:0] _zz_264;
  wire [0:0] _zz_265;
  wire [0:0] _zz_266;
  wire [0:0] _zz_267;
  wire [0:0] _zz_268;
  wire [0:0] _zz_269;
  wire [0:0] _zz_270;
  wire [2:0] _zz_271;
  wire [11:0] _zz_272;
  wire [11:0] _zz_273;
  wire [31:0] _zz_274;
  wire [31:0] _zz_275;
  wire [31:0] _zz_276;
  wire [31:0] _zz_277;
  wire [1:0] _zz_278;
  wire [31:0] _zz_279;
  wire [1:0] _zz_280;
  wire [1:0] _zz_281;
  wire [31:0] _zz_282;
  wire [32:0] _zz_283;
  wire [11:0] _zz_284;
  wire [11:0] _zz_285;
  wire [2:0] _zz_286;
  wire [31:0] _zz_287;
  wire [1:0] _zz_288;
  wire [1:0] _zz_289;
  wire [2:0] _zz_290;
  wire [3:0] _zz_291;
  wire [4:0] _zz_292;
  wire [31:0] _zz_293;
  wire [0:0] _zz_294;
  wire [5:0] _zz_295;
  wire [33:0] _zz_296;
  wire [32:0] _zz_297;
  wire [33:0] _zz_298;
  wire [32:0] _zz_299;
  wire [33:0] _zz_300;
  wire [32:0] _zz_301;
  wire [0:0] _zz_302;
  wire [5:0] _zz_303;
  wire [32:0] _zz_304;
  wire [32:0] _zz_305;
  wire [31:0] _zz_306;
  wire [31:0] _zz_307;
  wire [32:0] _zz_308;
  wire [32:0] _zz_309;
  wire [32:0] _zz_310;
  wire [0:0] _zz_311;
  wire [32:0] _zz_312;
  wire [0:0] _zz_313;
  wire [32:0] _zz_314;
  wire [0:0] _zz_315;
  wire [31:0] _zz_316;
  wire [0:0] _zz_317;
  wire [0:0] _zz_318;
  wire [0:0] _zz_319;
  wire [0:0] _zz_320;
  wire [0:0] _zz_321;
  wire [0:0] _zz_322;
  wire [26:0] _zz_323;
  wire [6:0] _zz_324;
  wire [1:0] _zz_325;
  wire [0:0] _zz_326;
  wire [7:0] _zz_327;
  wire  _zz_328;
  wire [0:0] _zz_329;
  wire [0:0] _zz_330;
  wire [31:0] _zz_331;
  wire [31:0] _zz_332;
  wire [31:0] _zz_333;
  wire  _zz_334;
  wire [1:0] _zz_335;
  wire [1:0] _zz_336;
  wire  _zz_337;
  wire [0:0] _zz_338;
  wire [21:0] _zz_339;
  wire [31:0] _zz_340;
  wire [31:0] _zz_341;
  wire [31:0] _zz_342;
  wire [31:0] _zz_343;
  wire [31:0] _zz_344;
  wire [31:0] _zz_345;
  wire [0:0] _zz_346;
  wire [0:0] _zz_347;
  wire [2:0] _zz_348;
  wire [2:0] _zz_349;
  wire  _zz_350;
  wire [0:0] _zz_351;
  wire [18:0] _zz_352;
  wire [31:0] _zz_353;
  wire [31:0] _zz_354;
  wire [31:0] _zz_355;
  wire [31:0] _zz_356;
  wire  _zz_357;
  wire  _zz_358;
  wire [31:0] _zz_359;
  wire [31:0] _zz_360;
  wire [0:0] _zz_361;
  wire [0:0] _zz_362;
  wire [0:0] _zz_363;
  wire [0:0] _zz_364;
  wire  _zz_365;
  wire [0:0] _zz_366;
  wire [15:0] _zz_367;
  wire  _zz_368;
  wire [0:0] _zz_369;
  wire [0:0] _zz_370;
  wire [1:0] _zz_371;
  wire [1:0] _zz_372;
  wire  _zz_373;
  wire [0:0] _zz_374;
  wire [11:0] _zz_375;
  wire [31:0] _zz_376;
  wire [31:0] _zz_377;
  wire [31:0] _zz_378;
  wire [31:0] _zz_379;
  wire [31:0] _zz_380;
  wire [0:0] _zz_381;
  wire [3:0] _zz_382;
  wire [0:0] _zz_383;
  wire [0:0] _zz_384;
  wire [1:0] _zz_385;
  wire [1:0] _zz_386;
  wire  _zz_387;
  wire [0:0] _zz_388;
  wire [8:0] _zz_389;
  wire [31:0] _zz_390;
  wire [31:0] _zz_391;
  wire [31:0] _zz_392;
  wire  _zz_393;
  wire [0:0] _zz_394;
  wire [0:0] _zz_395;
  wire [31:0] _zz_396;
  wire [31:0] _zz_397;
  wire [31:0] _zz_398;
  wire [31:0] _zz_399;
  wire [31:0] _zz_400;
  wire [31:0] _zz_401;
  wire [0:0] _zz_402;
  wire [0:0] _zz_403;
  wire [2:0] _zz_404;
  wire [2:0] _zz_405;
  wire  _zz_406;
  wire [0:0] _zz_407;
  wire [5:0] _zz_408;
  wire [31:0] _zz_409;
  wire [31:0] _zz_410;
  wire [31:0] _zz_411;
  wire  _zz_412;
  wire [31:0] _zz_413;
  wire [31:0] _zz_414;
  wire  _zz_415;
  wire [2:0] _zz_416;
  wire [2:0] _zz_417;
  wire  _zz_418;
  wire [0:0] _zz_419;
  wire [2:0] _zz_420;
  wire [31:0] _zz_421;
  wire [31:0] _zz_422;
  wire  _zz_423;
  wire  _zz_424;
  wire  _zz_425;
  wire [0:0] _zz_426;
  wire [0:0] _zz_427;
  wire [3:0] _zz_428;
  wire [3:0] _zz_429;
  wire  _zz_430;
  wire  _zz_431;
  wire [31:0] _zz_432;
  wire [31:0] _zz_433;
  wire [31:0] _zz_434;
  wire [31:0] _zz_435;
  wire  _zz_436;
  wire [0:0] _zz_437;
  wire [0:0] _zz_438;
  wire [0:0] _zz_439;
  wire [0:0] _zz_440;
  wire  _zz_441;
  wire [0:0] _zz_442;
  wire [1:0] _zz_443;
  wire [31:0] _zz_444;
  wire [31:0] _zz_445;
  wire [31:0] _zz_446;
  wire  _zz_447;
  wire [0:0] _zz_448;
  wire [11:0] _zz_449;
  wire [31:0] _zz_450;
  wire [31:0] _zz_451;
  wire [31:0] _zz_452;
  wire  _zz_453;
  wire [0:0] _zz_454;
  wire [5:0] _zz_455;
  wire [31:0] _zz_456;
  wire [31:0] _zz_457;
  wire [31:0] _zz_458;
  wire  _zz_459;
  wire  _zz_460;
  wire  decode_CSR_READ_OPCODE;
  wire  execute_BRANCH_DO;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  decode_IS_DIV;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_1;
  wire `AluCtrlEnum_binary_sequancial_type _zz_2;
  wire `AluCtrlEnum_binary_sequancial_type _zz_3;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  decode_IS_RS2_SIGNED;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_IS_RS1_SIGNED;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire [31:0] memory_PC;
  wire  decode_IS_MUL;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_4;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_5;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_6;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_7;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_8;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_9;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_10;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_11;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_12;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_13;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_14;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_15;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_16;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_17;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_SRC_USE_SUB_LESS;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_18;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_19;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_20;
  wire  execute_IS_RS1_SIGNED;
  wire  execute_IS_DIV;
  wire  execute_IS_MUL;
  wire  execute_IS_RS2_SIGNED;
  wire  memory_IS_DIV;
  wire  memory_IS_MUL;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire  decode_IS_CSR;
  wire  _zz_21;
  wire  _zz_22;
  wire `EnvCtrlEnum_binary_sequancial_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_23;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_24;
  wire [31:0] execute_PC;
  wire [31:0] execute_RS1;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_25;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_26;
  wire  _zz_27;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  reg [31:0] _zz_28;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  reg [31:0] _zz_29;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_30;
  wire  _zz_31;
  wire [31:0] _zz_32;
  wire [31:0] _zz_33;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_34;
  wire `Src2CtrlEnum_binary_sequancial_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_35;
  wire [31:0] _zz_36;
  wire `Src1CtrlEnum_binary_sequancial_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_37;
  wire [31:0] _zz_38;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_39;
  wire [31:0] _zz_40;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_41;
  wire [31:0] _zz_42;
  wire  _zz_43;
  reg  _zz_44;
  wire [31:0] _zz_45;
  wire [31:0] _zz_46;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_47;
  wire  _zz_48;
  wire  _zz_49;
  wire  _zz_50;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_51;
  wire  _zz_52;
  wire  _zz_53;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_54;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_55;
  wire  _zz_56;
  wire  _zz_57;
  wire  _zz_58;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_59;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_60;
  wire  _zz_61;
  wire  _zz_62;
  wire  _zz_63;
  wire `AluCtrlEnum_binary_sequancial_type _zz_64;
  wire  _zz_65;
  wire  _zz_66;
  wire  _zz_67;
  wire  _zz_68;
  reg [31:0] _zz_69;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_70;
  wire [1:0] _zz_71;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  _zz_72;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_issueDetected;
  reg  _zz_73;
  wire [31:0] _zz_74;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_75;
  reg [31:0] _zz_76;
  reg [31:0] _zz_77;
  wire [31:0] _zz_78;
  wire  _zz_79;
  wire [31:0] _zz_80;
  wire [31:0] _zz_81;
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
  wire  _zz_82;
  wire  _zz_83;
  wire [31:0] _zz_84;
  wire  _zz_85;
  wire  _zz_86;
  wire [31:0] _zz_87;
  reg  _zz_88;
  wire [31:0] _zz_89;
  wire  _zz_90;
  wire  _zz_91;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  _zz_92;
  wire [31:0] _zz_93;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_94;
  reg [31:0] _zz_95;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_96;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_97;
  wire [3:0] _zz_98;
  wire  _zz_99;
  wire  _zz_100;
  wire  _zz_101;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_102;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_103;
  wire  IBusCachedPlugin_iBusRsp_input_valid;
  wire  IBusCachedPlugin_iBusRsp_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_input_payload;
  wire  IBusCachedPlugin_iBusRsp_inputPipeline_0_valid;
  wire  IBusCachedPlugin_iBusRsp_inputPipeline_0_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_inputPipeline_0_payload;
  wire  IBusCachedPlugin_cacheRspArbitration_valid;
  wire  IBusCachedPlugin_cacheRspArbitration_ready;
  wire [31:0] IBusCachedPlugin_cacheRspArbitration_payload;
  reg  IBusCachedPlugin_iBusRsp_inputPipelineHalt_0;
  wire  _zz_104;
  reg  _zz_105;
  reg [31:0] _zz_106;
  wire  _zz_107;
  wire  _zz_108;
  wire  _zz_109;
  reg  _zz_110;
  reg [31:0] _zz_111;
  wire  IBusCachedPlugin_iBusRsp_readyForError;
  wire  IBusCachedPlugin_iBusRsp_output_valid;
  wire  IBusCachedPlugin_iBusRsp_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_pc;
  wire  IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  wire  IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_1;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_2;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_3;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_4;
  reg  IBusCachedPlugin_injector_decodeRemoved;
  wire  _zz_112;
  reg [18:0] _zz_113;
  wire  _zz_114;
  reg [10:0] _zz_115;
  wire  _zz_116;
  reg [18:0] _zz_117;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  _zz_118;
  wire  IBusCachedPlugin_iBusRspOutputHalt;
  wire  _zz_119;
  reg  IBusCachedPlugin_redoFetch;
  wire  _zz_120;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [1:0] dBus_cmd_payload_size;
  wire  dBus_rsp_ready;
  wire  dBus_rsp_error;
  wire [31:0] dBus_rsp_data;
  reg [31:0] _zz_121;
  reg [3:0] _zz_122;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_123;
  reg [31:0] _zz_124;
  wire  _zz_125;
  reg [31:0] _zz_126;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [27:0] _zz_127;
  wire  _zz_128;
  wire  _zz_129;
  wire  _zz_130;
  wire  _zz_131;
  wire  _zz_132;
  wire  _zz_133;
  wire `AluCtrlEnum_binary_sequancial_type _zz_134;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_135;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_136;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_137;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_138;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_139;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_140;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_141;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_142;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_143;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_144;
  reg [31:0] _zz_145;
  wire  _zz_146;
  reg [19:0] _zz_147;
  wire  _zz_148;
  reg [19:0] _zz_149;
  reg [31:0] _zz_150;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_151;
  reg  _zz_152;
  reg  _zz_153;
  reg  _zz_154;
  reg [4:0] _zz_155;
  reg [31:0] _zz_156;
  wire  _zz_157;
  wire  _zz_158;
  wire  _zz_159;
  wire  _zz_160;
  wire  _zz_161;
  wire  _zz_162;
  wire  _zz_163;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_164;
  reg  _zz_165;
  reg  _zz_166;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_167;
  reg [19:0] _zz_168;
  wire  _zz_169;
  reg [18:0] _zz_170;
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
  reg [63:0] CsrPlugin_mcycle = 64'b1110001011011101110011110100111001010000001111001010010001000001;
  reg [63:0] CsrPlugin_minstret = 64'b1100000001110110011011100101011100010000111000011110001100111101;
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
  wire  decode_exception_agregat_valid;
  wire [3:0] decode_exception_agregat_payload_code;
  wire [31:0] decode_exception_agregat_payload_badAddr;
  wire [1:0] _zz_171;
  wire  _zz_172;
  wire [0:0] _zz_173;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_writeBackWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  _zz_174;
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
  reg [32:0] memory_MulDivIterativePlugin_rs1;
  reg [31:0] memory_MulDivIterativePlugin_rs2;
  reg [64:0] memory_MulDivIterativePlugin_accumulator;
  reg  memory_MulDivIterativePlugin_mul_counter_willIncrement;
  reg  memory_MulDivIterativePlugin_mul_counter_willClear;
  reg [5:0] memory_MulDivIterativePlugin_mul_counter_valueNext;
  reg [5:0] memory_MulDivIterativePlugin_mul_counter_value;
  wire  memory_MulDivIterativePlugin_mul_done;
  wire  memory_MulDivIterativePlugin_mul_counter_willOverflow;
  reg  memory_MulDivIterativePlugin_div_needRevert;
  reg  memory_MulDivIterativePlugin_div_counter_willIncrement;
  reg  memory_MulDivIterativePlugin_div_counter_willClear;
  reg [5:0] memory_MulDivIterativePlugin_div_counter_valueNext;
  reg [5:0] memory_MulDivIterativePlugin_div_counter_value;
  wire  memory_MulDivIterativePlugin_div_done;
  wire  memory_MulDivIterativePlugin_div_counter_willOverflow;
  reg [31:0] memory_MulDivIterativePlugin_div_result;
  wire [31:0] _zz_175;
  wire [32:0] _zz_176;
  wire [32:0] _zz_177;
  wire [31:0] _zz_178;
  wire  _zz_179;
  wire  _zz_180;
  reg [32:0] _zz_181;
  reg [31:0] _zz_182;
  reg [31:0] _zz_183;
  wire [31:0] _zz_184;
  reg `Src1CtrlEnum_binary_sequancial_type decode_to_execute_SRC1_CTRL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type decode_to_execute_ALU_BITWISE_CTRL;
  reg [31:0] memory_to_writeBack_MEMORY_READ_DATA;
  reg  decode_to_execute_IS_CSR;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg [31:0] decode_to_execute_RS1;
  reg `Src2CtrlEnum_binary_sequancial_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg `BranchCtrlEnum_binary_sequancial_type decode_to_execute_BRANCH_CTRL;
  reg `ShiftCtrlEnum_binary_sequancial_type decode_to_execute_SHIFT_CTRL;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg `EnvCtrlEnum_binary_sequancial_type decode_to_execute_ENV_CTRL;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg [31:0] decode_to_execute_RS2;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg `AluCtrlEnum_binary_sequancial_type decode_to_execute_ALU_CTRL;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  execute_to_memory_BRANCH_DO;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg [2:0] _zz_185;
  reg  _zz_186;
  reg [31:0] _zz_187;
  wire  _zz_188;
  wire  _zz_189;
  wire  _zz_190;
  wire [31:0] _zz_191;
  reg  _zz_192;
  reg  _zz_193;
  reg  _zz_194;
  reg [31:0] _zz_195;
  reg [31:0] _zz_196;
  reg [1:0] _zz_197;
  reg [3:0] _zz_198;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign iBusWishbone_CYC = _zz_211;
  assign dBusWishbone_WE = _zz_212;
  assign _zz_234 = (memory_arbitration_isValid && memory_IS_MUL);
  assign _zz_235 = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_236 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET));
  assign _zz_237 = (! execute_arbitration_isStuckByOthers);
  assign _zz_238 = (iBus_cmd_valid || (_zz_185 != (3'b000)));
  assign _zz_239 = (CsrPlugin_exception || CsrPlugin_interruptJump);
  assign _zz_240 = (! memory_arbitration_isStuck);
  assign _zz_241 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_242 = (! memory_MulDivIterativePlugin_mul_done);
  assign _zz_243 = (! _zz_192);
  assign _zz_244 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_245 = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  assign _zz_246 = (! memory_MulDivIterativePlugin_div_done);
  assign _zz_247 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_248 = execute_INSTRUCTION[13];
  assign _zz_249 = (_zz_97 - (4'b0001));
  assign _zz_250 = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_251 = {29'd0, _zz_250};
  assign _zz_252 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_253 = {{_zz_113,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_254 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_255 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_256 = _zz_127[0 : 0];
  assign _zz_257 = _zz_127[1 : 1];
  assign _zz_258 = _zz_127[2 : 2];
  assign _zz_259 = _zz_127[5 : 5];
  assign _zz_260 = _zz_127[6 : 6];
  assign _zz_261 = _zz_127[7 : 7];
  assign _zz_262 = _zz_127[12 : 12];
  assign _zz_263 = _zz_127[13 : 13];
  assign _zz_264 = _zz_127[14 : 14];
  assign _zz_265 = _zz_127[19 : 19];
  assign _zz_266 = _zz_127[20 : 20];
  assign _zz_267 = _zz_127[23 : 23];
  assign _zz_268 = _zz_127[24 : 24];
  assign _zz_269 = _zz_127[25 : 25];
  assign _zz_270 = execute_SRC_LESS;
  assign _zz_271 = (3'b100);
  assign _zz_272 = execute_INSTRUCTION[31 : 20];
  assign _zz_273 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_274 = ($signed(_zz_275) + $signed(_zz_279));
  assign _zz_275 = ($signed(_zz_276) + $signed(_zz_277));
  assign _zz_276 = execute_SRC1;
  assign _zz_277 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_278 = (execute_SRC_USE_SUB_LESS ? _zz_280 : _zz_281);
  assign _zz_279 = {{30{_zz_278[1]}}, _zz_278};
  assign _zz_280 = (2'b01);
  assign _zz_281 = (2'b00);
  assign _zz_282 = (_zz_283 >>> 1);
  assign _zz_283 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_284 = execute_INSTRUCTION[31 : 20];
  assign _zz_285 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_286 = (3'b100);
  assign _zz_287 = {29'd0, _zz_286};
  assign _zz_288 = (_zz_171 & (~ _zz_289));
  assign _zz_289 = (_zz_171 - (2'b01));
  assign _zz_290 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_291 = {1'd0, _zz_290};
  assign _zz_292 = execute_INSTRUCTION[19 : 15];
  assign _zz_293 = {27'd0, _zz_292};
  assign _zz_294 = memory_MulDivIterativePlugin_mul_counter_willIncrement;
  assign _zz_295 = {5'd0, _zz_294};
  assign _zz_296 = (_zz_298 + _zz_300);
  assign _zz_297 = (memory_MulDivIterativePlugin_rs2[0] ? memory_MulDivIterativePlugin_rs1 : (33'b000000000000000000000000000000000));
  assign _zz_298 = {{1{_zz_297[32]}}, _zz_297};
  assign _zz_299 = _zz_301;
  assign _zz_300 = {{1{_zz_299[32]}}, _zz_299};
  assign _zz_301 = (memory_MulDivIterativePlugin_accumulator >>> 32);
  assign _zz_302 = memory_MulDivIterativePlugin_div_counter_willIncrement;
  assign _zz_303 = {5'd0, _zz_302};
  assign _zz_304 = {1'd0, memory_MulDivIterativePlugin_rs2};
  assign _zz_305 = {_zz_175,(! _zz_177[32])};
  assign _zz_306 = _zz_177[31:0];
  assign _zz_307 = _zz_176[31:0];
  assign _zz_308 = _zz_309;
  assign _zz_309 = _zz_310;
  assign _zz_310 = ({1'b0,(memory_MulDivIterativePlugin_div_needRevert ? (~ _zz_178) : _zz_178)} + _zz_312);
  assign _zz_311 = memory_MulDivIterativePlugin_div_needRevert;
  assign _zz_312 = {32'd0, _zz_311};
  assign _zz_313 = _zz_180;
  assign _zz_314 = {32'd0, _zz_313};
  assign _zz_315 = _zz_179;
  assign _zz_316 = {31'd0, _zz_315};
  assign _zz_317 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_318 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_319 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_320 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_321 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_322 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_323 = (iBus_cmd_payload_address >>> 5);
  assign _zz_324 = ({3'd0,_zz_198} <<< _zz_191[1 : 0]);
  assign _zz_325 = {_zz_101,_zz_100};
  assign _zz_326 = decode_INSTRUCTION[31];
  assign _zz_327 = decode_INSTRUCTION[19 : 12];
  assign _zz_328 = decode_INSTRUCTION[20];
  assign _zz_329 = decode_INSTRUCTION[31];
  assign _zz_330 = decode_INSTRUCTION[7];
  assign _zz_331 = (32'b00000000000000000000000000010100);
  assign _zz_332 = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_333 = (32'b00000000000000000000000000000100);
  assign _zz_334 = ((decode_INSTRUCTION & (32'b00000010000000000100000001110100)) == (32'b00000010000000000000000000110000));
  assign _zz_335 = {(_zz_340 == _zz_341),(_zz_342 == _zz_343)};
  assign _zz_336 = (2'b00);
  assign _zz_337 = ((_zz_344 == _zz_345) != (1'b0));
  assign _zz_338 = ({_zz_346,_zz_347} != (2'b00));
  assign _zz_339 = {(_zz_348 != _zz_349),{_zz_350,{_zz_351,_zz_352}}};
  assign _zz_340 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_341 = (32'b00000000000000000010000000000000);
  assign _zz_342 = (decode_INSTRUCTION & (32'b00000000000000000101000000000000));
  assign _zz_343 = (32'b00000000000000000001000000000000);
  assign _zz_344 = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_345 = (32'b00000000000000000000000000000000);
  assign _zz_346 = ((decode_INSTRUCTION & _zz_353) == (32'b00000000000000000101000000010000));
  assign _zz_347 = ((decode_INSTRUCTION & _zz_354) == (32'b00000000000000000101000000100000));
  assign _zz_348 = {(_zz_355 == _zz_356),{_zz_357,_zz_358}};
  assign _zz_349 = (3'b000);
  assign _zz_350 = ((_zz_359 == _zz_360) != (1'b0));
  assign _zz_351 = ({_zz_361,_zz_362} != (2'b00));
  assign _zz_352 = {(_zz_363 != _zz_364),{_zz_365,{_zz_366,_zz_367}}};
  assign _zz_353 = (32'b00000000000000000111000000110100);
  assign _zz_354 = (32'b00000010000000000111000001100100);
  assign _zz_355 = (decode_INSTRUCTION & (32'b01000000000000000011000001010100));
  assign _zz_356 = (32'b01000000000000000001000000010000);
  assign _zz_357 = ((decode_INSTRUCTION & (32'b00000000000000000111000000110100)) == (32'b00000000000000000001000000010000));
  assign _zz_358 = ((decode_INSTRUCTION & (32'b00000010000000000111000001010100)) == (32'b00000000000000000001000000010000));
  assign _zz_359 = (decode_INSTRUCTION & (32'b00000000000000000000000000010000));
  assign _zz_360 = (32'b00000000000000000000000000010000);
  assign _zz_361 = _zz_131;
  assign _zz_362 = _zz_129;
  assign _zz_363 = ((decode_INSTRUCTION & (32'b00000000000000000011000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_364 = (1'b0);
  assign _zz_365 = 1'b0;
  assign _zz_366 = ({_zz_128,_zz_368} != (2'b00));
  assign _zz_367 = {({_zz_369,_zz_370} != (2'b00)),{(_zz_371 != _zz_372),{_zz_373,{_zz_374,_zz_375}}}};
  assign _zz_368 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_369 = _zz_128;
  assign _zz_370 = ((decode_INSTRUCTION & _zz_376) == (32'b00000000000000000000000000000000));
  assign _zz_371 = {(_zz_377 == _zz_378),(_zz_379 == _zz_380)};
  assign _zz_372 = (2'b00);
  assign _zz_373 = ({_zz_133,{_zz_381,_zz_382}} != (6'b000000));
  assign _zz_374 = ({_zz_383,_zz_384} != (2'b00));
  assign _zz_375 = {(_zz_385 != _zz_386),{_zz_387,{_zz_388,_zz_389}}};
  assign _zz_376 = (32'b00000000000000000000000000100000);
  assign _zz_377 = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_378 = (32'b00000000000000000000000000100000);
  assign _zz_379 = (decode_INSTRUCTION & (32'b00000000000000000000000001010100));
  assign _zz_380 = (32'b00000000000000000000000001000000);
  assign _zz_381 = ((decode_INSTRUCTION & _zz_390) == (32'b00000000000000000001000000010000));
  assign _zz_382 = {(_zz_391 == _zz_392),{_zz_393,{_zz_394,_zz_395}}};
  assign _zz_383 = ((decode_INSTRUCTION & _zz_396) == (32'b00000000000000000001000001010000));
  assign _zz_384 = ((decode_INSTRUCTION & _zz_397) == (32'b00000000000000000010000001010000));
  assign _zz_385 = {_zz_133,(_zz_398 == _zz_399)};
  assign _zz_386 = (2'b00);
  assign _zz_387 = ((_zz_400 == _zz_401) != (1'b0));
  assign _zz_388 = ({_zz_402,_zz_403} != (2'b00));
  assign _zz_389 = {(_zz_404 != _zz_405),{_zz_406,{_zz_407,_zz_408}}};
  assign _zz_390 = (32'b00000000000000000001000000010000);
  assign _zz_391 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_392 = (32'b00000000000000000010000000010000);
  assign _zz_393 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000010000));
  assign _zz_394 = ((decode_INSTRUCTION & _zz_409) == (32'b00000000000000000000000000000100));
  assign _zz_395 = ((decode_INSTRUCTION & _zz_410) == (32'b00000000000000000000000000000000));
  assign _zz_396 = (32'b00000000000000000001000001010000);
  assign _zz_397 = (32'b00000000000000000010000001010000);
  assign _zz_398 = (decode_INSTRUCTION & (32'b00000000000000000100000000010100));
  assign _zz_399 = (32'b00000000000000000000000000000100);
  assign _zz_400 = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_401 = (32'b00000000000000000000000001000000);
  assign _zz_402 = ((decode_INSTRUCTION & _zz_411) == (32'b00000000000000000001000000000000));
  assign _zz_403 = _zz_128;
  assign _zz_404 = {_zz_128,{_zz_412,_zz_130}};
  assign _zz_405 = (3'b000);
  assign _zz_406 = ((_zz_413 == _zz_414) != (1'b0));
  assign _zz_407 = (_zz_415 != (1'b0));
  assign _zz_408 = {(_zz_416 != _zz_417),{_zz_418,{_zz_419,_zz_420}}};
  assign _zz_409 = (32'b00000000000000000100000000000100);
  assign _zz_410 = (32'b00000000000000000000000000101000);
  assign _zz_411 = (32'b00000000000000000001000000000000);
  assign _zz_412 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_413 = (decode_INSTRUCTION & (32'b00000000000000000000000001001000));
  assign _zz_414 = (32'b00000000000000000000000000001000);
  assign _zz_415 = ((decode_INSTRUCTION & (32'b00000010000000000100000001100100)) == (32'b00000010000000000100000000100000));
  assign _zz_416 = {(_zz_421 == _zz_422),{_zz_423,_zz_424}};
  assign _zz_417 = (3'b000);
  assign _zz_418 = ({_zz_425,{_zz_426,_zz_427}} != (3'b000));
  assign _zz_419 = (_zz_132 != (1'b0));
  assign _zz_420 = {(_zz_428 != _zz_429),{_zz_430,_zz_431}};
  assign _zz_421 = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_422 = (32'b00000000000000000000000001000000);
  assign _zz_423 = ((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000));
  assign _zz_424 = ((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000));
  assign _zz_425 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000));
  assign _zz_426 = ((decode_INSTRUCTION & _zz_432) == (32'b00000000000000000000000000100100));
  assign _zz_427 = ((decode_INSTRUCTION & _zz_433) == (32'b00000000000000000001000000000000));
  assign _zz_428 = {(_zz_434 == _zz_435),{_zz_436,{_zz_437,_zz_438}}};
  assign _zz_429 = (4'b0000);
  assign _zz_430 = ({_zz_131,{_zz_439,_zz_440}} != (3'b000));
  assign _zz_431 = ({_zz_441,{_zz_442,_zz_443}} != (4'b0000));
  assign _zz_432 = (32'b00000000000000000000000001100100);
  assign _zz_433 = (32'b00000000000000000011000000000100);
  assign _zz_434 = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_435 = (32'b00000000000000000000000000000000);
  assign _zz_436 = ((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000));
  assign _zz_437 = _zz_132;
  assign _zz_438 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_439 = _zz_130;
  assign _zz_440 = _zz_129;
  assign _zz_441 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_442 = _zz_128;
  assign _zz_443 = {((decode_INSTRUCTION & (32'b00000000000000000000000000110000)) == (32'b00000000000000000000000000010000)),((decode_INSTRUCTION & (32'b00000010000000000000000000100000)) == (32'b00000000000000000000000000100000))};
  assign _zz_444 = (32'b00000000000000000010000001111111);
  assign _zz_445 = (decode_INSTRUCTION & (32'b00000000001000000000000001111111));
  assign _zz_446 = (32'b00000000000000000000000001101111);
  assign _zz_447 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_448 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011));
  assign _zz_449 = {((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_450) == (32'b00000000000000000100000001100011)),{(_zz_451 == _zz_452),{_zz_453,{_zz_454,_zz_455}}}}}};
  assign _zz_450 = (32'b00000000000000000100000101111111);
  assign _zz_451 = (decode_INSTRUCTION & (32'b00000000000000000010000101111111));
  assign _zz_452 = (32'b00000000000000000000000001100011);
  assign _zz_453 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000100000000001111));
  assign _zz_454 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000000000001100111));
  assign _zz_455 = {((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b11111100000000000011000001011111)) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & _zz_456) == (32'b00000000000000000101000000010011)),{(_zz_457 == _zz_458),{_zz_459,_zz_460}}}}};
  assign _zz_456 = (32'b10111100000000000111000001111111);
  assign _zz_457 = (decode_INSTRUCTION & (32'b10111110000000000111000001111111));
  assign _zz_458 = (32'b00000000000000000101000000110011);
  assign _zz_459 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_460 = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00110000001000000000000001110011));
  always @ (posedge clk) begin
    if(_zz_44) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_141) begin
      _zz_209 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_142) begin
      _zz_210 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_199),
    .io_flush_cmd_ready(_zz_216),
    .io_flush_rsp(_zz_217),
    .io_cpu_prefetch_isValid(IBusCachedPlugin_fetchPc_output_valid),
    .io_cpu_prefetch_haltIt(_zz_218),
    .io_cpu_prefetch_pc(IBusCachedPlugin_fetchPc_output_payload),
    .io_cpu_fetch_isValid(IBusCachedPlugin_iBusRsp_inputPipeline_0_valid),
    .io_cpu_fetch_isStuck(_zz_200),
    .io_cpu_fetch_isRemoved(_zz_201),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_inputPipeline_0_payload),
    .io_cpu_fetch_data(_zz_219),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_221),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_222),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_223),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_89),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_202),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_203),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_204),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_205),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_206),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_90),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_91),
    .io_cpu_fetch_mmuBus_end(_zz_224),
    .io_cpu_fetch_physicalAddress(_zz_220),
    .io_cpu_decode_isValid(IBusCachedPlugin_cacheRspArbitration_valid),
    .io_cpu_decode_isStuck(_zz_207),
    .io_cpu_decode_pc(IBusCachedPlugin_cacheRspArbitration_payload),
    .io_cpu_decode_physicalAddress(_zz_230),
    .io_cpu_decode_data(_zz_228),
    .io_cpu_decode_cacheMiss(_zz_229),
    .io_cpu_decode_error(_zz_225),
    .io_cpu_decode_mmuMiss(_zz_226),
    .io_cpu_decode_illegalAccess(_zz_227),
    .io_cpu_decode_isUser(_zz_208),
    .io_cpu_fill_valid(IBusCachedPlugin_redoFetch),
    .io_cpu_fill_payload(_zz_230),
    .io_mem_cmd_valid(_zz_231),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_232),
    .io_mem_cmd_payload_size(_zz_233),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_325)
      2'b00 : begin
        _zz_213 = _zz_95;
      end
      2'b01 : begin
        _zz_213 = _zz_93;
      end
      2'b10 : begin
        _zz_213 = _zz_87;
      end
      default : begin
        _zz_213 = _zz_84;
      end
    endcase
  end

  always @(*) begin
    case(_zz_173)
      1'b0 : begin
        _zz_214 = (_zz_226 ? (4'b1110) : (4'b0001));
        _zz_215 = IBusCachedPlugin_cacheRspArbitration_payload;
      end
      default : begin
        _zz_214 = decodeExceptionPort_payload_code;
        _zz_215 = decodeExceptionPort_payload_badAddr;
      end
    endcase
  end

  assign decode_CSR_READ_OPCODE = _zz_21;
  assign execute_BRANCH_DO = _zz_25;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_40;
  assign decode_IS_DIV = _zz_62;
  assign decode_ALU_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_67;
  assign decode_SRC_LESS_UNSIGNED = _zz_49;
  assign decode_IS_RS2_SIGNED = _zz_53;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_52;
  assign execute_BRANCH_CALC = _zz_24;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_78;
  assign decode_IS_RS1_SIGNED = _zz_66;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_27;
  assign memory_PC = execute_to_memory_PC;
  assign decode_IS_MUL = _zz_48;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_71;
  assign decode_ENV_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign decode_SHIFT_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign _zz_10 = _zz_11;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_61;
  assign decode_SRC2_CTRL = _zz_12;
  assign _zz_13 = _zz_14;
  assign decode_MEMORY_ENABLE = _zz_50;
  assign memory_MEMORY_READ_DATA = _zz_70;
  assign decode_ALU_BITWISE_CTRL = _zz_15;
  assign _zz_16 = _zz_17;
  assign decode_CSR_WRITE_OPCODE = _zz_22;
  assign decode_SRC_USE_SUB_LESS = _zz_63;
  assign decode_SRC1_CTRL = _zz_18;
  assign _zz_19 = _zz_20;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign decode_IS_CSR = _zz_58;
  assign execute_ENV_CTRL = _zz_23;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_26;
  assign decode_RS2_USE = _zz_56;
  assign decode_RS1_USE = _zz_65;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  always @ (*) begin
    _zz_28 = memory_REGFILE_WRITE_DATA;
    _zz_29 = execute_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_haltItself = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    memory_arbitration_flushAll = 1'b0;
    _zz_94 = 1'b0;
    _zz_95 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    _zz_199 = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_199 = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_216))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(_zz_241)begin
      _zz_29 = _zz_151;
      if(_zz_237)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
    if(_zz_239)begin
      _zz_94 = 1'b1;
      _zz_95 = CsrPlugin_mtvec;
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_236)begin
      if(_zz_245)begin
        execute_arbitration_haltItself = 1'b1;
      end else begin
        _zz_94 = 1'b1;
        _zz_95 = CsrPlugin_mepc;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_readDataRegValid)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_29 = execute_CsrPlugin_readData;
    end
    memory_MulDivIterativePlugin_mul_counter_willIncrement = 1'b0;
    if(_zz_234)begin
      if(_zz_242)begin
        memory_arbitration_haltItself = 1'b1;
        memory_MulDivIterativePlugin_mul_counter_willIncrement = 1'b1;
      end
      _zz_28 = ((memory_INSTRUCTION[13 : 12] == (2'b00)) ? memory_MulDivIterativePlugin_accumulator[31 : 0] : memory_MulDivIterativePlugin_accumulator[63 : 32]);
    end
    memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b0;
    if(_zz_244)begin
      if(_zz_246)begin
        memory_arbitration_haltItself = 1'b1;
        memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_28 = memory_MulDivIterativePlugin_div_result;
    end
  end

  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_45;
    decode_RS1 = _zz_46;
    if(_zz_154)begin
      if((_zz_155 == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_156;
      end
      if((_zz_155 == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_156;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(_zz_157)begin
        if(_zz_158)begin
          decode_RS1 = _zz_69;
        end
        if(_zz_159)begin
          decode_RS2 = _zz_69;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_160)begin
          decode_RS1 = _zz_28;
        end
        if(_zz_161)begin
          decode_RS2 = _zz_28;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_162)begin
          decode_RS1 = _zz_29;
        end
        if(_zz_163)begin
          decode_RS2 = _zz_29;
        end
      end
    end
  end

  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_SHIFT_CTRL = _zz_30;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_34 = execute_PC;
  assign execute_SRC2_CTRL = _zz_35;
  assign execute_SRC1_CTRL = _zz_37;
  assign execute_SRC_ADD_SUB = _zz_33;
  assign execute_SRC_LESS = _zz_31;
  assign execute_ALU_CTRL = _zz_39;
  assign execute_SRC2 = _zz_36;
  assign execute_SRC1 = _zz_38;
  assign execute_ALU_BITWISE_CTRL = _zz_41;
  assign _zz_42 = writeBack_INSTRUCTION;
  assign _zz_43 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_44 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_44 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_74;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_57;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_68;
  assign decode_INSTRUCTION_READY = _zz_79;
  always @ (*) begin
    _zz_69 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_69 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_SRC_ADD = _zz_32;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_ALIGNEMENT_FAULT = _zz_72;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_issueDetected = _zz_73;
    _zz_88 = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && ((_zz_225 || _zz_226) || _zz_227)) && (! _zz_73)))begin
      IBusCachedPlugin_issueDetected = 1'b1;
      _zz_88 = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    _zz_73 = _zz_119;
    IBusCachedPlugin_redoFetch = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && _zz_229) && (! _zz_119)))begin
      _zz_73 = 1'b1;
      IBusCachedPlugin_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_75;
  always @ (*) begin
    _zz_76 = memory_FORMAL_PC_NEXT;
    if(_zz_92)begin
      _zz_76 = _zz_93;
    end
  end

  always @ (*) begin
    _zz_77 = decode_FORMAL_PC_NEXT;
    if(_zz_83)begin
      _zz_77 = _zz_84;
    end
    if(_zz_86)begin
      _zz_77 = _zz_87;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_81;
  assign decode_INSTRUCTION = _zz_80;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if((decode_arbitration_isValid && (_zz_152 || _zz_153)))begin
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
    if(_zz_92)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
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
  assign _zz_82 = 1'b0;
  assign IBusCachedPlugin_jump_pcLoad_valid = (((_zz_83 || _zz_86) || _zz_92) || _zz_94);
  assign _zz_97 = {_zz_83,{_zz_86,{_zz_92,_zz_94}}};
  assign _zz_98 = (_zz_97 & (~ _zz_249));
  assign _zz_99 = _zz_98[3];
  assign _zz_100 = (_zz_98[1] || _zz_99);
  assign _zz_101 = (_zz_98[2] || _zz_99);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_213;
  assign _zz_102 = (! 1'b0);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_102);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_102);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_251);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_235)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_103;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b0;
    if(((_zz_221 && (! _zz_91)) && (! _zz_90)))begin
      IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_input_ready = ((1'b0 && (! _zz_104)) || IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_104 = _zz_105;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_valid = _zz_104;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_payload = _zz_106;
  assign _zz_107 = (! IBusCachedPlugin_iBusRsp_inputPipelineHalt_0);
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_ready = (_zz_108 && _zz_107);
  assign _zz_108 = ((1'b0 && (! _zz_109)) || IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_109 = _zz_110;
  assign IBusCachedPlugin_cacheRspArbitration_valid = _zz_109;
  assign IBusCachedPlugin_cacheRspArbitration_payload = _zz_111;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck);
  assign decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_output_valid && (! IBusCachedPlugin_injector_decodeRemoved));
  assign _zz_81 = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign _zz_80 = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  assign _zz_79 = 1'b1;
  assign _zz_78 = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_112 = _zz_252[11];
  always @ (*) begin
    _zz_113[18] = _zz_112;
    _zz_113[17] = _zz_112;
    _zz_113[16] = _zz_112;
    _zz_113[15] = _zz_112;
    _zz_113[14] = _zz_112;
    _zz_113[13] = _zz_112;
    _zz_113[12] = _zz_112;
    _zz_113[11] = _zz_112;
    _zz_113[10] = _zz_112;
    _zz_113[9] = _zz_112;
    _zz_113[8] = _zz_112;
    _zz_113[7] = _zz_112;
    _zz_113[6] = _zz_112;
    _zz_113[5] = _zz_112;
    _zz_113[4] = _zz_112;
    _zz_113[3] = _zz_112;
    _zz_113[2] = _zz_112;
    _zz_113[1] = _zz_112;
    _zz_113[0] = _zz_112;
  end

  assign _zz_85 = ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_B) && _zz_253[31]));
  assign _zz_83 = (_zz_85 && decode_arbitration_isFiring);
  assign _zz_114 = _zz_254[19];
  always @ (*) begin
    _zz_115[10] = _zz_114;
    _zz_115[9] = _zz_114;
    _zz_115[8] = _zz_114;
    _zz_115[7] = _zz_114;
    _zz_115[6] = _zz_114;
    _zz_115[5] = _zz_114;
    _zz_115[4] = _zz_114;
    _zz_115[3] = _zz_114;
    _zz_115[2] = _zz_114;
    _zz_115[1] = _zz_114;
    _zz_115[0] = _zz_114;
  end

  assign _zz_116 = _zz_255[11];
  always @ (*) begin
    _zz_117[18] = _zz_116;
    _zz_117[17] = _zz_116;
    _zz_117[16] = _zz_116;
    _zz_117[15] = _zz_116;
    _zz_117[14] = _zz_116;
    _zz_117[13] = _zz_116;
    _zz_117[12] = _zz_116;
    _zz_117[11] = _zz_116;
    _zz_117[10] = _zz_116;
    _zz_117[9] = _zz_116;
    _zz_117[8] = _zz_116;
    _zz_117[7] = _zz_116;
    _zz_117[6] = _zz_116;
    _zz_117[5] = _zz_116;
    _zz_117[4] = _zz_116;
    _zz_117[3] = _zz_116;
    _zz_117[2] = _zz_116;
    _zz_117[1] = _zz_116;
    _zz_117[0] = _zz_116;
  end

  assign _zz_84 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) ? {{_zz_115,{{{_zz_326,_zz_327},_zz_328},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_117,{{{_zz_329,_zz_330},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = _zz_231;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_232;
    iBus_cmd_payload_address = _zz_232;
  end

  assign iBus_cmd_payload_size = _zz_233;
  assign _zz_118 = (! _zz_218);
  assign IBusCachedPlugin_fetchPc_output_ready = (IBusCachedPlugin_iBusRsp_input_ready && _zz_118);
  assign IBusCachedPlugin_iBusRsp_input_valid = (IBusCachedPlugin_fetchPc_output_valid && _zz_118);
  assign IBusCachedPlugin_iBusRsp_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign _zz_201 = (IBusCachedPlugin_jump_pcLoad_valid || _zz_82);
  assign IBusCachedPlugin_iBusRspOutputHalt = 1'b0;
  assign _zz_202 = _zz_89[31];
  assign _zz_203 = 1'b1;
  assign _zz_204 = 1'b1;
  assign _zz_205 = 1'b1;
  assign _zz_206 = 1'b1;
  assign _zz_200 = (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_207 = (! IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_208 = (_zz_96 == (2'b00));
  assign _zz_74 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_219);
  assign _zz_119 = 1'b0;
  assign _zz_86 = IBusCachedPlugin_redoFetch;
  assign _zz_87 = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_120 = (! (IBusCachedPlugin_issueDetected || IBusCachedPlugin_iBusRspOutputHalt));
  assign IBusCachedPlugin_cacheRspArbitration_ready = (IBusCachedPlugin_iBusRsp_output_ready && _zz_120);
  assign IBusCachedPlugin_iBusRsp_output_valid = (IBusCachedPlugin_cacheRspArbitration_valid && _zz_120);
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = _zz_228;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_72 = 1'b0;
  assign dBus_cmd_valid = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign dBus_cmd_payload_wr = execute_INSTRUCTION[5];
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_121 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_121 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_121 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_121;
  assign _zz_71 = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_122 = (4'b0001);
      end
      2'b01 : begin
        _zz_122 = (4'b0011);
      end
      default : begin
        _zz_122 = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_122 <<< dBus_cmd_payload_address[1 : 0]);
  assign _zz_70 = dBus_rsp_data;
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

  assign _zz_123 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_124[31] = _zz_123;
    _zz_124[30] = _zz_123;
    _zz_124[29] = _zz_123;
    _zz_124[28] = _zz_123;
    _zz_124[27] = _zz_123;
    _zz_124[26] = _zz_123;
    _zz_124[25] = _zz_123;
    _zz_124[24] = _zz_123;
    _zz_124[23] = _zz_123;
    _zz_124[22] = _zz_123;
    _zz_124[21] = _zz_123;
    _zz_124[20] = _zz_123;
    _zz_124[19] = _zz_123;
    _zz_124[18] = _zz_123;
    _zz_124[17] = _zz_123;
    _zz_124[16] = _zz_123;
    _zz_124[15] = _zz_123;
    _zz_124[14] = _zz_123;
    _zz_124[13] = _zz_123;
    _zz_124[12] = _zz_123;
    _zz_124[11] = _zz_123;
    _zz_124[10] = _zz_123;
    _zz_124[9] = _zz_123;
    _zz_124[8] = _zz_123;
    _zz_124[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_125 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_126[31] = _zz_125;
    _zz_126[30] = _zz_125;
    _zz_126[29] = _zz_125;
    _zz_126[28] = _zz_125;
    _zz_126[27] = _zz_125;
    _zz_126[26] = _zz_125;
    _zz_126[25] = _zz_125;
    _zz_126[24] = _zz_125;
    _zz_126[23] = _zz_125;
    _zz_126[22] = _zz_125;
    _zz_126[21] = _zz_125;
    _zz_126[20] = _zz_125;
    _zz_126[19] = _zz_125;
    _zz_126[18] = _zz_125;
    _zz_126[17] = _zz_125;
    _zz_126[16] = _zz_125;
    _zz_126[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_247)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_124;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_126;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_89 = _zz_222;
  assign _zz_90 = 1'b0;
  assign _zz_91 = 1'b1;
  assign _zz_128 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_129 = ((decode_INSTRUCTION & (32'b00000000000000000111000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_130 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_131 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000100000000000000));
  assign _zz_132 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_133 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_127 = {(((decode_INSTRUCTION & _zz_331) == (32'b00000000000000000000000000000100)) != (1'b0)),{((_zz_332 == _zz_333) != (1'b0)),{(_zz_334 != (1'b0)),{(_zz_335 != _zz_336),{_zz_337,{_zz_338,_zz_339}}}}}};
  assign _zz_68 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000001000001111111)) == (32'b00000000000000000001000001110011)),{((decode_INSTRUCTION & _zz_444) == (32'b00000000000000000010000001110011)),{(_zz_445 == _zz_446),{_zz_447,{_zz_448,_zz_449}}}}}}} != (19'b0000000000000000000));
  assign _zz_67 = _zz_256[0];
  assign _zz_66 = _zz_257[0];
  assign _zz_65 = _zz_258[0];
  assign _zz_134 = _zz_127[4 : 3];
  assign _zz_64 = _zz_134;
  assign _zz_63 = _zz_259[0];
  assign _zz_62 = _zz_260[0];
  assign _zz_61 = _zz_261[0];
  assign _zz_135 = _zz_127[9 : 8];
  assign _zz_60 = _zz_135;
  assign _zz_136 = _zz_127[11 : 10];
  assign _zz_59 = _zz_136;
  assign _zz_58 = _zz_262[0];
  assign _zz_57 = _zz_263[0];
  assign _zz_56 = _zz_264[0];
  assign _zz_137 = _zz_127[16 : 15];
  assign _zz_55 = _zz_137;
  assign _zz_138 = _zz_127[18 : 17];
  assign _zz_54 = _zz_138;
  assign _zz_53 = _zz_265[0];
  assign _zz_52 = _zz_266[0];
  assign _zz_139 = _zz_127[22 : 21];
  assign _zz_51 = _zz_139;
  assign _zz_50 = _zz_267[0];
  assign _zz_49 = _zz_268[0];
  assign _zz_48 = _zz_269[0];
  assign _zz_140 = _zz_127[27 : 26];
  assign _zz_47 = _zz_140;
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_141 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_209;
  assign _zz_142 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_210;
  assign _zz_46 = decode_RegFilePlugin_rs1Data;
  assign _zz_45 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_43 && writeBack_arbitration_isFiring);
    if(_zz_143)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_42[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_69;
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
        _zz_144 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_144 = {31'd0, _zz_270};
      end
      default : begin
        _zz_144 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_40 = _zz_144;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_145 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_PC_INCREMENT : begin
        _zz_145 = {29'd0, _zz_271};
      end
      default : begin
        _zz_145 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_38 = _zz_145;
  assign _zz_146 = _zz_272[11];
  always @ (*) begin
    _zz_147[19] = _zz_146;
    _zz_147[18] = _zz_146;
    _zz_147[17] = _zz_146;
    _zz_147[16] = _zz_146;
    _zz_147[15] = _zz_146;
    _zz_147[14] = _zz_146;
    _zz_147[13] = _zz_146;
    _zz_147[12] = _zz_146;
    _zz_147[11] = _zz_146;
    _zz_147[10] = _zz_146;
    _zz_147[9] = _zz_146;
    _zz_147[8] = _zz_146;
    _zz_147[7] = _zz_146;
    _zz_147[6] = _zz_146;
    _zz_147[5] = _zz_146;
    _zz_147[4] = _zz_146;
    _zz_147[3] = _zz_146;
    _zz_147[2] = _zz_146;
    _zz_147[1] = _zz_146;
    _zz_147[0] = _zz_146;
  end

  assign _zz_148 = _zz_273[11];
  always @ (*) begin
    _zz_149[19] = _zz_148;
    _zz_149[18] = _zz_148;
    _zz_149[17] = _zz_148;
    _zz_149[16] = _zz_148;
    _zz_149[15] = _zz_148;
    _zz_149[14] = _zz_148;
    _zz_149[13] = _zz_148;
    _zz_149[12] = _zz_148;
    _zz_149[11] = _zz_148;
    _zz_149[10] = _zz_148;
    _zz_149[9] = _zz_148;
    _zz_149[8] = _zz_148;
    _zz_149[7] = _zz_148;
    _zz_149[6] = _zz_148;
    _zz_149[5] = _zz_148;
    _zz_149[4] = _zz_148;
    _zz_149[3] = _zz_148;
    _zz_149[2] = _zz_148;
    _zz_149[1] = _zz_148;
    _zz_149[0] = _zz_148;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_150 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_150 = {_zz_147,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_150 = {_zz_149,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_150 = _zz_34;
      end
    endcase
  end

  assign _zz_36 = _zz_150;
  assign execute_SrcPlugin_addSub = _zz_274;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_33 = execute_SrcPlugin_addSub;
  assign _zz_32 = execute_SrcPlugin_addSub;
  assign _zz_31 = execute_SrcPlugin_less;
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_binary_sequancial_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_151 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_151 = _zz_282;
      end
    endcase
  end

  always @ (*) begin
    _zz_152 = 1'b0;
    _zz_153 = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! _zz_157)))begin
        if(_zz_158)begin
          _zz_152 = 1'b1;
        end
        if(_zz_159)begin
          _zz_153 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_160)begin
          _zz_152 = 1'b1;
        end
        if(_zz_161)begin
          _zz_153 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_162)begin
          _zz_152 = 1'b1;
        end
        if(_zz_163)begin
          _zz_153 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_152 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_153 = 1'b0;
    end
  end

  assign _zz_157 = 1'b1;
  assign _zz_158 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_159 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_160 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_161 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_162 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_163 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_27 = _zz_85;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_164 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_164 == (3'b000))) begin
        _zz_165 = execute_BranchPlugin_eq;
    end else if((_zz_164 == (3'b001))) begin
        _zz_165 = (! execute_BranchPlugin_eq);
    end else if((((_zz_164 & (3'b101)) == (3'b101)))) begin
        _zz_165 = (! execute_SRC_LESS);
    end else begin
        _zz_165 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_166 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_166 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_166 = 1'b1;
      end
      default : begin
        _zz_166 = _zz_165;
      end
    endcase
  end

  assign _zz_25 = (execute_PREDICTION_HAD_BRANCHED2 != _zz_166);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_168,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = (execute_PREDICTION_HAD_BRANCHED2 ? _zz_287 : {{_zz_170,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
      end
    endcase
  end

  assign _zz_167 = _zz_284[11];
  always @ (*) begin
    _zz_168[19] = _zz_167;
    _zz_168[18] = _zz_167;
    _zz_168[17] = _zz_167;
    _zz_168[16] = _zz_167;
    _zz_168[15] = _zz_167;
    _zz_168[14] = _zz_167;
    _zz_168[13] = _zz_167;
    _zz_168[12] = _zz_167;
    _zz_168[11] = _zz_167;
    _zz_168[10] = _zz_167;
    _zz_168[9] = _zz_167;
    _zz_168[8] = _zz_167;
    _zz_168[7] = _zz_167;
    _zz_168[6] = _zz_167;
    _zz_168[5] = _zz_167;
    _zz_168[4] = _zz_167;
    _zz_168[3] = _zz_167;
    _zz_168[2] = _zz_167;
    _zz_168[1] = _zz_167;
    _zz_168[0] = _zz_167;
  end

  assign _zz_169 = _zz_285[11];
  always @ (*) begin
    _zz_170[18] = _zz_169;
    _zz_170[17] = _zz_169;
    _zz_170[16] = _zz_169;
    _zz_170[15] = _zz_169;
    _zz_170[14] = _zz_169;
    _zz_170[13] = _zz_169;
    _zz_170[12] = _zz_169;
    _zz_170[11] = _zz_169;
    _zz_170[10] = _zz_169;
    _zz_170[9] = _zz_169;
    _zz_170[8] = _zz_169;
    _zz_170[7] = _zz_169;
    _zz_170[6] = _zz_169;
    _zz_170[5] = _zz_169;
    _zz_170[4] = _zz_169;
    _zz_170[3] = _zz_169;
    _zz_170[2] = _zz_169;
    _zz_170[1] = _zz_169;
    _zz_170[0] = _zz_169;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_24 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_92 = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_93 = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && (memory_BRANCH_CALC[1 : 0] != (2'b00))));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = memory_BRANCH_CALC;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  assign decode_exception_agregat_valid = (_zz_88 || decodeExceptionPort_valid);
  assign _zz_171 = {decodeExceptionPort_valid,_zz_88};
  assign _zz_172 = _zz_288[1];
  assign _zz_173 = _zz_172;
  assign decode_exception_agregat_payload_code = _zz_214;
  assign decode_exception_agregat_payload_badAddr = _zz_215;
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
    CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusCachedPlugin_injector_nextPcCalc_valids_4);
    if(((CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptCode = ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_291);
  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  assign contextSwitching = _zz_94;
  assign _zz_22 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_21 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_182;
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
        execute_CsrPlugin_readData[31 : 0] = _zz_184;
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
    if((_zz_96 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_293 : execute_SRC1);
  always @ (*) begin
    case(_zz_248)
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
  always @ (*) begin
    memory_MulDivIterativePlugin_mul_counter_willClear = 1'b0;
    memory_MulDivIterativePlugin_div_counter_willClear = 1'b0;
    if(_zz_240)begin
      memory_MulDivIterativePlugin_mul_counter_willClear = 1'b1;
      memory_MulDivIterativePlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_MulDivIterativePlugin_mul_done = (memory_MulDivIterativePlugin_mul_counter_value == (6'b100000));
  assign memory_MulDivIterativePlugin_mul_counter_willOverflow = (memory_MulDivIterativePlugin_mul_done && memory_MulDivIterativePlugin_mul_counter_willIncrement);
  always @ (*) begin
    if(memory_MulDivIterativePlugin_mul_counter_willOverflow)begin
      memory_MulDivIterativePlugin_mul_counter_valueNext = (6'b000000);
    end else begin
      memory_MulDivIterativePlugin_mul_counter_valueNext = (memory_MulDivIterativePlugin_mul_counter_value + _zz_295);
    end
    if(memory_MulDivIterativePlugin_mul_counter_willClear)begin
      memory_MulDivIterativePlugin_mul_counter_valueNext = (6'b000000);
    end
  end

  assign memory_MulDivIterativePlugin_div_done = (memory_MulDivIterativePlugin_div_counter_value == (6'b100001));
  assign memory_MulDivIterativePlugin_div_counter_willOverflow = (memory_MulDivIterativePlugin_div_done && memory_MulDivIterativePlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_MulDivIterativePlugin_div_counter_willOverflow)begin
      memory_MulDivIterativePlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_MulDivIterativePlugin_div_counter_valueNext = (memory_MulDivIterativePlugin_div_counter_value + _zz_303);
    end
    if(memory_MulDivIterativePlugin_div_counter_willClear)begin
      memory_MulDivIterativePlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_175 = memory_MulDivIterativePlugin_rs1[31 : 0];
  assign _zz_176 = {memory_MulDivIterativePlugin_accumulator[31 : 0],_zz_175[31]};
  assign _zz_177 = (_zz_176 - _zz_304);
  assign _zz_178 = (memory_INSTRUCTION[13] ? memory_MulDivIterativePlugin_accumulator[31 : 0] : memory_MulDivIterativePlugin_rs1[31 : 0]);
  assign _zz_179 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_180 = ((execute_IS_MUL && _zz_179) || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_181[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_181[31 : 0] = execute_RS1;
  end

  assign _zz_184 = (_zz_182 & _zz_183);
  assign externalInterrupt = (_zz_184 != (32'b00000000000000000000000000000000));
  assign _zz_20 = decode_SRC1_CTRL;
  assign _zz_18 = _zz_47;
  assign _zz_37 = decode_to_execute_SRC1_CTRL;
  assign _zz_17 = decode_ALU_BITWISE_CTRL;
  assign _zz_15 = _zz_60;
  assign _zz_41 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_14 = decode_SRC2_CTRL;
  assign _zz_12 = _zz_55;
  assign _zz_35 = decode_to_execute_SRC2_CTRL;
  assign _zz_11 = decode_BRANCH_CTRL;
  assign _zz_75 = _zz_59;
  assign _zz_26 = decode_to_execute_BRANCH_CTRL;
  assign _zz_9 = decode_SHIFT_CTRL;
  assign _zz_7 = _zz_51;
  assign _zz_30 = decode_to_execute_SHIFT_CTRL;
  assign _zz_6 = decode_ENV_CTRL;
  assign _zz_4 = _zz_54;
  assign _zz_23 = decode_to_execute_ENV_CTRL;
  assign _zz_3 = decode_ALU_CTRL;
  assign _zz_1 = _zz_64;
  assign _zz_39 = decode_to_execute_ALU_CTRL;
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
  assign iBusWishbone_ADR = {_zz_323,_zz_185};
  assign iBusWishbone_CTI = ((_zz_185 == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    _zz_211 = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_238)begin
      _zz_211 = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_186;
  assign iBus_rsp_payload_data = _zz_187;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_188 = _zz_192;
  assign _zz_190 = _zz_194;
  assign _zz_191 = _zz_195;
  assign dBus_cmd_ready = _zz_193;
  assign dBusWishbone_ADR = (_zz_191 >>> 2);
  assign dBusWishbone_CTI = (3'b000);
  assign dBusWishbone_BTE = (2'b00);
  always @ (*) begin
    case(_zz_197)
      2'b00 : begin
        _zz_198 = (4'b0001);
      end
      2'b01 : begin
        _zz_198 = (4'b0011);
      end
      default : begin
        _zz_198 = (4'b1111);
      end
    endcase
  end

  always @ (*) begin
    dBusWishbone_SEL = _zz_324[3:0];
    if((! _zz_190))begin
      dBusWishbone_SEL = (4'b1111);
    end
  end

  assign _zz_212 = _zz_190;
  assign dBusWishbone_DAT_MOSI = _zz_196;
  assign _zz_189 = (_zz_188 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_188;
  assign dBusWishbone_STB = _zz_188;
  assign dBus_rsp_ready = ((_zz_188 && (! _zz_212)) && dBusWishbone_ACK);
  assign dBus_rsp_data = dBusWishbone_DAT_MISO;
  assign dBus_rsp_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_96 <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_103 <= 1'b0;
      _zz_105 <= 1'b0;
      _zz_110 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      _zz_143 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_154 <= 1'b0;
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
      memory_MulDivIterativePlugin_mul_counter_value <= (6'b000000);
      memory_MulDivIterativePlugin_div_counter_value <= (6'b000000);
      _zz_182 <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_185 <= (3'b000);
      _zz_186 <= 1'b0;
      _zz_192 <= 1'b0;
      _zz_193 <= 1'b1;
    end else begin
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_235)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_103 <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        _zz_105 <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_input_ready)begin
        _zz_105 <= IBusCachedPlugin_iBusRsp_input_valid;
      end
      if(_zz_108)begin
        _zz_110 <= (IBusCachedPlugin_iBusRsp_inputPipeline_0_valid && _zz_107);
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        _zz_110 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_cacheRspArbitration_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_82))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      _zz_143 <= 1'b0;
      if(_zz_241)begin
        if(_zz_237)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_154 <= (_zz_43 && writeBack_arbitration_isFiring);
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
      if(_zz_239)begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_96;
      end
      if(_zz_236)begin
        if(! _zz_245) begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_96 <= CsrPlugin_mstatus_MPP;
        end
      end
      memory_MulDivIterativePlugin_mul_counter_value <= memory_MulDivIterativePlugin_mul_counter_valueNext;
      memory_MulDivIterativePlugin_div_counter_value <= memory_MulDivIterativePlugin_div_counter_valueNext;
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_28;
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
            _zz_182 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_317[0];
            CsrPlugin_mstatus_MIE <= _zz_318[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_319[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_320[0];
            CsrPlugin_mie_MTIE <= _zz_321[0];
            CsrPlugin_mie_MSIE <= _zz_322[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_238)begin
        if(iBusWishbone_ACK)begin
          _zz_185 <= (_zz_185 + (3'b001));
        end
      end
      _zz_186 <= (_zz_211 && iBusWishbone_ACK);
      if(_zz_243)begin
        _zz_192 <= dBus_cmd_valid;
        _zz_193 <= (! dBus_cmd_valid);
      end else begin
        _zz_192 <= (! _zz_189);
        _zz_193 <= _zz_189;
      end
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_input_ready)begin
      _zz_106 <= IBusCachedPlugin_iBusRsp_input_payload;
    end
    if(_zz_108)begin
      _zz_111 <= IBusCachedPlugin_iBusRsp_inputPipeline_0_payload;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow writeback stage stall when read happend");
    end
    if(_zz_241)begin
      if(_zz_237)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    _zz_155 <= _zz_42[11 : 7];
    _zz_156 <= _zz_69;
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
    if(_zz_239)begin
      CsrPlugin_mepc <= writeBack_PC;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interruptJump;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_interruptCode;
    end
    _zz_174 <= CsrPlugin_exception;
    if(_zz_174)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    if(_zz_234)begin
      if(_zz_242)begin
        memory_MulDivIterativePlugin_rs2 <= (memory_MulDivIterativePlugin_rs2 >>> 1);
        memory_MulDivIterativePlugin_accumulator <= ({_zz_296,memory_MulDivIterativePlugin_accumulator[31 : 0]} >>> 1);
      end
    end
    if(_zz_244)begin
      if(_zz_246)begin
        memory_MulDivIterativePlugin_rs1[31 : 0] <= _zz_305[31:0];
        memory_MulDivIterativePlugin_accumulator[31 : 0] <= ((! _zz_177[32]) ? _zz_306 : _zz_307);
        if((memory_MulDivIterativePlugin_div_counter_value == (6'b100000)))begin
          memory_MulDivIterativePlugin_div_result <= _zz_308[31:0];
        end
      end
    end
    if(_zz_240)begin
      memory_MulDivIterativePlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_MulDivIterativePlugin_rs1 <= ((_zz_180 ? (~ _zz_181) : _zz_181) + _zz_314);
      memory_MulDivIterativePlugin_rs2 <= ((_zz_179 ? (~ execute_RS2) : execute_RS2) + _zz_316);
      memory_MulDivIterativePlugin_div_needRevert <= (_zz_180 ^ (_zz_179 && (! execute_INSTRUCTION[13])));
    end
    _zz_183 <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_19;
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
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_16;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
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
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_13;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FLUSH_ALL <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FLUSH_ALL <= execute_FLUSH_ALL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_10;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_8;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_5;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_34;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_77;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_76;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_29;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
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
    _zz_187 <= iBusWishbone_DAT_MISO;
    if(_zz_243)begin
      _zz_194 <= dBus_cmd_payload_wr;
      _zz_195 <= dBus_cmd_payload_address;
      _zz_196 <= dBus_cmd_payload_data;
      _zz_197 <= dBus_cmd_payload_size;
    end
  end

endmodule

