// Generator : SpinalHDL v1.1.6    git head : 2643ea2afba86dc6321cd50da8126412cf13d7ec
// Date      : 06/09/2018, 01:55:38
// Component : VexRiscv


`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define EnvCtrlEnum_binary_sequancial_type [1:0]
`define EnvCtrlEnum_binary_sequancial_NONE 2'b00
`define EnvCtrlEnum_binary_sequancial_EBREAK 2'b01
`define EnvCtrlEnum_binary_sequancial_MRET 2'b10

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

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

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

module VexRiscv (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input  [31:0] externalInterruptArray,
      input   debug_bus_cmd_valid,
      output  debug_bus_cmd_ready,
      input   debug_bus_cmd_payload_wr,
      input  [7:0] debug_bus_cmd_payload_address,
      input  [31:0] debug_bus_cmd_payload_data,
      output reg [31:0] debug_bus_rsp_data,
      output  debug_resetOut,
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
      input   reset,
      input   debugReset);
  reg  _zz_213;
  wire  _zz_214;
  wire  _zz_215;
  wire  _zz_216;
  wire  _zz_217;
  wire  _zz_218;
  wire  _zz_219;
  wire  _zz_220;
  wire  _zz_221;
  wire  _zz_222;
  reg [31:0] _zz_223;
  reg [31:0] _zz_224;
  reg  _zz_225;
  reg  _zz_226;
  wire  _zz_227;
  reg [31:0] _zz_228;
  reg [3:0] _zz_229;
  reg [31:0] _zz_230;
  wire  _zz_231;
  wire  _zz_232;
  wire  _zz_233;
  wire [31:0] _zz_234;
  wire [31:0] _zz_235;
  wire  _zz_236;
  wire [31:0] _zz_237;
  wire  _zz_238;
  wire  _zz_239;
  wire  _zz_240;
  wire  _zz_241;
  wire  _zz_242;
  wire [31:0] _zz_243;
  wire  _zz_244;
  wire [31:0] _zz_245;
  wire  _zz_246;
  wire [31:0] _zz_247;
  wire [2:0] _zz_248;
  wire  _zz_249;
  wire  _zz_250;
  wire  _zz_251;
  wire  _zz_252;
  wire  _zz_253;
  wire  _zz_254;
  wire  _zz_255;
  wire [0:0] _zz_256;
  wire  _zz_257;
  wire  _zz_258;
  wire  _zz_259;
  wire  _zz_260;
  wire  _zz_261;
  wire  _zz_262;
  wire  _zz_263;
  wire [1:0] _zz_264;
  wire  _zz_265;
  wire [3:0] _zz_266;
  wire [2:0] _zz_267;
  wire [31:0] _zz_268;
  wire [11:0] _zz_269;
  wire [31:0] _zz_270;
  wire [19:0] _zz_271;
  wire [11:0] _zz_272;
  wire [0:0] _zz_273;
  wire [0:0] _zz_274;
  wire [0:0] _zz_275;
  wire [0:0] _zz_276;
  wire [0:0] _zz_277;
  wire [0:0] _zz_278;
  wire [0:0] _zz_279;
  wire [0:0] _zz_280;
  wire [0:0] _zz_281;
  wire [0:0] _zz_282;
  wire [0:0] _zz_283;
  wire [0:0] _zz_284;
  wire [0:0] _zz_285;
  wire [0:0] _zz_286;
  wire [0:0] _zz_287;
  wire [0:0] _zz_288;
  wire [2:0] _zz_289;
  wire [11:0] _zz_290;
  wire [11:0] _zz_291;
  wire [31:0] _zz_292;
  wire [31:0] _zz_293;
  wire [31:0] _zz_294;
  wire [31:0] _zz_295;
  wire [1:0] _zz_296;
  wire [31:0] _zz_297;
  wire [1:0] _zz_298;
  wire [1:0] _zz_299;
  wire [31:0] _zz_300;
  wire [32:0] _zz_301;
  wire [11:0] _zz_302;
  wire [11:0] _zz_303;
  wire [2:0] _zz_304;
  wire [31:0] _zz_305;
  wire [1:0] _zz_306;
  wire [1:0] _zz_307;
  wire [2:0] _zz_308;
  wire [3:0] _zz_309;
  wire [4:0] _zz_310;
  wire [31:0] _zz_311;
  wire [0:0] _zz_312;
  wire [5:0] _zz_313;
  wire [33:0] _zz_314;
  wire [32:0] _zz_315;
  wire [33:0] _zz_316;
  wire [32:0] _zz_317;
  wire [33:0] _zz_318;
  wire [32:0] _zz_319;
  wire [0:0] _zz_320;
  wire [5:0] _zz_321;
  wire [32:0] _zz_322;
  wire [32:0] _zz_323;
  wire [31:0] _zz_324;
  wire [31:0] _zz_325;
  wire [32:0] _zz_326;
  wire [32:0] _zz_327;
  wire [32:0] _zz_328;
  wire [0:0] _zz_329;
  wire [32:0] _zz_330;
  wire [0:0] _zz_331;
  wire [32:0] _zz_332;
  wire [0:0] _zz_333;
  wire [31:0] _zz_334;
  wire [0:0] _zz_335;
  wire [0:0] _zz_336;
  wire [0:0] _zz_337;
  wire [0:0] _zz_338;
  wire [0:0] _zz_339;
  wire [0:0] _zz_340;
  wire [26:0] _zz_341;
  wire [6:0] _zz_342;
  wire [1:0] _zz_343;
  wire [0:0] _zz_344;
  wire [7:0] _zz_345;
  wire  _zz_346;
  wire [0:0] _zz_347;
  wire [0:0] _zz_348;
  wire [31:0] _zz_349;
  wire [31:0] _zz_350;
  wire [0:0] _zz_351;
  wire [0:0] _zz_352;
  wire [31:0] _zz_353;
  wire [31:0] _zz_354;
  wire  _zz_355;
  wire [0:0] _zz_356;
  wire [0:0] _zz_357;
  wire  _zz_358;
  wire [0:0] _zz_359;
  wire [22:0] _zz_360;
  wire [31:0] _zz_361;
  wire [31:0] _zz_362;
  wire [31:0] _zz_363;
  wire  _zz_364;
  wire [0:0] _zz_365;
  wire [0:0] _zz_366;
  wire [0:0] _zz_367;
  wire [0:0] _zz_368;
  wire  _zz_369;
  wire [0:0] _zz_370;
  wire [19:0] _zz_371;
  wire [31:0] _zz_372;
  wire [31:0] _zz_373;
  wire  _zz_374;
  wire [1:0] _zz_375;
  wire [1:0] _zz_376;
  wire  _zz_377;
  wire [0:0] _zz_378;
  wire [15:0] _zz_379;
  wire [31:0] _zz_380;
  wire [31:0] _zz_381;
  wire [31:0] _zz_382;
  wire [0:0] _zz_383;
  wire [0:0] _zz_384;
  wire [0:0] _zz_385;
  wire [0:0] _zz_386;
  wire [2:0] _zz_387;
  wire [2:0] _zz_388;
  wire  _zz_389;
  wire [0:0] _zz_390;
  wire [11:0] _zz_391;
  wire [31:0] _zz_392;
  wire [31:0] _zz_393;
  wire [31:0] _zz_394;
  wire [31:0] _zz_395;
  wire [31:0] _zz_396;
  wire  _zz_397;
  wire  _zz_398;
  wire [31:0] _zz_399;
  wire [31:0] _zz_400;
  wire [0:0] _zz_401;
  wire [0:0] _zz_402;
  wire [3:0] _zz_403;
  wire [3:0] _zz_404;
  wire  _zz_405;
  wire [0:0] _zz_406;
  wire [8:0] _zz_407;
  wire [31:0] _zz_408;
  wire [31:0] _zz_409;
  wire [31:0] _zz_410;
  wire [31:0] _zz_411;
  wire  _zz_412;
  wire [0:0] _zz_413;
  wire [0:0] _zz_414;
  wire [31:0] _zz_415;
  wire [31:0] _zz_416;
  wire [0:0] _zz_417;
  wire [0:0] _zz_418;
  wire [0:0] _zz_419;
  wire [0:0] _zz_420;
  wire  _zz_421;
  wire [0:0] _zz_422;
  wire [5:0] _zz_423;
  wire [31:0] _zz_424;
  wire [31:0] _zz_425;
  wire [31:0] _zz_426;
  wire [0:0] _zz_427;
  wire [3:0] _zz_428;
  wire  _zz_429;
  wire [1:0] _zz_430;
  wire [1:0] _zz_431;
  wire  _zz_432;
  wire [0:0] _zz_433;
  wire [2:0] _zz_434;
  wire [31:0] _zz_435;
  wire [31:0] _zz_436;
  wire [31:0] _zz_437;
  wire  _zz_438;
  wire [0:0] _zz_439;
  wire [0:0] _zz_440;
  wire [31:0] _zz_441;
  wire [31:0] _zz_442;
  wire [31:0] _zz_443;
  wire [31:0] _zz_444;
  wire [0:0] _zz_445;
  wire [0:0] _zz_446;
  wire [0:0] _zz_447;
  wire [0:0] _zz_448;
  wire [2:0] _zz_449;
  wire [2:0] _zz_450;
  wire  _zz_451;
  wire  _zz_452;
  wire [31:0] _zz_453;
  wire [31:0] _zz_454;
  wire [31:0] _zz_455;
  wire [31:0] _zz_456;
  wire  _zz_457;
  wire [0:0] _zz_458;
  wire [0:0] _zz_459;
  wire [0:0] _zz_460;
  wire [0:0] _zz_461;
  wire [31:0] _zz_462;
  wire [31:0] _zz_463;
  wire [31:0] _zz_464;
  wire  _zz_465;
  wire [0:0] _zz_466;
  wire [12:0] _zz_467;
  wire [31:0] _zz_468;
  wire [31:0] _zz_469;
  wire [31:0] _zz_470;
  wire  _zz_471;
  wire [0:0] _zz_472;
  wire [6:0] _zz_473;
  wire [31:0] _zz_474;
  wire [31:0] _zz_475;
  wire [31:0] _zz_476;
  wire  _zz_477;
  wire [0:0] _zz_478;
  wire [0:0] _zz_479;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_1;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_2;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_3;
  wire  decode_IS_DIV;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire  decode_IS_RS1_SIGNED;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_4;
  wire `AluCtrlEnum_binary_sequancial_type _zz_5;
  wire `AluCtrlEnum_binary_sequancial_type _zz_6;
  wire  execute_BRANCH_DO;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_7;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_8;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_9;
  wire  decode_SRC_LESS_UNSIGNED;
  wire [31:0] execute_BRANCH_CALC;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_10;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_11;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_12;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_13;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_14;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_15;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  decode_IS_RS2_SIGNED;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_16;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_17;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_18;
  wire  decode_IS_EBREAK;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] memory_PC;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_19;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_20;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_CSR_READ_OPCODE;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_IS_MUL;
  wire  execute_IS_EBREAK;
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
  wire  _zz_47;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_48;
  wire  _zz_49;
  wire `AluCtrlEnum_binary_sequancial_type _zz_50;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_51;
  wire  _zz_52;
  wire  _zz_53;
  wire  _zz_54;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_55;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_56;
  wire  _zz_57;
  wire  _zz_58;
  wire  _zz_59;
  wire  _zz_60;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_61;
  wire  _zz_62;
  wire  _zz_63;
  wire  _zz_64;
  wire  _zz_65;
  wire  _zz_66;
  wire  _zz_67;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_68;
  wire  _zz_69;
  reg [31:0] _zz_70;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_71;
  wire [1:0] _zz_72;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  _zz_73;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_issueDetected;
  reg  _zz_74;
  wire [31:0] _zz_75;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_76;
  reg [31:0] _zz_77;
  reg [31:0] _zz_78;
  wire [31:0] _zz_79;
  wire  _zz_80;
  wire [31:0] _zz_81;
  wire [31:0] _zz_82;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  reg [31:0] decode_INSTRUCTION /* verilator public */ ;
  reg  decode_arbitration_haltItself /* verilator public */ ;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  reg  decode_arbitration_flushAll /* verilator public */ ;
  wire  decode_arbitration_redoIt;
  reg  decode_arbitration_isValid /* verilator public */ ;
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
  reg  _zz_83;
  reg  _zz_84;
  reg  _zz_85;
  wire  _zz_86;
  wire [31:0] _zz_87;
  wire  _zz_88;
  wire  _zz_89;
  wire [31:0] _zz_90;
  reg  _zz_91;
  wire [31:0] _zz_92;
  wire  _zz_93;
  wire  _zz_94;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  _zz_95;
  wire [31:0] _zz_96;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_97;
  reg [31:0] _zz_98;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_99;
  reg  _zz_100;
  reg  _zz_101;
  reg  _zz_102;
  reg  _zz_103;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_104;
  wire [3:0] _zz_105;
  wire  _zz_106;
  wire  _zz_107;
  wire  _zz_108;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_109;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_110;
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
  wire  _zz_111;
  reg  _zz_112;
  reg [31:0] _zz_113;
  wire  _zz_114;
  wire  _zz_115;
  wire  _zz_116;
  reg  _zz_117;
  reg [31:0] _zz_118;
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
  wire  _zz_119;
  reg [18:0] _zz_120;
  wire  _zz_121;
  reg [10:0] _zz_122;
  wire  _zz_123;
  reg [18:0] _zz_124;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  _zz_125;
  wire  IBusCachedPlugin_iBusRspOutputHalt;
  wire  _zz_126;
  reg  IBusCachedPlugin_redoFetch;
  wire  _zz_127;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [1:0] dBus_cmd_payload_size;
  wire  dBus_rsp_ready;
  wire  dBus_rsp_error;
  wire [31:0] dBus_rsp_data;
  reg [31:0] _zz_128;
  reg [3:0] _zz_129;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_130;
  reg [31:0] _zz_131;
  wire  _zz_132;
  reg [31:0] _zz_133;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [28:0] _zz_134;
  wire  _zz_135;
  wire  _zz_136;
  wire  _zz_137;
  wire  _zz_138;
  wire  _zz_139;
  wire  _zz_140;
  wire  _zz_141;
  wire  _zz_142;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_143;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_144;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_145;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_146;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_147;
  wire `AluCtrlEnum_binary_sequancial_type _zz_148;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_149;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_150;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_151;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_152;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_153;
  reg [31:0] _zz_154;
  wire  _zz_155;
  reg [19:0] _zz_156;
  wire  _zz_157;
  reg [19:0] _zz_158;
  reg [31:0] _zz_159;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_160;
  reg  _zz_161;
  reg  _zz_162;
  reg  _zz_163;
  reg [4:0] _zz_164;
  reg [31:0] _zz_165;
  wire  _zz_166;
  wire  _zz_167;
  wire  _zz_168;
  wire  _zz_169;
  wire  _zz_170;
  wire  _zz_171;
  wire  _zz_172;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_173;
  reg  _zz_174;
  reg  _zz_175;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_176;
  reg [19:0] _zz_177;
  wire  _zz_178;
  reg [18:0] _zz_179;
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
  reg [63:0] CsrPlugin_mcycle = 64'b1100101001001000110111001110011111101101110100111001101001010111;
  reg [63:0] CsrPlugin_minstret = 64'b1010101010011001001010010111011011100101100000100100001101011101;
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
  wire [1:0] _zz_180;
  wire  _zz_181;
  wire [0:0] _zz_182;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_writeBackWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  _zz_183;
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
  wire [31:0] _zz_184;
  wire [32:0] _zz_185;
  wire [32:0] _zz_186;
  wire [31:0] _zz_187;
  wire  _zz_188;
  wire  _zz_189;
  reg [32:0] _zz_190;
  reg [31:0] _zz_191;
  reg [31:0] _zz_192;
  wire [31:0] _zz_193;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipActive;
  reg  _zz_194;
  wire  DebugPlugin_isPipBusy;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_195;
  reg  _zz_196;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg [31:0] decode_to_execute_RS1;
  reg  decode_to_execute_IS_CSR;
  reg [31:0] decode_to_execute_RS2;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg `BranchCtrlEnum_binary_sequancial_type decode_to_execute_BRANCH_CTRL;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg  decode_to_execute_IS_EBREAK;
  reg `ShiftCtrlEnum_binary_sequancial_type decode_to_execute_SHIFT_CTRL;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg `Src2CtrlEnum_binary_sequancial_type decode_to_execute_SRC2_CTRL;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type decode_to_execute_ALU_BITWISE_CTRL;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg `Src1CtrlEnum_binary_sequancial_type decode_to_execute_SRC1_CTRL;
  reg  execute_to_memory_BRANCH_DO;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg `AluCtrlEnum_binary_sequancial_type decode_to_execute_ALU_CTRL;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg [31:0] memory_to_writeBack_MEMORY_READ_DATA;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg `EnvCtrlEnum_binary_sequancial_type decode_to_execute_ENV_CTRL;
  reg [2:0] _zz_197;
  reg [31:0] _zz_198;
  reg [2:0] _zz_199;
  reg  _zz_200;
  reg [31:0] _zz_201;
  wire  _zz_202;
  wire  _zz_203;
  wire  _zz_204;
  wire [31:0] _zz_205;
  reg  _zz_206;
  reg  _zz_207;
  reg  _zz_208;
  reg [31:0] _zz_209;
  reg [31:0] _zz_210;
  reg [1:0] _zz_211;
  reg [3:0] _zz_212;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign debug_bus_cmd_ready = _zz_225;
  assign iBusWishbone_CYC = _zz_226;
  assign dBusWishbone_WE = _zz_227;
  assign _zz_249 = (! memory_arbitration_isStuck);
  assign _zz_250 = (! memory_MulDivIterativePlugin_div_done);
  assign _zz_251 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_252 = (! memory_MulDivIterativePlugin_mul_done);
  assign _zz_253 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_254 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET));
  assign _zz_255 = (! execute_arbitration_isStuckByOthers);
  assign _zz_256 = debug_bus_cmd_payload_address[2 : 2];
  assign _zz_257 = (CsrPlugin_exception || CsrPlugin_interruptJump);
  assign _zz_258 = (memory_arbitration_isValid && memory_IS_MUL);
  assign _zz_259 = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_260 = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  assign _zz_261 = (iBus_cmd_valid || (_zz_199 != (3'b000)));
  assign _zz_262 = (! _zz_206);
  assign _zz_263 = (DebugPlugin_stepIt && _zz_85);
  assign _zz_264 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_265 = execute_INSTRUCTION[13];
  assign _zz_266 = (_zz_104 - (4'b0001));
  assign _zz_267 = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_268 = {29'd0, _zz_267};
  assign _zz_269 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_270 = {{_zz_120,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_271 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_272 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_273 = _zz_134[2 : 2];
  assign _zz_274 = _zz_134[3 : 3];
  assign _zz_275 = _zz_134[4 : 4];
  assign _zz_276 = _zz_134[5 : 5];
  assign _zz_277 = _zz_134[6 : 6];
  assign _zz_278 = _zz_134[7 : 7];
  assign _zz_279 = _zz_134[10 : 10];
  assign _zz_280 = _zz_134[11 : 11];
  assign _zz_281 = _zz_134[12 : 12];
  assign _zz_282 = _zz_134[13 : 13];
  assign _zz_283 = _zz_134[18 : 18];
  assign _zz_284 = _zz_134[19 : 19];
  assign _zz_285 = _zz_134[20 : 20];
  assign _zz_286 = _zz_134[25 : 25];
  assign _zz_287 = _zz_134[28 : 28];
  assign _zz_288 = execute_SRC_LESS;
  assign _zz_289 = (3'b100);
  assign _zz_290 = execute_INSTRUCTION[31 : 20];
  assign _zz_291 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_292 = ($signed(_zz_293) + $signed(_zz_297));
  assign _zz_293 = ($signed(_zz_294) + $signed(_zz_295));
  assign _zz_294 = execute_SRC1;
  assign _zz_295 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_296 = (execute_SRC_USE_SUB_LESS ? _zz_298 : _zz_299);
  assign _zz_297 = {{30{_zz_296[1]}}, _zz_296};
  assign _zz_298 = (2'b01);
  assign _zz_299 = (2'b00);
  assign _zz_300 = (_zz_301 >>> 1);
  assign _zz_301 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_302 = execute_INSTRUCTION[31 : 20];
  assign _zz_303 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_304 = (3'b100);
  assign _zz_305 = {29'd0, _zz_304};
  assign _zz_306 = (_zz_180 & (~ _zz_307));
  assign _zz_307 = (_zz_180 - (2'b01));
  assign _zz_308 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_309 = {1'd0, _zz_308};
  assign _zz_310 = execute_INSTRUCTION[19 : 15];
  assign _zz_311 = {27'd0, _zz_310};
  assign _zz_312 = memory_MulDivIterativePlugin_mul_counter_willIncrement;
  assign _zz_313 = {5'd0, _zz_312};
  assign _zz_314 = (_zz_316 + _zz_318);
  assign _zz_315 = (memory_MulDivIterativePlugin_rs2[0] ? memory_MulDivIterativePlugin_rs1 : (33'b000000000000000000000000000000000));
  assign _zz_316 = {{1{_zz_315[32]}}, _zz_315};
  assign _zz_317 = _zz_319;
  assign _zz_318 = {{1{_zz_317[32]}}, _zz_317};
  assign _zz_319 = (memory_MulDivIterativePlugin_accumulator >>> 32);
  assign _zz_320 = memory_MulDivIterativePlugin_div_counter_willIncrement;
  assign _zz_321 = {5'd0, _zz_320};
  assign _zz_322 = {1'd0, memory_MulDivIterativePlugin_rs2};
  assign _zz_323 = {_zz_184,(! _zz_186[32])};
  assign _zz_324 = _zz_186[31:0];
  assign _zz_325 = _zz_185[31:0];
  assign _zz_326 = _zz_327;
  assign _zz_327 = _zz_328;
  assign _zz_328 = ({1'b0,(memory_MulDivIterativePlugin_div_needRevert ? (~ _zz_187) : _zz_187)} + _zz_330);
  assign _zz_329 = memory_MulDivIterativePlugin_div_needRevert;
  assign _zz_330 = {32'd0, _zz_329};
  assign _zz_331 = _zz_189;
  assign _zz_332 = {32'd0, _zz_331};
  assign _zz_333 = _zz_188;
  assign _zz_334 = {31'd0, _zz_333};
  assign _zz_335 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_336 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_337 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_338 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_339 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_340 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_341 = (iBus_cmd_payload_address >>> 5);
  assign _zz_342 = ({3'd0,_zz_212} <<< _zz_205[1 : 0]);
  assign _zz_343 = {_zz_108,_zz_107};
  assign _zz_344 = decode_INSTRUCTION[31];
  assign _zz_345 = decode_INSTRUCTION[19 : 12];
  assign _zz_346 = decode_INSTRUCTION[20];
  assign _zz_347 = decode_INSTRUCTION[31];
  assign _zz_348 = decode_INSTRUCTION[7];
  assign _zz_349 = (decode_INSTRUCTION & (32'b00000000000000000000000001000000));
  assign _zz_350 = (32'b00000000000000000000000001000000);
  assign _zz_351 = ((decode_INSTRUCTION & _zz_361) == (32'b00000000000000000000000000010000));
  assign _zz_352 = ((decode_INSTRUCTION & _zz_362) == (32'b00000000000000000000000000100000));
  assign _zz_353 = (decode_INSTRUCTION & (32'b00000000000000000000000000010100));
  assign _zz_354 = (32'b00000000000000000000000000000100);
  assign _zz_355 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000100));
  assign _zz_356 = ((decode_INSTRUCTION & _zz_363) == (32'b00000010000000000100000000100000));
  assign _zz_357 = (1'b0);
  assign _zz_358 = ({_zz_364,{_zz_365,_zz_366}} != (3'b000));
  assign _zz_359 = (_zz_142 != (1'b0));
  assign _zz_360 = {(_zz_367 != _zz_368),{_zz_369,{_zz_370,_zz_371}}};
  assign _zz_361 = (32'b00000000000000000000000000110000);
  assign _zz_362 = (32'b00000010000000000000000000100000);
  assign _zz_363 = (32'b00000010000000000100000001100100);
  assign _zz_364 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000100000000000000));
  assign _zz_365 = ((decode_INSTRUCTION & (32'b00000000000000000000000001100100)) == (32'b00000000000000000000000000100100));
  assign _zz_366 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_367 = ((decode_INSTRUCTION & (32'b00000000000100000011000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_368 = (1'b0);
  assign _zz_369 = 1'b0;
  assign _zz_370 = ((_zz_372 == _zz_373) != (1'b0));
  assign _zz_371 = {(_zz_374 != (1'b0)),{(_zz_375 != _zz_376),{_zz_377,{_zz_378,_zz_379}}}};
  assign _zz_372 = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_373 = (32'b00000000000000000000000000000000);
  assign _zz_374 = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign _zz_375 = {((decode_INSTRUCTION & _zz_380) == (32'b00000000000000000000000000100000)),_zz_137};
  assign _zz_376 = (2'b00);
  assign _zz_377 = ({(_zz_381 == _zz_382),_zz_136} != (2'b00));
  assign _zz_378 = ({_zz_136,{_zz_383,_zz_384}} != (3'b000));
  assign _zz_379 = {({_zz_385,_zz_386} != (2'b00)),{(_zz_387 != _zz_388),{_zz_389,{_zz_390,_zz_391}}}};
  assign _zz_380 = (32'b00000000000000000000000001100100);
  assign _zz_381 = (decode_INSTRUCTION & (32'b00000000000000000001000000000000));
  assign _zz_382 = (32'b00000000000000000001000000000000);
  assign _zz_383 = ((decode_INSTRUCTION & _zz_392) == (32'b00000000000000000001000000000000));
  assign _zz_384 = _zz_140;
  assign _zz_385 = ((decode_INSTRUCTION & _zz_393) == (32'b00000000000000000101000000010000));
  assign _zz_386 = ((decode_INSTRUCTION & _zz_394) == (32'b00000000000000000101000000100000));
  assign _zz_387 = {(_zz_395 == _zz_396),{_zz_397,_zz_398}};
  assign _zz_388 = (3'b000);
  assign _zz_389 = ((_zz_399 == _zz_400) != (1'b0));
  assign _zz_390 = ({_zz_401,_zz_402} != (2'b00));
  assign _zz_391 = {(_zz_403 != _zz_404),{_zz_405,{_zz_406,_zz_407}}};
  assign _zz_392 = (32'b00000000000000000011000000000000);
  assign _zz_393 = (32'b00000000000000000111000000110100);
  assign _zz_394 = (32'b00000010000000000111000001100100);
  assign _zz_395 = (decode_INSTRUCTION & (32'b01000000000000000011000001010100));
  assign _zz_396 = (32'b01000000000000000001000000010000);
  assign _zz_397 = ((decode_INSTRUCTION & (32'b00000000000000000111000000110100)) == (32'b00000000000000000001000000010000));
  assign _zz_398 = ((decode_INSTRUCTION & (32'b00000010000000000111000001010100)) == (32'b00000000000000000001000000010000));
  assign _zz_399 = (decode_INSTRUCTION & (32'b00000010000000000100000001110100));
  assign _zz_400 = (32'b00000010000000000000000000110000);
  assign _zz_401 = ((decode_INSTRUCTION & _zz_408) == (32'b00000000000000000010000000000000));
  assign _zz_402 = ((decode_INSTRUCTION & _zz_409) == (32'b00000000000000000001000000000000));
  assign _zz_403 = {(_zz_410 == _zz_411),{_zz_412,{_zz_413,_zz_414}}};
  assign _zz_404 = (4'b0000);
  assign _zz_405 = ((_zz_415 == _zz_416) != (1'b0));
  assign _zz_406 = ({_zz_417,_zz_418} != (2'b00));
  assign _zz_407 = {(_zz_419 != _zz_420),{_zz_421,{_zz_422,_zz_423}}};
  assign _zz_408 = (32'b00000000000000000010000000010000);
  assign _zz_409 = (32'b00000000000000000101000000000000);
  assign _zz_410 = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_411 = (32'b00000000000000000000000000000000);
  assign _zz_412 = ((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000));
  assign _zz_413 = _zz_142;
  assign _zz_414 = ((decode_INSTRUCTION & _zz_424) == (32'b00000000000000000001000000000000));
  assign _zz_415 = (decode_INSTRUCTION & (32'b00000000000000000000000001001000));
  assign _zz_416 = (32'b00000000000000000000000000001000);
  assign _zz_417 = _zz_141;
  assign _zz_418 = ((decode_INSTRUCTION & _zz_425) == (32'b00000000000000000000000000000100));
  assign _zz_419 = ((decode_INSTRUCTION & _zz_426) == (32'b00000000000000000000000001000000));
  assign _zz_420 = (1'b0);
  assign _zz_421 = ({_zz_141,{_zz_427,_zz_428}} != (6'b000000));
  assign _zz_422 = (_zz_429 != (1'b0));
  assign _zz_423 = {(_zz_430 != _zz_431),{_zz_432,{_zz_433,_zz_434}}};
  assign _zz_424 = (32'b00000000000000000101000000000100);
  assign _zz_425 = (32'b00000000000000000100000000010100);
  assign _zz_426 = (32'b00000000000000000000000001011000);
  assign _zz_427 = ((decode_INSTRUCTION & _zz_435) == (32'b00000000000000000001000000010000));
  assign _zz_428 = {(_zz_436 == _zz_437),{_zz_438,{_zz_439,_zz_440}}};
  assign _zz_429 = ((decode_INSTRUCTION & (32'b00100000000000000011000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_430 = {(_zz_441 == _zz_442),(_zz_443 == _zz_444)};
  assign _zz_431 = (2'b00);
  assign _zz_432 = ({_zz_139,{_zz_445,_zz_446}} != (3'b000));
  assign _zz_433 = ({_zz_447,_zz_448} != (2'b00));
  assign _zz_434 = {(_zz_449 != _zz_450),{_zz_451,_zz_452}};
  assign _zz_435 = (32'b00000000000000000001000000010000);
  assign _zz_436 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_437 = (32'b00000000000000000010000000010000);
  assign _zz_438 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000010000));
  assign _zz_439 = ((decode_INSTRUCTION & _zz_453) == (32'b00000000000000000000000000000100));
  assign _zz_440 = ((decode_INSTRUCTION & _zz_454) == (32'b00000000000000000000000000000000));
  assign _zz_441 = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_442 = (32'b00000000000000000001000001010000);
  assign _zz_443 = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_444 = (32'b00000000000000000010000001010000);
  assign _zz_445 = _zz_140;
  assign _zz_446 = _zz_138;
  assign _zz_447 = _zz_139;
  assign _zz_448 = _zz_138;
  assign _zz_449 = {(_zz_455 == _zz_456),{_zz_457,_zz_137}};
  assign _zz_450 = (3'b000);
  assign _zz_451 = ({_zz_136,{_zz_458,_zz_459}} != (3'b000));
  assign _zz_452 = ({_zz_136,{_zz_460,_zz_461}} != (3'b000));
  assign _zz_453 = (32'b00000000000000000100000000000100);
  assign _zz_454 = (32'b00000000000000000000000000101000);
  assign _zz_455 = (decode_INSTRUCTION & (32'b01000000000000000000000000110000));
  assign _zz_456 = (32'b01000000000000000000000000110000);
  assign _zz_457 = ((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000));
  assign _zz_458 = _zz_135;
  assign _zz_459 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_460 = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign _zz_461 = _zz_135;
  assign _zz_462 = (32'b00000000000000000010000001111111);
  assign _zz_463 = (decode_INSTRUCTION & (32'b00000000001000000000000001111111));
  assign _zz_464 = (32'b00000000000000000000000001101111);
  assign _zz_465 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_466 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011));
  assign _zz_467 = {((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_468) == (32'b00000000000000000100000001100011)),{(_zz_469 == _zz_470),{_zz_471,{_zz_472,_zz_473}}}}}};
  assign _zz_468 = (32'b00000000000000000100000101111111);
  assign _zz_469 = (decode_INSTRUCTION & (32'b00000000000000000010000101111111));
  assign _zz_470 = (32'b00000000000000000000000001100011);
  assign _zz_471 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000100000000001111));
  assign _zz_472 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000000000001100111));
  assign _zz_473 = {((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b11111100000000000011000001011111)) == (32'b00000000000000000001000000010011)),{((decode_INSTRUCTION & _zz_474) == (32'b00000000000000000101000000010011)),{(_zz_475 == _zz_476),{_zz_477,{_zz_478,_zz_479}}}}}};
  assign _zz_474 = (32'b10111100000000000111000001111111);
  assign _zz_475 = (decode_INSTRUCTION & (32'b10111110000000000111000001111111));
  assign _zz_476 = (32'b00000000000000000101000000110011);
  assign _zz_477 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_478 = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00110000001000000000000001110011));
  assign _zz_479 = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00000000000100000000000001110011));
  always @ (posedge clk) begin
    if(_zz_44) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_150) begin
      _zz_223 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_151) begin
      _zz_224 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_213),
    .io_flush_cmd_ready(_zz_231),
    .io_flush_rsp(_zz_232),
    .io_cpu_prefetch_isValid(IBusCachedPlugin_fetchPc_output_valid),
    .io_cpu_prefetch_haltIt(_zz_233),
    .io_cpu_prefetch_pc(IBusCachedPlugin_fetchPc_output_payload),
    .io_cpu_fetch_isValid(IBusCachedPlugin_iBusRsp_inputPipeline_0_valid),
    .io_cpu_fetch_isStuck(_zz_214),
    .io_cpu_fetch_isRemoved(_zz_215),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_inputPipeline_0_payload),
    .io_cpu_fetch_data(_zz_234),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_236),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_237),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_238),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_92),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_216),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_217),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_218),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_219),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_220),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_93),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_94),
    .io_cpu_fetch_mmuBus_end(_zz_239),
    .io_cpu_fetch_physicalAddress(_zz_235),
    .io_cpu_decode_isValid(IBusCachedPlugin_cacheRspArbitration_valid),
    .io_cpu_decode_isStuck(_zz_221),
    .io_cpu_decode_pc(IBusCachedPlugin_cacheRspArbitration_payload),
    .io_cpu_decode_physicalAddress(_zz_245),
    .io_cpu_decode_data(_zz_243),
    .io_cpu_decode_cacheMiss(_zz_244),
    .io_cpu_decode_error(_zz_240),
    .io_cpu_decode_mmuMiss(_zz_241),
    .io_cpu_decode_illegalAccess(_zz_242),
    .io_cpu_decode_isUser(_zz_222),
    .io_cpu_fill_valid(IBusCachedPlugin_redoFetch),
    .io_cpu_fill_payload(_zz_245),
    .io_mem_cmd_valid(_zz_246),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_247),
    .io_mem_cmd_payload_size(_zz_248),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_343)
      2'b00 : begin
        _zz_228 = _zz_98;
      end
      2'b01 : begin
        _zz_228 = _zz_96;
      end
      2'b10 : begin
        _zz_228 = _zz_90;
      end
      default : begin
        _zz_228 = _zz_87;
      end
    endcase
  end

  always @(*) begin
    case(_zz_182)
      1'b0 : begin
        _zz_229 = (_zz_241 ? (4'b1110) : (4'b0001));
        _zz_230 = IBusCachedPlugin_cacheRspArbitration_payload;
      end
      default : begin
        _zz_229 = decodeExceptionPort_payload_code;
        _zz_230 = decodeExceptionPort_payload_badAddr;
      end
    endcase
  end

  assign decode_ENV_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign decode_IS_DIV = _zz_49;
  assign memory_MEMORY_READ_DATA = _zz_71;
  assign decode_IS_RS1_SIGNED = _zz_65;
  assign decode_ALU_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign execute_BRANCH_DO = _zz_25;
  assign decode_SRC1_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign decode_SRC_LESS_UNSIGNED = _zz_58;
  assign execute_BRANCH_CALC = _zz_24;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_72;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_79;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_47;
  assign decode_ALU_BITWISE_CTRL = _zz_10;
  assign _zz_11 = _zz_12;
  assign decode_SRC2_CTRL = _zz_13;
  assign _zz_14 = _zz_15;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_40;
  assign decode_IS_RS2_SIGNED = _zz_66;
  assign decode_SHIFT_CTRL = _zz_16;
  assign _zz_17 = _zz_18;
  assign decode_IS_EBREAK = _zz_63;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_60;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_53;
  assign decode_MEMORY_ENABLE = _zz_52;
  assign memory_PC = execute_to_memory_PC;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_27;
  assign _zz_19 = _zz_20;
  assign decode_CSR_WRITE_OPCODE = _zz_22;
  assign decode_CSR_READ_OPCODE = _zz_21;
  assign decode_SRC_USE_SUB_LESS = _zz_67;
  assign decode_IS_MUL = _zz_57;
  assign execute_IS_EBREAK = decode_to_execute_IS_EBREAK;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign decode_IS_CSR = _zz_64;
  assign execute_ENV_CTRL = _zz_23;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_26;
  assign decode_RS2_USE = _zz_54;
  assign decode_RS1_USE = _zz_59;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  always @ (*) begin
    _zz_28 = memory_REGFILE_WRITE_DATA;
    _zz_29 = execute_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_haltItself = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    memory_arbitration_flushAll = 1'b0;
    _zz_83 = 1'b0;
    _zz_84 = 1'b0;
    _zz_97 = 1'b0;
    _zz_98 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    _zz_213 = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_213 = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_231))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(_zz_251)begin
      _zz_29 = _zz_160;
      if(_zz_255)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
    if(_zz_257)begin
      _zz_97 = 1'b1;
      _zz_98 = CsrPlugin_mtvec;
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_254)begin
      if(_zz_260)begin
        execute_arbitration_haltItself = 1'b1;
      end else begin
        _zz_97 = 1'b1;
        _zz_98 = CsrPlugin_mepc;
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
    if(_zz_258)begin
      if(_zz_252)begin
        memory_arbitration_haltItself = 1'b1;
        memory_MulDivIterativePlugin_mul_counter_willIncrement = 1'b1;
      end
      _zz_28 = ((memory_INSTRUCTION[13 : 12] == (2'b00)) ? memory_MulDivIterativePlugin_accumulator[31 : 0] : memory_MulDivIterativePlugin_accumulator[63 : 32]);
    end
    memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b0;
    if(_zz_253)begin
      if(_zz_250)begin
        memory_arbitration_haltItself = 1'b1;
        memory_MulDivIterativePlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_28 = memory_MulDivIterativePlugin_div_result;
    end
    if(execute_IS_EBREAK)begin
      if(execute_arbitration_isValid)begin
        _zz_84 = 1'b1;
        _zz_83 = 1'b1;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      _zz_83 = 1'b1;
    end
    if(_zz_263)begin
      _zz_83 = 1'b1;
    end
  end

  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_45;
    decode_RS1 = _zz_46;
    if(_zz_163)begin
      if((_zz_164 == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_165;
      end
      if((_zz_164 == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_165;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(_zz_166)begin
        if(_zz_167)begin
          decode_RS1 = _zz_70;
        end
        if(_zz_168)begin
          decode_RS2 = _zz_70;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_169)begin
          decode_RS1 = _zz_28;
        end
        if(_zz_170)begin
          decode_RS2 = _zz_28;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_171)begin
          decode_RS1 = _zz_29;
        end
        if(_zz_172)begin
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

  assign decode_INSTRUCTION_ANTICIPATED = _zz_75;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_62;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_69;
  assign decode_INSTRUCTION_READY = _zz_80;
  always @ (*) begin
    _zz_70 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_70 = writeBack_DBusSimplePlugin_rspFormated;
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
  assign execute_ALIGNEMENT_FAULT = _zz_73;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_issueDetected = _zz_74;
    _zz_91 = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && ((_zz_240 || _zz_241) || _zz_242)) && (! _zz_74)))begin
      IBusCachedPlugin_issueDetected = 1'b1;
      _zz_91 = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    _zz_74 = _zz_126;
    IBusCachedPlugin_redoFetch = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && _zz_244) && (! _zz_126)))begin
      _zz_74 = 1'b1;
      IBusCachedPlugin_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_76;
  always @ (*) begin
    _zz_77 = memory_FORMAL_PC_NEXT;
    if(_zz_95)begin
      _zz_77 = _zz_96;
    end
  end

  always @ (*) begin
    _zz_78 = decode_FORMAL_PC_NEXT;
    if(_zz_86)begin
      _zz_78 = _zz_87;
    end
    if(_zz_89)begin
      _zz_78 = _zz_90;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_82;
  always @ (*) begin
    decode_INSTRUCTION = _zz_81;
    if((_zz_197 != (3'b000)))begin
      decode_INSTRUCTION = _zz_198;
    end
  end

  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_output_valid && (! IBusCachedPlugin_injector_decodeRemoved));
    if((decode_arbitration_isValid && (_zz_161 || _zz_162)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(((decode_arbitration_isValid && decode_IS_CSR) && (execute_arbitration_isValid || memory_arbitration_isValid)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    _zz_103 = 1'b0;
    case(_zz_197)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
        decode_arbitration_haltItself = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b100 : begin
        _zz_103 = 1'b1;
      end
      default : begin
      end
    endcase
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
    if(_zz_95)begin
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
  always @ (*) begin
    _zz_85 = 1'b0;
    if((IBusCachedPlugin_iBusRsp_inputPipeline_0_valid || IBusCachedPlugin_cacheRspArbitration_valid))begin
      _zz_85 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_100 = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      _zz_100 = 1'b0;
    end
  end

  always @ (*) begin
    _zz_101 = 1'b1;
    if(DebugPlugin_haltIt)begin
      _zz_101 = 1'b0;
    end
  end

  assign IBusCachedPlugin_jump_pcLoad_valid = (((_zz_86 || _zz_89) || _zz_95) || _zz_97);
  assign _zz_104 = {_zz_86,{_zz_89,{_zz_95,_zz_97}}};
  assign _zz_105 = (_zz_104 & (~ _zz_266));
  assign _zz_106 = _zz_105[3];
  assign _zz_107 = (_zz_105[1] || _zz_106);
  assign _zz_108 = (_zz_105[2] || _zz_106);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_228;
  assign _zz_109 = (! _zz_83);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_109);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_109);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_268);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_259)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_110;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b0;
    if(((_zz_236 && (! _zz_94)) && (! _zz_93)))begin
      IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_input_ready = ((1'b0 && (! _zz_111)) || IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_111 = _zz_112;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_valid = _zz_111;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_payload = _zz_113;
  assign _zz_114 = (! IBusCachedPlugin_iBusRsp_inputPipelineHalt_0);
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_ready = (_zz_115 && _zz_114);
  assign _zz_115 = ((1'b0 && (! _zz_116)) || IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_116 = _zz_117;
  assign IBusCachedPlugin_cacheRspArbitration_valid = _zz_116;
  assign IBusCachedPlugin_cacheRspArbitration_payload = _zz_118;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck);
  assign _zz_82 = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign _zz_81 = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  assign _zz_80 = 1'b1;
  assign _zz_79 = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_119 = _zz_269[11];
  always @ (*) begin
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

  assign _zz_88 = ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_B) && _zz_270[31]));
  assign _zz_86 = (_zz_88 && decode_arbitration_isFiring);
  assign _zz_121 = _zz_271[19];
  always @ (*) begin
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

  assign _zz_123 = _zz_272[11];
  always @ (*) begin
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
    _zz_124[7] = _zz_123;
    _zz_124[6] = _zz_123;
    _zz_124[5] = _zz_123;
    _zz_124[4] = _zz_123;
    _zz_124[3] = _zz_123;
    _zz_124[2] = _zz_123;
    _zz_124[1] = _zz_123;
    _zz_124[0] = _zz_123;
  end

  assign _zz_87 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) ? {{_zz_122,{{{_zz_344,_zz_345},_zz_346},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_124,{{{_zz_347,_zz_348},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = _zz_246;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_247;
    iBus_cmd_payload_address = _zz_247;
  end

  assign iBus_cmd_payload_size = _zz_248;
  assign _zz_125 = (! _zz_233);
  assign IBusCachedPlugin_fetchPc_output_ready = (IBusCachedPlugin_iBusRsp_input_ready && _zz_125);
  assign IBusCachedPlugin_iBusRsp_input_valid = (IBusCachedPlugin_fetchPc_output_valid && _zz_125);
  assign IBusCachedPlugin_iBusRsp_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign _zz_215 = (IBusCachedPlugin_jump_pcLoad_valid || _zz_84);
  assign IBusCachedPlugin_iBusRspOutputHalt = 1'b0;
  assign _zz_216 = _zz_92[31];
  assign _zz_217 = 1'b1;
  assign _zz_218 = 1'b1;
  assign _zz_219 = 1'b1;
  assign _zz_220 = 1'b1;
  assign _zz_214 = (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_221 = (! IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_222 = (_zz_99 == (2'b00));
  assign _zz_75 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_234);
  assign _zz_126 = 1'b0;
  assign _zz_89 = IBusCachedPlugin_redoFetch;
  assign _zz_90 = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_127 = (! (IBusCachedPlugin_issueDetected || IBusCachedPlugin_iBusRspOutputHalt));
  assign IBusCachedPlugin_cacheRspArbitration_ready = (IBusCachedPlugin_iBusRsp_output_ready && _zz_127);
  assign IBusCachedPlugin_iBusRsp_output_valid = (IBusCachedPlugin_cacheRspArbitration_valid && _zz_127);
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = _zz_243;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_73 = 1'b0;
  assign dBus_cmd_valid = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_removeIt)) && (! execute_ALIGNEMENT_FAULT));
  assign dBus_cmd_payload_wr = execute_INSTRUCTION[5];
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_128 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_128 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_128 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_128;
  assign _zz_72 = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_129 = (4'b0001);
      end
      2'b01 : begin
        _zz_129 = (4'b0011);
      end
      default : begin
        _zz_129 = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_129 <<< dBus_cmd_payload_address[1 : 0]);
  assign _zz_71 = dBus_rsp_data;
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

  assign _zz_130 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_131[31] = _zz_130;
    _zz_131[30] = _zz_130;
    _zz_131[29] = _zz_130;
    _zz_131[28] = _zz_130;
    _zz_131[27] = _zz_130;
    _zz_131[26] = _zz_130;
    _zz_131[25] = _zz_130;
    _zz_131[24] = _zz_130;
    _zz_131[23] = _zz_130;
    _zz_131[22] = _zz_130;
    _zz_131[21] = _zz_130;
    _zz_131[20] = _zz_130;
    _zz_131[19] = _zz_130;
    _zz_131[18] = _zz_130;
    _zz_131[17] = _zz_130;
    _zz_131[16] = _zz_130;
    _zz_131[15] = _zz_130;
    _zz_131[14] = _zz_130;
    _zz_131[13] = _zz_130;
    _zz_131[12] = _zz_130;
    _zz_131[11] = _zz_130;
    _zz_131[10] = _zz_130;
    _zz_131[9] = _zz_130;
    _zz_131[8] = _zz_130;
    _zz_131[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_132 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_133[31] = _zz_132;
    _zz_133[30] = _zz_132;
    _zz_133[29] = _zz_132;
    _zz_133[28] = _zz_132;
    _zz_133[27] = _zz_132;
    _zz_133[26] = _zz_132;
    _zz_133[25] = _zz_132;
    _zz_133[24] = _zz_132;
    _zz_133[23] = _zz_132;
    _zz_133[22] = _zz_132;
    _zz_133[21] = _zz_132;
    _zz_133[20] = _zz_132;
    _zz_133[19] = _zz_132;
    _zz_133[18] = _zz_132;
    _zz_133[17] = _zz_132;
    _zz_133[16] = _zz_132;
    _zz_133[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_264)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_131;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_133;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_92 = _zz_237;
  assign _zz_93 = 1'b0;
  assign _zz_94 = 1'b1;
  assign _zz_135 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_136 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_137 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010100)) == (32'b00000000000000000000000001000000));
  assign _zz_138 = ((decode_INSTRUCTION & (32'b00000000000000000111000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_139 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000000)) == (32'b00000000000000000100000000000000));
  assign _zz_140 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_141 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_142 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_134 = {({(_zz_349 == _zz_350),{_zz_136,{_zz_351,_zz_352}}} != (4'b0000)),{((_zz_353 == _zz_354) != (1'b0)),{(_zz_355 != (1'b0)),{(_zz_356 != _zz_357),{_zz_358,{_zz_359,_zz_360}}}}}};
  assign _zz_69 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000001000001111111)) == (32'b00000000000000000001000001110011)),{((decode_INSTRUCTION & _zz_462) == (32'b00000000000000000010000001110011)),{(_zz_463 == _zz_464),{_zz_465,{_zz_466,_zz_467}}}}}}} != (20'b00000000000000000000));
  assign _zz_143 = _zz_134[1 : 0];
  assign _zz_68 = _zz_143;
  assign _zz_67 = _zz_273[0];
  assign _zz_66 = _zz_274[0];
  assign _zz_65 = _zz_275[0];
  assign _zz_64 = _zz_276[0];
  assign _zz_63 = _zz_277[0];
  assign _zz_62 = _zz_278[0];
  assign _zz_144 = _zz_134[9 : 8];
  assign _zz_61 = _zz_144;
  assign _zz_60 = _zz_279[0];
  assign _zz_59 = _zz_280[0];
  assign _zz_58 = _zz_281[0];
  assign _zz_57 = _zz_282[0];
  assign _zz_145 = _zz_134[15 : 14];
  assign _zz_56 = _zz_145;
  assign _zz_146 = _zz_134[17 : 16];
  assign _zz_55 = _zz_146;
  assign _zz_54 = _zz_283[0];
  assign _zz_53 = _zz_284[0];
  assign _zz_52 = _zz_285[0];
  assign _zz_147 = _zz_134[22 : 21];
  assign _zz_51 = _zz_147;
  assign _zz_148 = _zz_134[24 : 23];
  assign _zz_50 = _zz_148;
  assign _zz_49 = _zz_286[0];
  assign _zz_149 = _zz_134[27 : 26];
  assign _zz_48 = _zz_149;
  assign _zz_47 = _zz_287[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_150 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_223;
  assign _zz_151 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_224;
  assign _zz_46 = decode_RegFilePlugin_rs1Data;
  assign _zz_45 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_43 && writeBack_arbitration_isFiring);
    if(_zz_152)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_42[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_70;
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
        _zz_153 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_153 = {31'd0, _zz_288};
      end
      default : begin
        _zz_153 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_40 = _zz_153;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_154 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_PC_INCREMENT : begin
        _zz_154 = {29'd0, _zz_289};
      end
      default : begin
        _zz_154 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_38 = _zz_154;
  assign _zz_155 = _zz_290[11];
  always @ (*) begin
    _zz_156[19] = _zz_155;
    _zz_156[18] = _zz_155;
    _zz_156[17] = _zz_155;
    _zz_156[16] = _zz_155;
    _zz_156[15] = _zz_155;
    _zz_156[14] = _zz_155;
    _zz_156[13] = _zz_155;
    _zz_156[12] = _zz_155;
    _zz_156[11] = _zz_155;
    _zz_156[10] = _zz_155;
    _zz_156[9] = _zz_155;
    _zz_156[8] = _zz_155;
    _zz_156[7] = _zz_155;
    _zz_156[6] = _zz_155;
    _zz_156[5] = _zz_155;
    _zz_156[4] = _zz_155;
    _zz_156[3] = _zz_155;
    _zz_156[2] = _zz_155;
    _zz_156[1] = _zz_155;
    _zz_156[0] = _zz_155;
  end

  assign _zz_157 = _zz_291[11];
  always @ (*) begin
    _zz_158[19] = _zz_157;
    _zz_158[18] = _zz_157;
    _zz_158[17] = _zz_157;
    _zz_158[16] = _zz_157;
    _zz_158[15] = _zz_157;
    _zz_158[14] = _zz_157;
    _zz_158[13] = _zz_157;
    _zz_158[12] = _zz_157;
    _zz_158[11] = _zz_157;
    _zz_158[10] = _zz_157;
    _zz_158[9] = _zz_157;
    _zz_158[8] = _zz_157;
    _zz_158[7] = _zz_157;
    _zz_158[6] = _zz_157;
    _zz_158[5] = _zz_157;
    _zz_158[4] = _zz_157;
    _zz_158[3] = _zz_157;
    _zz_158[2] = _zz_157;
    _zz_158[1] = _zz_157;
    _zz_158[0] = _zz_157;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_159 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_159 = {_zz_156,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_159 = {_zz_158,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_159 = _zz_34;
      end
    endcase
  end

  assign _zz_36 = _zz_159;
  assign execute_SrcPlugin_addSub = _zz_292;
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
        _zz_160 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_160 = _zz_300;
      end
    endcase
  end

  always @ (*) begin
    _zz_161 = 1'b0;
    _zz_162 = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! _zz_166)))begin
        if(_zz_167)begin
          _zz_161 = 1'b1;
        end
        if(_zz_168)begin
          _zz_162 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_169)begin
          _zz_161 = 1'b1;
        end
        if(_zz_170)begin
          _zz_162 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_171)begin
          _zz_161 = 1'b1;
        end
        if(_zz_172)begin
          _zz_162 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_161 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_162 = 1'b0;
    end
  end

  assign _zz_166 = 1'b1;
  assign _zz_167 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_168 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_169 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_170 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_171 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_172 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_27 = _zz_88;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_173 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_173 == (3'b000))) begin
        _zz_174 = execute_BranchPlugin_eq;
    end else if((_zz_173 == (3'b001))) begin
        _zz_174 = (! execute_BranchPlugin_eq);
    end else if((((_zz_173 & (3'b101)) == (3'b101)))) begin
        _zz_174 = (! execute_SRC_LESS);
    end else begin
        _zz_174 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_175 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_175 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_175 = 1'b1;
      end
      default : begin
        _zz_175 = _zz_174;
      end
    endcase
  end

  assign _zz_25 = (execute_PREDICTION_HAD_BRANCHED2 != _zz_175);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_177,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = (execute_PREDICTION_HAD_BRANCHED2 ? _zz_305 : {{_zz_179,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
      end
    endcase
  end

  assign _zz_176 = _zz_302[11];
  always @ (*) begin
    _zz_177[19] = _zz_176;
    _zz_177[18] = _zz_176;
    _zz_177[17] = _zz_176;
    _zz_177[16] = _zz_176;
    _zz_177[15] = _zz_176;
    _zz_177[14] = _zz_176;
    _zz_177[13] = _zz_176;
    _zz_177[12] = _zz_176;
    _zz_177[11] = _zz_176;
    _zz_177[10] = _zz_176;
    _zz_177[9] = _zz_176;
    _zz_177[8] = _zz_176;
    _zz_177[7] = _zz_176;
    _zz_177[6] = _zz_176;
    _zz_177[5] = _zz_176;
    _zz_177[4] = _zz_176;
    _zz_177[3] = _zz_176;
    _zz_177[2] = _zz_176;
    _zz_177[1] = _zz_176;
    _zz_177[0] = _zz_176;
  end

  assign _zz_178 = _zz_303[11];
  always @ (*) begin
    _zz_179[18] = _zz_178;
    _zz_179[17] = _zz_178;
    _zz_179[16] = _zz_178;
    _zz_179[15] = _zz_178;
    _zz_179[14] = _zz_178;
    _zz_179[13] = _zz_178;
    _zz_179[12] = _zz_178;
    _zz_179[11] = _zz_178;
    _zz_179[10] = _zz_178;
    _zz_179[9] = _zz_178;
    _zz_179[8] = _zz_178;
    _zz_179[7] = _zz_178;
    _zz_179[6] = _zz_178;
    _zz_179[5] = _zz_178;
    _zz_179[4] = _zz_178;
    _zz_179[3] = _zz_178;
    _zz_179[2] = _zz_178;
    _zz_179[1] = _zz_178;
    _zz_179[0] = _zz_178;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_24 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_95 = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_96 = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && (memory_BRANCH_CALC[1 : 0] != (2'b00))));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = memory_BRANCH_CALC;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  assign decode_exception_agregat_valid = (_zz_91 || decodeExceptionPort_valid);
  assign _zz_180 = {decodeExceptionPort_valid,_zz_91};
  assign _zz_181 = _zz_306[1];
  assign _zz_182 = _zz_181;
  assign decode_exception_agregat_payload_code = _zz_229;
  assign decode_exception_agregat_payload_badAddr = _zz_230;
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
  assign CsrPlugin_interrupt = (CsrPlugin_interruptRequest && _zz_100);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && _zz_101);
  assign CsrPlugin_writeBackWasWfi = 1'b0;
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusCachedPlugin_injector_nextPcCalc_valids_4);
    if(((CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptCode = ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_309);
  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  assign contextSwitching = _zz_97;
  assign _zz_22 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_21 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_191;
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
        execute_CsrPlugin_readData[31 : 0] = _zz_193;
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
    if((_zz_99 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_311 : execute_SRC1);
  always @ (*) begin
    case(_zz_265)
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
    if(_zz_249)begin
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
      memory_MulDivIterativePlugin_mul_counter_valueNext = (memory_MulDivIterativePlugin_mul_counter_value + _zz_313);
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
      memory_MulDivIterativePlugin_div_counter_valueNext = (memory_MulDivIterativePlugin_div_counter_value + _zz_321);
    end
    if(memory_MulDivIterativePlugin_div_counter_willClear)begin
      memory_MulDivIterativePlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_184 = memory_MulDivIterativePlugin_rs1[31 : 0];
  assign _zz_185 = {memory_MulDivIterativePlugin_accumulator[31 : 0],_zz_184[31]};
  assign _zz_186 = (_zz_185 - _zz_322);
  assign _zz_187 = (memory_INSTRUCTION[13] ? memory_MulDivIterativePlugin_accumulator[31 : 0] : memory_MulDivIterativePlugin_rs1[31 : 0]);
  assign _zz_188 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_189 = ((execute_IS_MUL && _zz_188) || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_190[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_190[31 : 0] = execute_RS1;
  end

  assign _zz_193 = (_zz_191 & _zz_192);
  assign externalInterrupt = (_zz_193 != (32'b00000000000000000000000000000000));
  assign DebugPlugin_isPipBusy = (DebugPlugin_isPipActive || _zz_194);
  always @ (*) begin
    _zz_225 = 1'b1;
    _zz_102 = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_256)
        1'b0 : begin
        end
        default : begin
          if(debug_bus_cmd_payload_wr)begin
            _zz_102 = 1'b1;
            _zz_225 = _zz_103;
          end
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_195))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign debug_resetOut = _zz_196;
  assign _zz_20 = decode_BRANCH_CTRL;
  assign _zz_76 = _zz_61;
  assign _zz_26 = decode_to_execute_BRANCH_CTRL;
  assign _zz_18 = decode_SHIFT_CTRL;
  assign _zz_16 = _zz_56;
  assign _zz_30 = decode_to_execute_SHIFT_CTRL;
  assign _zz_15 = decode_SRC2_CTRL;
  assign _zz_13 = _zz_68;
  assign _zz_35 = decode_to_execute_SRC2_CTRL;
  assign _zz_12 = decode_ALU_BITWISE_CTRL;
  assign _zz_10 = _zz_55;
  assign _zz_41 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_9 = decode_SRC1_CTRL;
  assign _zz_7 = _zz_48;
  assign _zz_37 = decode_to_execute_SRC1_CTRL;
  assign _zz_6 = decode_ALU_CTRL;
  assign _zz_4 = _zz_50;
  assign _zz_39 = decode_to_execute_ALU_CTRL;
  assign _zz_3 = decode_ENV_CTRL;
  assign _zz_1 = _zz_51;
  assign _zz_23 = decode_to_execute_ENV_CTRL;
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
  assign iBusWishbone_ADR = {_zz_341,_zz_199};
  assign iBusWishbone_CTI = ((_zz_199 == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    _zz_226 = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_261)begin
      _zz_226 = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_200;
  assign iBus_rsp_payload_data = _zz_201;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_202 = _zz_206;
  assign _zz_204 = _zz_208;
  assign _zz_205 = _zz_209;
  assign dBus_cmd_ready = _zz_207;
  assign dBusWishbone_ADR = (_zz_205 >>> 2);
  assign dBusWishbone_CTI = (3'b000);
  assign dBusWishbone_BTE = (2'b00);
  always @ (*) begin
    case(_zz_211)
      2'b00 : begin
        _zz_212 = (4'b0001);
      end
      2'b01 : begin
        _zz_212 = (4'b0011);
      end
      default : begin
        _zz_212 = (4'b1111);
      end
    endcase
  end

  always @ (*) begin
    dBusWishbone_SEL = _zz_342[3:0];
    if((! _zz_204))begin
      dBusWishbone_SEL = (4'b1111);
    end
  end

  assign _zz_227 = _zz_204;
  assign dBusWishbone_DAT_MOSI = _zz_210;
  assign _zz_203 = (_zz_202 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_202;
  assign dBusWishbone_STB = _zz_202;
  assign dBus_rsp_ready = ((_zz_202 && (! _zz_227)) && dBusWishbone_ACK);
  assign dBus_rsp_data = dBusWishbone_DAT_MISO;
  assign dBus_rsp_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_99 <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_110 <= 1'b0;
      _zz_112 <= 1'b0;
      _zz_117 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      _zz_152 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_163 <= 1'b0;
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
      _zz_191 <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_197 <= (3'b000);
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_199 <= (3'b000);
      _zz_200 <= 1'b0;
      _zz_206 <= 1'b0;
      _zz_207 <= 1'b1;
    end else begin
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_259)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_110 <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        _zz_112 <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_input_ready)begin
        _zz_112 <= IBusCachedPlugin_iBusRsp_input_valid;
      end
      if(_zz_115)begin
        _zz_117 <= (IBusCachedPlugin_iBusRsp_inputPipeline_0_valid && _zz_114);
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        _zz_117 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_cacheRspArbitration_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_84))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      _zz_152 <= 1'b0;
      if(_zz_251)begin
        if(_zz_255)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_163 <= (_zz_43 && writeBack_arbitration_isFiring);
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
      if(_zz_257)begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_99;
      end
      if(_zz_254)begin
        if(! _zz_260) begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_99 <= CsrPlugin_mstatus_MPP;
        end
      end
      memory_MulDivIterativePlugin_mul_counter_value <= memory_MulDivIterativePlugin_mul_counter_valueNext;
      memory_MulDivIterativePlugin_div_counter_value <= memory_MulDivIterativePlugin_div_counter_valueNext;
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_28;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
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
      case(_zz_197)
        3'b000 : begin
          if(_zz_102)begin
            _zz_197 <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_197 <= (3'b010);
        end
        3'b010 : begin
          _zz_197 <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_197 <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_197 <= (3'b000);
        end
        default : begin
        end
      endcase
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_191 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_335[0];
            CsrPlugin_mstatus_MIE <= _zz_336[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_337[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_338[0];
            CsrPlugin_mie_MTIE <= _zz_339[0];
            CsrPlugin_mie_MSIE <= _zz_340[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_261)begin
        if(iBusWishbone_ACK)begin
          _zz_199 <= (_zz_199 + (3'b001));
        end
      end
      _zz_200 <= (_zz_226 && iBusWishbone_ACK);
      if(_zz_262)begin
        _zz_206 <= dBus_cmd_valid;
        _zz_207 <= (! dBus_cmd_valid);
      end else begin
        _zz_206 <= (! _zz_203);
        _zz_207 <= _zz_203;
      end
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_input_ready)begin
      _zz_113 <= IBusCachedPlugin_iBusRsp_input_payload;
    end
    if(_zz_115)begin
      _zz_118 <= IBusCachedPlugin_iBusRsp_inputPipeline_0_payload;
    end
    if (!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if (!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow writeback stage stall when read happend");
    end
    if(_zz_251)begin
      if(_zz_255)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    _zz_164 <= _zz_42[11 : 7];
    _zz_165 <= _zz_70;
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
    if(_zz_257)begin
      CsrPlugin_mepc <= writeBack_PC;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interruptJump;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_interruptCode;
    end
    _zz_183 <= CsrPlugin_exception;
    if(_zz_183)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    if(_zz_258)begin
      if(_zz_252)begin
        memory_MulDivIterativePlugin_rs2 <= (memory_MulDivIterativePlugin_rs2 >>> 1);
        memory_MulDivIterativePlugin_accumulator <= ({_zz_314,memory_MulDivIterativePlugin_accumulator[31 : 0]} >>> 1);
      end
    end
    if(_zz_253)begin
      if(_zz_250)begin
        memory_MulDivIterativePlugin_rs1[31 : 0] <= _zz_323[31:0];
        memory_MulDivIterativePlugin_accumulator[31 : 0] <= ((! _zz_186[32]) ? _zz_324 : _zz_325);
        if((memory_MulDivIterativePlugin_div_counter_value == (6'b100000)))begin
          memory_MulDivIterativePlugin_div_result <= _zz_326[31:0];
        end
      end
    end
    if(_zz_249)begin
      memory_MulDivIterativePlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_MulDivIterativePlugin_rs1 <= ((_zz_189 ? (~ _zz_190) : _zz_190) + _zz_332);
      memory_MulDivIterativePlugin_rs2 <= ((_zz_188 ? (~ execute_RS2) : execute_RS2) + _zz_334);
      memory_MulDivIterativePlugin_div_needRevert <= (_zz_189 ^ (_zz_188 && (! execute_INSTRUCTION[13])));
    end
    _zz_192 <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_19;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
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
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_34;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
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
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FLUSH_ALL <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FLUSH_ALL <= execute_FLUSH_ALL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_EBREAK <= decode_IS_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_17;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_29;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_14;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_11;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_78;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_77;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_8;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_2;
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
    _zz_201 <= iBusWishbone_DAT_MISO;
    if(_zz_262)begin
      _zz_208 <= dBus_cmd_payload_wr;
      _zz_209 <= dBus_cmd_payload_address;
      _zz_210 <= dBus_cmd_payload_data;
      _zz_211 <= dBus_cmd_payload_size;
    end
  end

  always @ (posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(_zz_225)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipActive <= (((decode_arbitration_isValid || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid);
    _zz_194 <= DebugPlugin_isPipActive;
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_70;
    end
    _zz_195 <= debug_bus_cmd_payload_address[2];
    _zz_196 <= DebugPlugin_resetIt;
  end

  always @ (posedge clk) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if(debug_bus_cmd_valid)begin
        case(_zz_256)
          1'b0 : begin
            if(debug_bus_cmd_payload_wr)begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(debug_bus_cmd_payload_data[16])begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[24])begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[17])begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
            end
          end
          default : begin
          end
        endcase
      end
      if(execute_IS_EBREAK)begin
        if(execute_arbitration_isFiring)begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(_zz_263)begin
        if(decode_arbitration_isValid)begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      if((DebugPlugin_stepIt && ({writeBack_arbitration_redoIt,{memory_arbitration_redoIt,{execute_arbitration_redoIt,decode_arbitration_redoIt}}} != (4'b0000))))begin
        DebugPlugin_haltIt <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    _zz_198 <= debug_bus_cmd_payload_data;
  end

endmodule

