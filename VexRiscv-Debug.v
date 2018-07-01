// Generator : SpinalHDL v1.1.5    git head : 0310b2489a097f2b9de5535e02192d9ddd2764ae
// Date      : 21/06/2018, 06:33:39
// Component : VexRiscv


`define DataCacheCpuCmdKind_binary_sequancial_type [0:0]
`define DataCacheCpuCmdKind_binary_sequancial_MEMORY 1'b0
`define DataCacheCpuCmdKind_binary_sequancial_MANAGMENT 1'b1

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

`define EnvCtrlEnum_binary_sequancial_type [1:0]
`define EnvCtrlEnum_binary_sequancial_NONE 2'b00
`define EnvCtrlEnum_binary_sequancial_EBREAK 2'b01
`define EnvCtrlEnum_binary_sequancial_MRET 2'b10

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_FOUR 2'b10

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

module InstructionCache (
      input   io_flush_cmd_valid,
      output  io_flush_cmd_ready,
      output  io_flush_rsp,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
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
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isUser,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuMiss,
      output  io_cpu_decode_illegalAccess,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_12;
  reg [31:0] _zz_13;
  wire  _zz_14;
  wire  _zz_15;
  wire  _zz_16;
  wire  _zz_17;
  wire  _zz_18;
  wire [0:0] _zz_19;
  wire [0:0] _zz_20;
  wire [21:0] _zz_21;
  reg  _zz_1;
  reg  _zz_2;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg [7:0] lineLoader_flushCounter;
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
  wire [6:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [19:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [9:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  _zz_6;
  wire [6:0] _zz_7;
  wire  _zz_8;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [19:0] fetchStage_read_waysValues_0_tag_address;
  wire [21:0] _zz_9;
  wire [9:0] _zz_10;
  wire  _zz_11;
  wire [31:0] fetchStage_read_waysValues_0_data;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_allowUser;
  reg  decodeStage_mmuRsp_miss;
  reg  decodeStage_hit_tags_0_valid;
  reg  decodeStage_hit_tags_0_error;
  reg [19:0] decodeStage_hit_tags_0_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_valid;
  wire  decodeStage_hit_error;
  reg [21:0] ways_0_tags [0:127];
  reg [31:0] ways_0_datas [0:1023];
  assign io_flush_cmd_ready = _zz_14;
  assign io_mem_cmd_valid = _zz_15;
  assign io_cpu_decode_cacheMiss = _zz_16;
  assign _zz_17 = (! lineLoader_flushCounter[7]);
  assign _zz_18 = (io_cpu_decode_isValid && _zz_16);
  assign _zz_19 = _zz_9[0 : 0];
  assign _zz_20 = _zz_9[1 : 1];
  assign _zz_21 = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_21;
    end
  end

  always @ (posedge clk) begin
    if(_zz_8) begin
      _zz_12 <= ways_0_tags[_zz_7];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_11) begin
      _zz_13 <= ways_0_datas[_zz_10];
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
    if(_zz_18)begin
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

  assign _zz_14 = (! (lineLoader_valid || io_cpu_fetch_isValid));
  assign _zz_4 = lineLoader_flushCounter[7];
  assign io_flush_rsp = ((_zz_4 && (! _zz_5)) && lineLoader_flushFromInterface);
  assign _zz_15 = (lineLoader_valid && (! lineLoader_cmdSent));
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
  assign lineLoader_write_tag_0_valid = ((_zz_6 && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_6);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_7 = io_cpu_prefetch_pc[11 : 5];
  assign _zz_8 = (! io_cpu_fetch_isStuck);
  assign _zz_9 = _zz_12;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_19[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_20[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_9[21 : 2];
  assign _zz_10 = io_cpu_prefetch_pc[11 : 2];
  assign _zz_11 = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_13;
  assign io_cpu_fetch_data = fetchStage_read_waysValues_0_data[31 : 0];
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
  assign decodeStage_hit_valid = (decodeStage_hit_hits_0 != (1'b0));
  assign decodeStage_hit_error = decodeStage_hit_tags_0_error;
  assign _zz_16 = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuMiss = decodeStage_mmuRsp_miss;
  assign io_cpu_decode_illegalAccess = ((! decodeStage_mmuRsp_allowExecute) || (io_cpu_decode_isUser && (! decodeStage_mmuRsp_allowUser)));
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushCounter <= (8'b00000000);
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
      if(_zz_17)begin
        lineLoader_flushCounter <= (lineLoader_flushCounter + (8'b00000001));
      end
      if(io_flush_cmd_valid)begin
        if(_zz_14)begin
          lineLoader_flushCounter <= (8'b00000000);
          lineLoader_flushFromInterface <= 1'b1;
        end
      end
      if((_zz_15 && io_mem_cmd_ready))begin
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
      if(_zz_18)begin
        lineLoader_valid <= 1'b1;
      end
    end
  end

  always @ (posedge clk) begin
    _zz_3 <= lineLoader_flushCounter[7];
    _zz_5 <= _zz_4;
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_allowUser <= io_cpu_fetch_mmuBus_rsp_allowUser;
      decodeStage_mmuRsp_miss <= io_cpu_fetch_mmuBus_rsp_miss;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if(_zz_18)begin
      lineLoader_address <= decodeStage_mmuRsp_physicalAddress;
    end
  end

endmodule

module DataCache (
      input   io_cpu_execute_isValid,
      input   io_cpu_execute_isStuck,
      input  `DataCacheCpuCmdKind_binary_sequancial_type io_cpu_execute_args_kind,
      input   io_cpu_execute_args_wr,
      input  [31:0] io_cpu_execute_args_address,
      input  [31:0] io_cpu_execute_args_data,
      input  [1:0] io_cpu_execute_args_size,
      input   io_cpu_execute_args_forceUncachedAccess,
      input   io_cpu_execute_args_clean,
      input   io_cpu_execute_args_invalidate,
      input   io_cpu_execute_args_way,
      input   io_cpu_memory_isValid,
      input   io_cpu_memory_isStuck,
      input   io_cpu_memory_isRemoved,
      output  io_cpu_memory_haltIt,
      output  io_cpu_memory_mmuBus_cmd_isValid,
      output [31:0] io_cpu_memory_mmuBus_cmd_virtualAddress,
      output  io_cpu_memory_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_memory_mmuBus_rsp_physicalAddress,
      input   io_cpu_memory_mmuBus_rsp_isIoAccess,
      input   io_cpu_memory_mmuBus_rsp_allowRead,
      input   io_cpu_memory_mmuBus_rsp_allowWrite,
      input   io_cpu_memory_mmuBus_rsp_allowExecute,
      input   io_cpu_memory_mmuBus_rsp_allowUser,
      input   io_cpu_memory_mmuBus_rsp_miss,
      input   io_cpu_writeBack_isValid,
      input   io_cpu_writeBack_isStuck,
      input   io_cpu_writeBack_isUser,
      output  io_cpu_writeBack_haltIt,
      output [31:0] io_cpu_writeBack_data,
      output reg  io_cpu_writeBack_mmuMiss,
      output reg  io_cpu_writeBack_illegalAccess,
      output reg  io_cpu_writeBack_unalignedAccess,
      output  io_cpu_writeBack_accessError,
      output [31:0] io_cpu_writeBack_badAddr,
      output reg  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output reg  io_mem_cmd_payload_wr,
      output reg [31:0] io_mem_cmd_payload_address,
      output reg [31:0] io_mem_cmd_payload_data,
      output reg [3:0] io_mem_cmd_payload_mask,
      output reg [2:0] io_mem_cmd_payload_length,
      output reg  io_mem_cmd_payload_last,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [21:0] _zz_42;
  reg [31:0] _zz_43;
  reg [31:0] _zz_44;
  reg  _zz_45;
  wire  _zz_46;
  wire  _zz_47;
  wire  _zz_48;
  wire  _zz_49;
  wire  _zz_50;
  wire  _zz_51;
  wire  _zz_52;
  wire [0:0] _zz_53;
  wire [0:0] _zz_54;
  wire [2:0] _zz_55;
  wire [0:0] _zz_56;
  wire [2:0] _zz_57;
  wire [0:0] _zz_58;
  wire [2:0] _zz_59;
  wire [21:0] _zz_60;
  reg  _zz_1;
  reg  _zz_2;
  reg  _zz_3;
  wire  haltCpu;
  reg  tagsReadCmd_valid;
  reg [6:0] tagsReadCmd_payload;
  reg  tagsWriteCmd_valid;
  reg [6:0] tagsWriteCmd_payload_address;
  reg  tagsWriteCmd_payload_data_used;
  reg  tagsWriteCmd_payload_data_dirty;
  reg [19:0] tagsWriteCmd_payload_data_address;
  reg  tagsWriteLastCmd_valid;
  reg [6:0] tagsWriteLastCmd_payload_address;
  reg  tagsWriteLastCmd_payload_data_used;
  reg  tagsWriteLastCmd_payload_data_dirty;
  reg [19:0] tagsWriteLastCmd_payload_data_address;
  reg  dataReadCmd_valid;
  reg [9:0] dataReadCmd_payload;
  reg  dataWriteCmd_valid;
  reg [9:0] dataWriteCmd_payload_address;
  reg [31:0] dataWriteCmd_payload_data;
  reg [3:0] dataWriteCmd_payload_mask;
  reg [6:0] way_tagReadRspOneAddress;
  wire [21:0] _zz_4;
  wire  _zz_5;
  reg  _zz_6;
  reg [6:0] _zz_7;
  reg  _zz_8;
  reg  _zz_9;
  reg [19:0] _zz_10;
  wire  _zz_11;
  wire  way_tagReadRspOne_used;
  wire  way_tagReadRspOne_dirty;
  wire [19:0] way_tagReadRspOne_address;
  reg  way_dataReadRspOneKeepAddress;
  reg [9:0] way_dataReadRspOneAddress;
  wire [31:0] way_dataReadRspOneWithoutBypass;
  wire  _zz_12;
  wire  _zz_13;
  reg  _zz_14;
  reg [9:0] _zz_15;
  reg [31:0] _zz_16;
  reg [3:0] _zz_17;
  reg [31:0] way_dataReadRspOne;
  wire  _zz_18;
  wire  way_tagReadRspTwoEnable;
  wire  _zz_19;
  wire  way_tagReadRspTwoRegIn_used;
  wire  way_tagReadRspTwoRegIn_dirty;
  wire [19:0] way_tagReadRspTwoRegIn_address;
  reg  way_tagReadRspTwo_used;
  reg  way_tagReadRspTwo_dirty;
  reg [19:0] way_tagReadRspTwo_address;
  wire  way_dataReadRspTwoEnable;
  reg [9:0] _zz_20;
  wire  _zz_21;
  wire  _zz_22;
  reg [7:0] _zz_23;
  reg [7:0] _zz_24;
  reg [7:0] _zz_25;
  reg [7:0] _zz_26;
  wire [31:0] way_dataReadRspTwo;
  wire  cpuMemoryStageNeedReadData;
  reg  victim_requestIn_valid;
  wire  victim_requestIn_ready;
  reg [31:0] victim_requestIn_payload_address;
  wire  victim_request_valid;
  reg  victim_request_ready;
  wire [31:0] victim_request_payload_address;
  reg  _zz_27;
  reg  _zz_28;
  reg [31:0] _zz_29;
  reg [3:0] victim_readLineCmdCounter;
  reg  victim_dataReadCmdOccure;
  reg  victim_dataReadRestored;
  reg [3:0] victim_readLineRspCounter;
  reg  _zz_30;
  reg [3:0] victim_bufferReadCounter;
  wire  victim_bufferReadStream_valid;
  wire  victim_bufferReadStream_ready;
  wire [2:0] victim_bufferReadStream_payload;
  wire  _zz_31;
  wire  _zz_32;
  reg  _zz_33;
  wire  victim_bufferReaded_valid;
  reg  victim_bufferReaded_ready;
  wire [31:0] victim_bufferReaded_payload;
  reg  _zz_34;
  reg [31:0] _zz_35;
  reg [2:0] victim_bufferReadedCounter;
  reg  victim_memCmdAlreadyUsed;
  wire  victim_counter_willIncrement;
  wire  victim_counter_willClear;
  reg [2:0] victim_counter_valueNext;
  reg [2:0] victim_counter_value;
  wire  victim_counter_willOverflowIfInc;
  wire  victim_counter_willOverflow;
  reg `DataCacheCpuCmdKind_binary_sequancial_type stageA_request_kind;
  reg  stageA_request_wr;
  reg [31:0] stageA_request_address;
  reg [31:0] stageA_request_data;
  reg [1:0] stageA_request_size;
  reg  stageA_request_forceUncachedAccess;
  reg  stageA_request_clean;
  reg  stageA_request_invalidate;
  reg  stageA_request_way;
  reg `DataCacheCpuCmdKind_binary_sequancial_type stageB_request_kind;
  reg  stageB_request_wr;
  reg [31:0] stageB_request_address;
  reg [31:0] stageB_request_data;
  reg [1:0] stageB_request_size;
  reg  stageB_request_forceUncachedAccess;
  reg  stageB_request_clean;
  reg  stageB_request_invalidate;
  reg  stageB_request_way;
  reg [31:0] stageB_mmuRsp_physicalAddress;
  reg  stageB_mmuRsp_isIoAccess;
  reg  stageB_mmuRsp_allowRead;
  reg  stageB_mmuRsp_allowWrite;
  reg  stageB_mmuRsp_allowExecute;
  reg  stageB_mmuRsp_allowUser;
  reg  stageB_mmuRsp_miss;
  reg  stageB_waysHit;
  reg  stageB_loaderValid;
  reg  stageB_loaderReady;
  reg  stageB_loadingDone;
  reg  stageB_delayedIsStuck;
  reg  stageB_delayedWaysHitValid;
  reg  stageB_victimNotSent;
  reg  stageB_loadingNotDone;
  reg [3:0] _zz_36;
  wire [3:0] stageB_writeMask;
  reg  stageB_hadMemRspErrorReg;
  wire  stageB_hadMemRspError;
  reg  stageB_bootEvicts_valid;
  wire [4:0] _zz_37;
  wire  _zz_38;
  wire  _zz_39;
  reg  _zz_40;
  wire [4:0] _zz_41;
  reg  loader_valid;
  reg  loader_memCmdSent;
  reg  loader_counter_willIncrement;
  wire  loader_counter_willClear;
  reg [2:0] loader_counter_valueNext;
  reg [2:0] loader_counter_value;
  wire  loader_counter_willOverflowIfInc;
  wire  loader_counter_willOverflow;
  reg [21:0] way_tags [0:127];
  reg [7:0] way_data_symbol0 [0:1023];
  reg [7:0] way_data_symbol1 [0:1023];
  reg [7:0] way_data_symbol2 [0:1023];
  reg [7:0] way_data_symbol3 [0:1023];
  reg [7:0] _zz_61;
  reg [7:0] _zz_62;
  reg [7:0] _zz_63;
  reg [7:0] _zz_64;
  reg [31:0] victim_buffer [0:7];
  assign io_cpu_writeBack_haltIt = _zz_45;
  assign _zz_46 = (! io_cpu_writeBack_isStuck);
  assign _zz_47 = (! victim_request_valid);
  assign _zz_48 = (stageB_mmuRsp_physicalAddress[11 : 5] != (7'b1111111));
  assign _zz_49 = (! _zz_40);
  assign _zz_50 = (! _zz_27);
  assign _zz_51 = ((! victim_memCmdAlreadyUsed) && io_mem_cmd_ready);
  assign _zz_52 = (! victim_readLineCmdCounter[3]);
  assign _zz_53 = _zz_4[0 : 0];
  assign _zz_54 = _zz_4[1 : 1];
  assign _zz_55 = victim_readLineRspCounter[2:0];
  assign _zz_56 = victim_counter_willIncrement;
  assign _zz_57 = {2'd0, _zz_56};
  assign _zz_58 = loader_counter_willIncrement;
  assign _zz_59 = {2'd0, _zz_58};
  assign _zz_60 = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_dirty,tagsWriteCmd_payload_data_used}};
  always @ (posedge clk) begin
    if(_zz_3) begin
      way_tags[tagsWriteCmd_payload_address] <= _zz_60;
    end
  end

  always @ (posedge clk) begin
    if(tagsReadCmd_valid) begin
      _zz_42 <= way_tags[tagsReadCmd_payload];
    end
  end

  always @ (*) begin
    _zz_43 = {_zz_64, _zz_63, _zz_62, _zz_61};
  end
  always @ (posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_2) begin
      way_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_2) begin
      way_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_2) begin
      way_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_2) begin
      way_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @ (posedge clk) begin
    if(dataReadCmd_valid) begin
      _zz_61 <= way_data_symbol0[dataReadCmd_payload];
      _zz_62 <= way_data_symbol1[dataReadCmd_payload];
      _zz_63 <= way_data_symbol2[dataReadCmd_payload];
      _zz_64 <= way_data_symbol3[dataReadCmd_payload];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1) begin
      victim_buffer[_zz_55] <= way_dataReadRspOneWithoutBypass;
    end
  end

  always @ (posedge clk) begin
    if(victim_bufferReadStream_ready) begin
      _zz_44 <= victim_buffer[victim_bufferReadStream_payload];
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(_zz_30)begin
      _zz_1 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2 = 1'b0;
    if(dataWriteCmd_valid)begin
      _zz_2 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3 = 1'b0;
    if(tagsWriteCmd_valid)begin
      _zz_3 = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  always @ (*) begin
    tagsReadCmd_valid = 1'b0;
    tagsReadCmd_payload = (7'bxxxxxxx);
    dataReadCmd_valid = 1'b0;
    dataReadCmd_payload = (10'bxxxxxxxxxx);
    way_dataReadRspOneKeepAddress = 1'b0;
    if((io_cpu_execute_isValid && (! io_cpu_execute_isStuck)))begin
      tagsReadCmd_valid = 1'b1;
      tagsReadCmd_payload = io_cpu_execute_args_address[11 : 5];
      dataReadCmd_valid = 1'b1;
      dataReadCmd_payload = io_cpu_execute_args_address[11 : 2];
    end
    victim_dataReadCmdOccure = 1'b0;
    if(victim_request_valid)begin
      if(_zz_52)begin
        victim_dataReadCmdOccure = 1'b1;
        dataReadCmd_valid = 1'b1;
        dataReadCmd_payload = {victim_request_payload_address[11 : 5],victim_readLineCmdCounter[2 : 0]};
        way_dataReadRspOneKeepAddress = 1'b1;
      end else begin
        if(((! victim_dataReadRestored) && cpuMemoryStageNeedReadData))begin
          dataReadCmd_valid = 1'b1;
          dataReadCmd_payload = way_dataReadRspOneAddress;
        end
      end
    end
  end

  always @ (*) begin
    tagsWriteCmd_valid = 1'b0;
    tagsWriteCmd_payload_address = (7'bxxxxxxx);
    tagsWriteCmd_payload_data_used = 1'bx;
    tagsWriteCmd_payload_data_dirty = 1'bx;
    tagsWriteCmd_payload_data_address = (20'bxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_valid = 1'b0;
    dataWriteCmd_payload_address = (10'bxxxxxxxxxx);
    dataWriteCmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    dataWriteCmd_payload_mask = (4'bxxxx);
    io_mem_cmd_valid = 1'b0;
    io_mem_cmd_payload_wr = 1'bx;
    io_mem_cmd_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    io_mem_cmd_payload_data = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    io_mem_cmd_payload_mask = (4'bxxxx);
    io_mem_cmd_payload_length = (3'bxxx);
    io_mem_cmd_payload_last = 1'bx;
    victim_requestIn_valid = 1'b0;
    victim_requestIn_payload_address = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    victim_request_ready = 1'b0;
    victim_bufferReaded_ready = 1'b0;
    if(victim_bufferReaded_valid)begin
      io_mem_cmd_valid = 1'b1;
      io_mem_cmd_payload_wr = 1'b1;
      io_mem_cmd_payload_address = {victim_request_payload_address[31 : 5],(5'b00000)};
      io_mem_cmd_payload_length = (3'b111);
      io_mem_cmd_payload_data = victim_bufferReaded_payload;
      io_mem_cmd_payload_mask = (4'b1111);
      io_mem_cmd_payload_last = (victim_bufferReadedCounter == (3'b111));
      if(_zz_51)begin
        victim_bufferReaded_ready = 1'b1;
        if((victim_bufferReadedCounter == (3'b111)))begin
          victim_request_ready = 1'b1;
        end
      end
    end
    stageB_loaderValid = 1'b0;
    _zz_45 = io_cpu_writeBack_isValid;
    io_cpu_writeBack_mmuMiss = 1'b0;
    io_cpu_writeBack_illegalAccess = 1'b0;
    io_cpu_writeBack_unalignedAccess = 1'b0;
    if(stageB_bootEvicts_valid)begin
      tagsWriteCmd_valid = stageB_bootEvicts_valid;
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
      tagsWriteCmd_payload_data_used = 1'b0;
      if(_zz_48)begin
        _zz_45 = 1'b1;
      end
    end
    if(io_cpu_writeBack_isValid)begin
      io_cpu_writeBack_mmuMiss = stageB_mmuRsp_miss;
      case(stageB_request_kind)
        `DataCacheCpuCmdKind_binary_sequancial_MANAGMENT : begin
          if((stageB_delayedIsStuck && (! stageB_mmuRsp_miss)))begin
            if((stageB_delayedWaysHitValid || (stageB_request_way && way_tagReadRspTwo_used)))begin
              if((! (victim_requestIn_valid && (! victim_requestIn_ready))))begin
                _zz_45 = 1'b0;
              end
              victim_requestIn_valid = (stageB_request_clean && way_tagReadRspTwo_dirty);
              tagsWriteCmd_valid = victim_requestIn_ready;
            end else begin
              _zz_45 = 1'b0;
            end
          end
          victim_requestIn_payload_address = {{way_tagReadRspTwo_address,stageB_mmuRsp_physicalAddress[11 : 5]},_zz_37};
          tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
          tagsWriteCmd_payload_data_used = (! stageB_request_invalidate);
          tagsWriteCmd_payload_data_dirty = (! stageB_request_clean);
        end
        default : begin
          io_cpu_writeBack_illegalAccess = _zz_38;
          io_cpu_writeBack_unalignedAccess = _zz_39;
          if((((1'b0 || (! stageB_mmuRsp_miss)) && (! _zz_38)) && (! _zz_39)))begin
            if((stageB_request_forceUncachedAccess || stageB_mmuRsp_isIoAccess))begin
              if(_zz_47)begin
                io_mem_cmd_payload_wr = stageB_request_wr;
                io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
                io_mem_cmd_payload_mask = stageB_writeMask;
                io_mem_cmd_payload_data = stageB_request_data;
                io_mem_cmd_payload_length = (3'b000);
                io_mem_cmd_payload_last = 1'b1;
                if(_zz_49)begin
                  io_mem_cmd_valid = 1'b1;
                end
                if((_zz_40 && (io_mem_rsp_valid || stageB_request_wr)))begin
                  _zz_45 = 1'b0;
                end
              end
            end else begin
              if((stageB_waysHit || (! stageB_loadingNotDone)))begin
                _zz_45 = 1'b0;
                dataWriteCmd_valid = stageB_request_wr;
                dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
                dataWriteCmd_payload_data = stageB_request_data;
                dataWriteCmd_payload_mask = stageB_writeMask;
                tagsWriteCmd_valid = ((! stageB_loadingNotDone) || stageB_request_wr);
                tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
                tagsWriteCmd_payload_data_used = 1'b1;
                tagsWriteCmd_payload_data_dirty = stageB_request_wr;
                tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
              end else begin
                stageB_loaderValid = (stageB_loadingNotDone && (! (stageB_victimNotSent && (victim_request_valid && (! victim_request_ready)))));
                victim_requestIn_valid = ((way_tagReadRspTwo_used && way_tagReadRspTwo_dirty) && stageB_victimNotSent);
                victim_requestIn_payload_address = {{way_tagReadRspTwo_address,stageB_mmuRsp_physicalAddress[11 : 5]},_zz_41};
              end
            end
          end
        end
      endcase
    end
    if((loader_valid && (! loader_memCmdSent)))begin
      io_mem_cmd_valid = 1'b1;
      io_mem_cmd_payload_wr = 1'b0;
      io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 5],(5'b00000)};
      io_mem_cmd_payload_length = (3'b111);
      io_mem_cmd_payload_last = 1'b1;
    end
    loader_counter_willIncrement = 1'b0;
    if((loader_valid && io_mem_rsp_valid))begin
      dataWriteCmd_valid = 1'b1;
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
      dataWriteCmd_payload_mask = (4'b1111);
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign _zz_4 = _zz_42;
  assign _zz_5 = (tagsReadCmd_valid || (tagsWriteCmd_valid && (tagsWriteCmd_payload_address == way_tagReadRspOneAddress)));
  assign _zz_11 = (_zz_6 && (_zz_7 == way_tagReadRspOneAddress));
  assign way_tagReadRspOne_used = (_zz_11 ? _zz_8 : _zz_53[0]);
  assign way_tagReadRspOne_dirty = (_zz_11 ? _zz_9 : _zz_54[0]);
  assign way_tagReadRspOne_address = (_zz_11 ? _zz_10 : _zz_4[21 : 2]);
  assign way_dataReadRspOneWithoutBypass = _zz_43;
  assign _zz_12 = (dataWriteCmd_valid && (dataWriteCmd_payload_address == way_dataReadRspOneAddress));
  assign _zz_13 = (dataReadCmd_valid || _zz_12);
  assign _zz_18 = (_zz_14 && (_zz_15 == way_dataReadRspOneAddress));
  always @ (*) begin
    way_dataReadRspOne[7 : 0] = ((_zz_18 && _zz_17[0]) ? _zz_16[7 : 0] : way_dataReadRspOneWithoutBypass[7 : 0]);
    way_dataReadRspOne[15 : 8] = ((_zz_18 && _zz_17[1]) ? _zz_16[15 : 8] : way_dataReadRspOneWithoutBypass[15 : 8]);
    way_dataReadRspOne[23 : 16] = ((_zz_18 && _zz_17[2]) ? _zz_16[23 : 16] : way_dataReadRspOneWithoutBypass[23 : 16]);
    way_dataReadRspOne[31 : 24] = ((_zz_18 && _zz_17[3]) ? _zz_16[31 : 24] : way_dataReadRspOneWithoutBypass[31 : 24]);
  end

  assign way_tagReadRspTwoEnable = (! io_cpu_writeBack_isStuck);
  assign _zz_19 = (tagsWriteCmd_valid && (tagsWriteCmd_payload_address == way_tagReadRspOneAddress));
  assign way_tagReadRspTwoRegIn_used = (_zz_19 ? tagsWriteCmd_payload_data_used : way_tagReadRspOne_used);
  assign way_tagReadRspTwoRegIn_dirty = (_zz_19 ? tagsWriteCmd_payload_data_dirty : way_tagReadRspOne_dirty);
  assign way_tagReadRspTwoRegIn_address = (_zz_19 ? tagsWriteCmd_payload_data_address : way_tagReadRspOne_address);
  assign way_dataReadRspTwoEnable = (! io_cpu_writeBack_isStuck);
  assign _zz_21 = (dataWriteCmd_valid && (way_dataReadRspOneAddress == dataWriteCmd_payload_address));
  assign _zz_22 = (dataWriteCmd_valid && (_zz_20 == dataWriteCmd_payload_address));
  assign way_dataReadRspTwo = {_zz_26,{_zz_25,{_zz_24,_zz_23}}};
  assign victim_request_valid = _zz_27;
  assign victim_request_payload_address = _zz_29;
  assign victim_requestIn_ready = _zz_28;
  assign io_cpu_memory_haltIt = ((cpuMemoryStageNeedReadData && victim_request_valid) && (! victim_dataReadRestored));
  assign victim_bufferReadStream_valid = (victim_bufferReadCounter < victim_readLineRspCounter);
  assign victim_bufferReadStream_payload = victim_bufferReadCounter[2:0];
  assign victim_bufferReadStream_ready = ((! _zz_31) || _zz_32);
  assign _zz_31 = _zz_33;
  assign _zz_32 = ((1'b1 && (! victim_bufferReaded_valid)) || victim_bufferReaded_ready);
  assign victim_bufferReaded_valid = _zz_34;
  assign victim_bufferReaded_payload = _zz_35;
  always @ (*) begin
    victim_memCmdAlreadyUsed = 1'b0;
    if((loader_valid && (! loader_memCmdSent)))begin
      victim_memCmdAlreadyUsed = 1'b1;
    end
  end

  assign victim_counter_willIncrement = 1'b0;
  assign victim_counter_willClear = 1'b0;
  assign victim_counter_willOverflowIfInc = (victim_counter_value == (3'b111));
  assign victim_counter_willOverflow = (victim_counter_willOverflowIfInc && victim_counter_willIncrement);
  always @ (*) begin
    victim_counter_valueNext = (victim_counter_value + _zz_57);
    if(victim_counter_willClear)begin
      victim_counter_valueNext = (3'b000);
    end
  end

  assign io_cpu_memory_mmuBus_cmd_isValid = (io_cpu_memory_isValid && (stageA_request_kind == `DataCacheCpuCmdKind_binary_sequancial_MEMORY));
  assign io_cpu_memory_mmuBus_cmd_virtualAddress = stageA_request_address;
  assign io_cpu_memory_mmuBus_cmd_bypassTranslation = stageA_request_way;
  assign cpuMemoryStageNeedReadData = ((io_cpu_memory_isValid && (stageA_request_kind == `DataCacheCpuCmdKind_binary_sequancial_MEMORY)) && (! stageA_request_wr));
  always @ (*) begin
    stageB_loaderReady = 1'b0;
    if(loader_counter_willOverflow)begin
      stageB_loaderReady = 1'b1;
    end
  end

  always @ (*) begin
    case(stageB_request_size)
      2'b00 : begin
        _zz_36 = (4'b0001);
      end
      2'b01 : begin
        _zz_36 = (4'b0011);
      end
      default : begin
        _zz_36 = (4'b1111);
      end
    endcase
  end

  assign stageB_writeMask = (_zz_36 <<< stageB_mmuRsp_physicalAddress[1 : 0]);
  assign stageB_hadMemRspError = ((io_mem_rsp_valid && io_mem_rsp_payload_error) || stageB_hadMemRspErrorReg);
  assign io_cpu_writeBack_accessError = (stageB_hadMemRspError && (! _zz_45));
  assign io_cpu_writeBack_badAddr = stageB_request_address;
  assign _zz_37[4 : 0] = (5'b00000);
  assign _zz_38 = (((stageB_request_wr && (! stageB_mmuRsp_allowWrite)) || ((! stageB_request_wr) && (! stageB_mmuRsp_allowRead))) || (io_cpu_writeBack_isUser && (! stageB_mmuRsp_allowUser)));
  assign _zz_39 = (((stageB_request_size == (2'b10)) && (stageB_mmuRsp_physicalAddress[1 : 0] != (2'b00))) || ((stageB_request_size == (2'b01)) && (stageB_mmuRsp_physicalAddress[0 : 0] != (1'b0))));
  assign _zz_41[4 : 0] = (5'b00000);
  assign io_cpu_writeBack_data = ((stageB_request_forceUncachedAccess || stageB_mmuRsp_isIoAccess) ? io_mem_rsp_payload_data : way_dataReadRspTwo);
  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == (3'b111));
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @ (*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_59);
    if(loader_counter_willClear)begin
      loader_counter_valueNext = (3'b000);
    end
  end

  always @ (posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_used <= tagsWriteCmd_payload_data_used;
    tagsWriteLastCmd_payload_data_dirty <= tagsWriteCmd_payload_data_dirty;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if(tagsReadCmd_valid)begin
      way_tagReadRspOneAddress <= tagsReadCmd_payload;
    end
    if(_zz_5)begin
      _zz_6 <= tagsWriteCmd_valid;
    end
    if(_zz_5)begin
      _zz_7 <= tagsWriteCmd_payload_address;
    end
    if(_zz_5)begin
      _zz_8 <= tagsWriteCmd_payload_data_used;
      _zz_9 <= tagsWriteCmd_payload_data_dirty;
      _zz_10 <= tagsWriteCmd_payload_data_address;
    end
    if((dataReadCmd_valid && (! way_dataReadRspOneKeepAddress)))begin
      way_dataReadRspOneAddress <= dataReadCmd_payload;
    end
    if(_zz_13)begin
      _zz_14 <= dataWriteCmd_valid;
    end
    if(_zz_13)begin
      _zz_15 <= dataWriteCmd_payload_address;
    end
    if((_zz_12 && dataWriteCmd_payload_mask[0]))begin
      _zz_17[0] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_17[0] <= dataWriteCmd_payload_mask[0];
    end
    if((dataReadCmd_valid || (_zz_12 && dataWriteCmd_payload_mask[0])))begin
      _zz_16[7 : 0] <= dataWriteCmd_payload_data[7 : 0];
    end
    if((_zz_12 && dataWriteCmd_payload_mask[1]))begin
      _zz_17[1] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_17[1] <= dataWriteCmd_payload_mask[1];
    end
    if((dataReadCmd_valid || (_zz_12 && dataWriteCmd_payload_mask[1])))begin
      _zz_16[15 : 8] <= dataWriteCmd_payload_data[15 : 8];
    end
    if((_zz_12 && dataWriteCmd_payload_mask[2]))begin
      _zz_17[2] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_17[2] <= dataWriteCmd_payload_mask[2];
    end
    if((dataReadCmd_valid || (_zz_12 && dataWriteCmd_payload_mask[2])))begin
      _zz_16[23 : 16] <= dataWriteCmd_payload_data[23 : 16];
    end
    if((_zz_12 && dataWriteCmd_payload_mask[3]))begin
      _zz_17[3] <= 1'b1;
    end
    if(dataReadCmd_valid)begin
      _zz_17[3] <= dataWriteCmd_payload_mask[3];
    end
    if((dataReadCmd_valid || (_zz_12 && dataWriteCmd_payload_mask[3])))begin
      _zz_16[31 : 24] <= dataWriteCmd_payload_data[31 : 24];
    end
    if(way_tagReadRspTwoEnable)begin
      way_tagReadRspTwo_used <= way_tagReadRspTwoRegIn_used;
      way_tagReadRspTwo_dirty <= way_tagReadRspTwoRegIn_dirty;
      way_tagReadRspTwo_address <= way_tagReadRspTwoRegIn_address;
    end
    if(way_dataReadRspTwoEnable)begin
      _zz_20 <= way_dataReadRspOneAddress;
    end
    if((way_dataReadRspTwoEnable || (_zz_22 && dataWriteCmd_payload_mask[0])))begin
      _zz_23 <= (((! way_dataReadRspTwoEnable) || (_zz_21 && dataWriteCmd_payload_mask[0])) ? dataWriteCmd_payload_data[7 : 0] : way_dataReadRspOne[7 : 0]);
    end
    if((way_dataReadRspTwoEnable || (_zz_22 && dataWriteCmd_payload_mask[1])))begin
      _zz_24 <= (((! way_dataReadRspTwoEnable) || (_zz_21 && dataWriteCmd_payload_mask[1])) ? dataWriteCmd_payload_data[15 : 8] : way_dataReadRspOne[15 : 8]);
    end
    if((way_dataReadRspTwoEnable || (_zz_22 && dataWriteCmd_payload_mask[2])))begin
      _zz_25 <= (((! way_dataReadRspTwoEnable) || (_zz_21 && dataWriteCmd_payload_mask[2])) ? dataWriteCmd_payload_data[23 : 16] : way_dataReadRspOne[23 : 16]);
    end
    if((way_dataReadRspTwoEnable || (_zz_22 && dataWriteCmd_payload_mask[3])))begin
      _zz_26 <= (((! way_dataReadRspTwoEnable) || (_zz_21 && dataWriteCmd_payload_mask[3])) ? dataWriteCmd_payload_data[31 : 24] : way_dataReadRspOne[31 : 24]);
    end
    if(_zz_50)begin
      _zz_29 <= victim_requestIn_payload_address;
    end
    if(_zz_32)begin
      _zz_35 <= _zz_44;
    end
    if((! io_cpu_memory_isStuck))begin
      stageA_request_kind <= io_cpu_execute_args_kind;
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_address <= io_cpu_execute_args_address;
      stageA_request_data <= io_cpu_execute_args_data;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_forceUncachedAccess <= io_cpu_execute_args_forceUncachedAccess;
      stageA_request_clean <= io_cpu_execute_args_clean;
      stageA_request_invalidate <= io_cpu_execute_args_invalidate;
      stageA_request_way <= io_cpu_execute_args_way;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_request_kind <= stageA_request_kind;
      stageB_request_wr <= stageA_request_wr;
      stageB_request_address <= stageA_request_address;
      stageB_request_data <= stageA_request_data;
      stageB_request_size <= stageA_request_size;
      stageB_request_forceUncachedAccess <= stageA_request_forceUncachedAccess;
      stageB_request_clean <= stageA_request_clean;
      stageB_request_invalidate <= stageA_request_invalidate;
      stageB_request_way <= stageA_request_way;
    end
    if(_zz_46)begin
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuBus_rsp_isIoAccess;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuBus_rsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuBus_rsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuBus_rsp_allowExecute;
      stageB_mmuRsp_allowUser <= io_cpu_memory_mmuBus_rsp_allowUser;
      stageB_mmuRsp_miss <= io_cpu_memory_mmuBus_rsp_miss;
    end
    if((! io_cpu_writeBack_isStuck))begin
      stageB_waysHit <= (way_tagReadRspTwoRegIn_used && (io_cpu_memory_mmuBus_rsp_physicalAddress[31 : 12] == way_tagReadRspTwoRegIn_address));
    end
    stageB_delayedIsStuck <= io_cpu_writeBack_isStuck;
    stageB_delayedWaysHitValid <= stageB_waysHit;
    if (!(! ((io_cpu_writeBack_isValid && (! _zz_45)) && io_cpu_writeBack_isStuck))) begin
      $display("ERROR writeBack stuck by another plugin is not allowed");
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      _zz_27 <= 1'b0;
      _zz_28 <= 1'b1;
      victim_readLineCmdCounter <= (4'b0000);
      victim_dataReadRestored <= 1'b0;
      victim_readLineRspCounter <= (4'b0000);
      _zz_30 <= 1'b0;
      victim_bufferReadCounter <= (4'b0000);
      _zz_33 <= 1'b0;
      _zz_34 <= 1'b0;
      victim_bufferReadedCounter <= (3'b000);
      victim_counter_value <= (3'b000);
      stageB_loadingDone <= 1'b0;
      stageB_victimNotSent <= 1'b0;
      stageB_loadingNotDone <= 1'b0;
      stageB_hadMemRspErrorReg <= 1'b0;
      stageB_bootEvicts_valid <= 1'b1;
      stageB_mmuRsp_physicalAddress <= (32'b00000000000000000000000000000000);
      loader_valid <= 1'b0;
      loader_memCmdSent <= 1'b0;
      loader_counter_value <= (3'b000);
    end else begin
      if(_zz_50)begin
        _zz_27 <= victim_requestIn_valid;
        _zz_28 <= (! victim_requestIn_valid);
      end else begin
        _zz_27 <= (! victim_request_ready);
        _zz_28 <= victim_request_ready;
      end
      if(victim_request_valid)begin
        if(_zz_52)begin
          victim_readLineCmdCounter <= (victim_readLineCmdCounter + (4'b0001));
        end else begin
          victim_dataReadRestored <= 1'b1;
        end
      end
      if(victim_request_ready)begin
        victim_dataReadRestored <= 1'b0;
      end
      _zz_30 <= victim_dataReadCmdOccure;
      if(_zz_30)begin
        victim_readLineRspCounter <= (victim_readLineRspCounter + (4'b0001));
      end
      if((victim_bufferReadStream_valid && victim_bufferReadStream_ready))begin
        victim_bufferReadCounter <= (victim_bufferReadCounter + (4'b0001));
      end
      if(_zz_32)begin
        _zz_33 <= 1'b0;
      end
      if(victim_bufferReadStream_ready)begin
        _zz_33 <= victim_bufferReadStream_valid;
      end
      if(_zz_32)begin
        _zz_34 <= _zz_31;
      end
      if(victim_bufferReaded_valid)begin
        if(_zz_51)begin
          victim_bufferReadedCounter <= (victim_bufferReadedCounter + (3'b001));
        end
      end
      victim_counter_value <= victim_counter_valueNext;
      if(victim_request_ready)begin
        victim_readLineCmdCounter[3] <= 1'b0;
        victim_readLineRspCounter[3] <= 1'b0;
        victim_bufferReadCounter[3] <= 1'b0;
      end
      if(_zz_46)begin
        stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuBus_rsp_physicalAddress;
      end
      stageB_loadingDone <= (stageB_loaderValid && stageB_loaderReady);
      if(victim_requestIn_ready)begin
        stageB_victimNotSent <= 1'b0;
      end
      if((! io_cpu_memory_isStuck))begin
        stageB_victimNotSent <= 1'b1;
      end
      if(stageB_loaderReady)begin
        stageB_loadingNotDone <= 1'b0;
      end
      if((! io_cpu_memory_isStuck))begin
        stageB_loadingNotDone <= 1'b1;
      end
      stageB_hadMemRspErrorReg <= (stageB_hadMemRspError && _zz_45);
      if(stageB_bootEvicts_valid)begin
        if(_zz_48)begin
          stageB_mmuRsp_physicalAddress[11 : 5] <= (stageB_mmuRsp_physicalAddress[11 : 5] + (7'b0000001));
        end else begin
          stageB_bootEvicts_valid <= 1'b0;
        end
      end
      loader_valid <= stageB_loaderValid;
      if((loader_valid && io_mem_cmd_ready))begin
        loader_memCmdSent <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(loader_counter_willOverflow)begin
        loader_memCmdSent <= 1'b0;
        loader_valid <= 1'b0;
      end
    end
  end

  always @ (posedge clk) begin
    if(reset) begin
      _zz_40 <= 1'b0;
    end else begin
      if(_zz_47)begin
        if(_zz_49)begin
          if(io_mem_cmd_ready)begin
            _zz_40 <= 1'b1;
          end
        end
      end
      if((! io_cpu_writeBack_isStuck))begin
        _zz_40 <= 1'b0;
      end
    end
  end

endmodule

module VexRiscv (
      input  [31:0] externalResetVector,
      input   debug_bus_cmd_valid,
      output  debug_bus_cmd_ready,
      input   debug_bus_cmd_payload_wr,
      input  [7:0] debug_bus_cmd_payload_address,
      input  [31:0] debug_bus_cmd_payload_data,
      output reg [31:0] debug_bus_rsp_data,
      output  debug_resetOut,
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
      output [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset,
      input   debugReset);
  reg  _zz_280;
  wire  _zz_281;
  wire  _zz_282;
  wire  _zz_283;
  wire  _zz_284;
  wire  _zz_285;
  wire  _zz_286;
  wire  _zz_287;
  wire  _zz_288;
  wire  _zz_289;
  wire `DataCacheCpuCmdKind_binary_sequancial_type _zz_290;
  wire [31:0] _zz_291;
  wire  _zz_292;
  wire  _zz_293;
  wire  _zz_294;
  wire  _zz_295;
  wire  _zz_296;
  wire  _zz_297;
  wire  _zz_298;
  wire  _zz_299;
  wire  _zz_300;
  wire  _zz_301;
  wire  _zz_302;
  wire  _zz_303;
  wire  _zz_304;
  reg [31:0] _zz_305;
  reg [31:0] _zz_306;
  reg  _zz_307;
  reg  _zz_308;
  wire  _zz_309;
  reg [31:0] _zz_310;
  reg [3:0] _zz_311;
  reg [31:0] _zz_312;
  wire  _zz_313;
  wire  _zz_314;
  wire  _zz_315;
  wire [31:0] _zz_316;
  wire  _zz_317;
  wire [31:0] _zz_318;
  wire  _zz_319;
  wire  _zz_320;
  wire  _zz_321;
  wire  _zz_322;
  wire  _zz_323;
  wire  _zz_324;
  wire [31:0] _zz_325;
  wire [2:0] _zz_326;
  wire  _zz_327;
  wire  _zz_328;
  wire [31:0] _zz_329;
  wire  _zz_330;
  wire  _zz_331;
  wire [31:0] _zz_332;
  wire  _zz_333;
  wire  _zz_334;
  wire  _zz_335;
  wire  _zz_336;
  wire [31:0] _zz_337;
  wire  _zz_338;
  wire  _zz_339;
  wire [31:0] _zz_340;
  wire [31:0] _zz_341;
  wire [3:0] _zz_342;
  wire [2:0] _zz_343;
  wire  _zz_344;
  wire  _zz_345;
  wire  _zz_346;
  wire  _zz_347;
  wire  _zz_348;
  wire [0:0] _zz_349;
  wire  _zz_350;
  wire  _zz_351;
  wire  _zz_352;
  wire  _zz_353;
  wire  _zz_354;
  wire  _zz_355;
  wire [1:0] _zz_356;
  wire [1:0] _zz_357;
  wire [1:0] _zz_358;
  wire  _zz_359;
  wire [2:0] _zz_360;
  wire [31:0] _zz_361;
  wire [3:0] _zz_362;
  wire [2:0] _zz_363;
  wire [2:0] _zz_364;
  wire [0:0] _zz_365;
  wire [0:0] _zz_366;
  wire [0:0] _zz_367;
  wire [0:0] _zz_368;
  wire [0:0] _zz_369;
  wire [0:0] _zz_370;
  wire [0:0] _zz_371;
  wire [0:0] _zz_372;
  wire [0:0] _zz_373;
  wire [0:0] _zz_374;
  wire [0:0] _zz_375;
  wire [0:0] _zz_376;
  wire [0:0] _zz_377;
  wire [0:0] _zz_378;
  wire [0:0] _zz_379;
  wire [0:0] _zz_380;
  wire [0:0] _zz_381;
  wire [0:0] _zz_382;
  wire [11:0] _zz_383;
  wire [11:0] _zz_384;
  wire [31:0] _zz_385;
  wire [31:0] _zz_386;
  wire [31:0] _zz_387;
  wire [31:0] _zz_388;
  wire [1:0] _zz_389;
  wire [31:0] _zz_390;
  wire [1:0] _zz_391;
  wire [1:0] _zz_392;
  wire [32:0] _zz_393;
  wire [31:0] _zz_394;
  wire [32:0] _zz_395;
  wire [51:0] _zz_396;
  wire [51:0] _zz_397;
  wire [51:0] _zz_398;
  wire [32:0] _zz_399;
  wire [51:0] _zz_400;
  wire [49:0] _zz_401;
  wire [51:0] _zz_402;
  wire [49:0] _zz_403;
  wire [51:0] _zz_404;
  wire [65:0] _zz_405;
  wire [65:0] _zz_406;
  wire [31:0] _zz_407;
  wire [31:0] _zz_408;
  wire [0:0] _zz_409;
  wire [5:0] _zz_410;
  wire [32:0] _zz_411;
  wire [32:0] _zz_412;
  wire [31:0] _zz_413;
  wire [31:0] _zz_414;
  wire [32:0] _zz_415;
  wire [32:0] _zz_416;
  wire [32:0] _zz_417;
  wire [0:0] _zz_418;
  wire [32:0] _zz_419;
  wire [0:0] _zz_420;
  wire [32:0] _zz_421;
  wire [0:0] _zz_422;
  wire [31:0] _zz_423;
  wire [11:0] _zz_424;
  wire [31:0] _zz_425;
  wire [19:0] _zz_426;
  wire [11:0] _zz_427;
  wire [11:0] _zz_428;
  wire [11:0] _zz_429;
  wire [2:0] _zz_430;
  wire [2:0] _zz_431;
  wire [3:0] _zz_432;
  wire [4:0] _zz_433;
  wire [31:0] _zz_434;
  wire [0:0] _zz_435;
  wire [0:0] _zz_436;
  wire [0:0] _zz_437;
  wire [0:0] _zz_438;
  wire [0:0] _zz_439;
  wire [0:0] _zz_440;
  wire [26:0] _zz_441;
  wire [1:0] _zz_442;
  wire  _zz_443;
  wire [0:0] _zz_444;
  wire [2:0] _zz_445;
  wire [0:0] _zz_446;
  wire [1:0] _zz_447;
  wire [0:0] _zz_448;
  wire [2:0] _zz_449;
  wire [0:0] _zz_450;
  wire [0:0] _zz_451;
  wire  _zz_452;
  wire [0:0] _zz_453;
  wire [24:0] _zz_454;
  wire [31:0] _zz_455;
  wire [31:0] _zz_456;
  wire [31:0] _zz_457;
  wire  _zz_458;
  wire [0:0] _zz_459;
  wire [0:0] _zz_460;
  wire  _zz_461;
  wire  _zz_462;
  wire [0:0] _zz_463;
  wire [0:0] _zz_464;
  wire [0:0] _zz_465;
  wire [0:0] _zz_466;
  wire [1:0] _zz_467;
  wire [1:0] _zz_468;
  wire  _zz_469;
  wire [0:0] _zz_470;
  wire [22:0] _zz_471;
  wire [31:0] _zz_472;
  wire [31:0] _zz_473;
  wire [31:0] _zz_474;
  wire [31:0] _zz_475;
  wire [31:0] _zz_476;
  wire [31:0] _zz_477;
  wire [31:0] _zz_478;
  wire  _zz_479;
  wire  _zz_480;
  wire [0:0] _zz_481;
  wire [1:0] _zz_482;
  wire [2:0] _zz_483;
  wire [2:0] _zz_484;
  wire  _zz_485;
  wire [0:0] _zz_486;
  wire [20:0] _zz_487;
  wire [31:0] _zz_488;
  wire [31:0] _zz_489;
  wire [31:0] _zz_490;
  wire [31:0] _zz_491;
  wire  _zz_492;
  wire  _zz_493;
  wire  _zz_494;
  wire [0:0] _zz_495;
  wire [0:0] _zz_496;
  wire [0:0] _zz_497;
  wire [0:0] _zz_498;
  wire [0:0] _zz_499;
  wire [0:0] _zz_500;
  wire  _zz_501;
  wire [0:0] _zz_502;
  wire [18:0] _zz_503;
  wire [31:0] _zz_504;
  wire [31:0] _zz_505;
  wire [31:0] _zz_506;
  wire [31:0] _zz_507;
  wire [31:0] _zz_508;
  wire [1:0] _zz_509;
  wire [1:0] _zz_510;
  wire  _zz_511;
  wire [0:0] _zz_512;
  wire [15:0] _zz_513;
  wire [31:0] _zz_514;
  wire [31:0] _zz_515;
  wire [31:0] _zz_516;
  wire [31:0] _zz_517;
  wire [31:0] _zz_518;
  wire [1:0] _zz_519;
  wire [1:0] _zz_520;
  wire  _zz_521;
  wire [0:0] _zz_522;
  wire [11:0] _zz_523;
  wire [31:0] _zz_524;
  wire [31:0] _zz_525;
  wire [31:0] _zz_526;
  wire [0:0] _zz_527;
  wire [2:0] _zz_528;
  wire  _zz_529;
  wire [1:0] _zz_530;
  wire [1:0] _zz_531;
  wire  _zz_532;
  wire [0:0] _zz_533;
  wire [7:0] _zz_534;
  wire [31:0] _zz_535;
  wire [31:0] _zz_536;
  wire  _zz_537;
  wire  _zz_538;
  wire [31:0] _zz_539;
  wire [31:0] _zz_540;
  wire [31:0] _zz_541;
  wire [31:0] _zz_542;
  wire  _zz_543;
  wire [1:0] _zz_544;
  wire [1:0] _zz_545;
  wire  _zz_546;
  wire [0:0] _zz_547;
  wire [4:0] _zz_548;
  wire [31:0] _zz_549;
  wire [31:0] _zz_550;
  wire  _zz_551;
  wire [0:0] _zz_552;
  wire [0:0] _zz_553;
  wire [0:0] _zz_554;
  wire [0:0] _zz_555;
  wire  _zz_556;
  wire [0:0] _zz_557;
  wire [1:0] _zz_558;
  wire [31:0] _zz_559;
  wire  _zz_560;
  wire [0:0] _zz_561;
  wire [0:0] _zz_562;
  wire [0:0] _zz_563;
  wire [4:0] _zz_564;
  wire [0:0] _zz_565;
  wire [3:0] _zz_566;
  wire [31:0] _zz_567;
  wire [31:0] _zz_568;
  wire  _zz_569;
  wire [0:0] _zz_570;
  wire [1:0] _zz_571;
  wire [31:0] _zz_572;
  wire [31:0] _zz_573;
  wire [31:0] _zz_574;
  wire [0:0] _zz_575;
  wire [0:0] _zz_576;
  wire [31:0] _zz_577;
  wire [31:0] _zz_578;
  wire [31:0] _zz_579;
  wire  _zz_580;
  wire [0:0] _zz_581;
  wire [12:0] _zz_582;
  wire [31:0] _zz_583;
  wire [31:0] _zz_584;
  wire [31:0] _zz_585;
  wire  _zz_586;
  wire [0:0] _zz_587;
  wire [6:0] _zz_588;
  wire [31:0] _zz_589;
  wire [31:0] _zz_590;
  wire [31:0] _zz_591;
  wire  _zz_592;
  wire [0:0] _zz_593;
  wire [0:0] _zz_594;
  wire [0:0] _zz_595;
  wire [7:0] _zz_596;
  wire  _zz_597;
  wire [0:0] _zz_598;
  wire [0:0] _zz_599;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_2;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_3;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire  decode_IS_EBREAK;
  wire  decode_SRC_USE_SUB_LESS;
  wire [31:0] memory_PC;
  wire [31:0] fetch_PC;
  wire  decode_IS_RS2_SIGNED;
  wire  decode_CSR_READ_OPCODE;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_4;
  wire `AluCtrlEnum_binary_sequancial_type _zz_5;
  wire `AluCtrlEnum_binary_sequancial_type _zz_6;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_7;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_8;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_9;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_10;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_11;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_12;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_13;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_14;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_15;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_16;
  wire [33:0] execute_MUL_LH;
  wire  execute_INSTRUCTION_READY;
  wire  decode_CSR_WRITE_OPCODE;
  wire `EnvCtrlEnum_binary_sequancial_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_17;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_18;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_19;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_20;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_21;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_22;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire [31:0] fetch_FORMAL_PC_NEXT;
  wire [31:0] prefetch_FORMAL_PC_NEXT;
  wire  decode_MEMORY_MANAGMENT;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire [31:0] fetch_INSTRUCTION;
  wire [33:0] execute_MUL_HL;
  wire  decode_IS_DIV;
  wire [31:0] execute_SHIFT_RIGHT;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire [51:0] memory_MUL_LOW;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire  decode_MEMORY_ENABLE;
  wire [31:0] execute_MUL_LL;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  decode_IS_RS1_SIGNED;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire  execute_BRANCH_DO;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_23;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_24;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_25;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  execute_IS_CSR;
  wire  decode_IS_CSR;
  wire  _zz_26;
  wire  _zz_27;
  wire `EnvCtrlEnum_binary_sequancial_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_28;
  wire  memory_INSTRUCTION_READY;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_29;
  wire [31:0] execute_PC;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_30;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_31;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_32;
  wire  _zz_33;
  wire  execute_IS_EBREAK;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_34;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  wire  execute_IS_RS1_SIGNED;
  wire [31:0] execute_RS1;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_35;
  wire [33:0] _zz_36;
  wire [33:0] _zz_37;
  wire [33:0] _zz_38;
  wire [31:0] _zz_39;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_40;
  wire `ShiftCtrlEnum_binary_sequancial_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_41;
  wire [31:0] _zz_42;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_43;
  wire  _zz_44;
  wire [31:0] _zz_45;
  wire [31:0] _zz_46;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_47;
  wire `Src2CtrlEnum_binary_sequancial_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_48;
  wire [31:0] _zz_49;
  wire `Src1CtrlEnum_binary_sequancial_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_50;
  wire [31:0] _zz_51;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_52;
  wire [31:0] _zz_53;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_54;
  wire [31:0] _zz_55;
  wire  _zz_56;
  reg  _zz_57;
  wire [31:0] _zz_58;
  wire [31:0] _zz_59;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire  _zz_60;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_61;
  wire  _zz_62;
  wire  _zz_63;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_64;
  wire  _zz_65;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_66;
  wire  _zz_67;
  wire  _zz_68;
  wire  _zz_69;
  wire  _zz_70;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_71;
  wire `AluCtrlEnum_binary_sequancial_type _zz_72;
  wire  _zz_73;
  wire  _zz_74;
  wire  _zz_75;
  wire  _zz_76;
  wire  _zz_77;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_78;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_79;
  wire  _zz_80;
  wire  _zz_81;
  wire  _zz_82;
  wire  _zz_83;
  wire  _zz_84;
  reg [31:0] _zz_85;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire  writeBack_MEMORY_ENABLE;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_86;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_WR;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  memory_FLUSH_ALL;
  wire [31:0] _zz_87;
  wire  _zz_88;
  wire [31:0] _zz_89;
  wire [31:0] _zz_90;
  wire [31:0] _zz_91;
  wire [31:0] _zz_92;
  wire [31:0] _zz_93;
  reg [31:0] _zz_94;
  reg [31:0] _zz_95;
  wire [31:0] prefetch_PC;
  wire [31:0] _zz_96;
  wire [31:0] _zz_97;
  wire [31:0] prefetch_PC_CALC_WITHOUT_JUMP;
  wire [31:0] _zz_98;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  wire [31:0] decode_INSTRUCTION /* verilator public */ ;
  reg  prefetch_arbitration_haltItself;
  reg  prefetch_arbitration_haltByOther;
  wire  prefetch_arbitration_removeIt;
  wire  prefetch_arbitration_flushAll;
  wire  prefetch_arbitration_redoIt;
  reg  prefetch_arbitration_isValid;
  wire  prefetch_arbitration_isStuck;
  wire  prefetch_arbitration_isStuckByOthers;
  wire  prefetch_arbitration_isFlushed;
  wire  prefetch_arbitration_isMoving;
  wire  prefetch_arbitration_isFiring;
  wire  fetch_arbitration_haltItself;
  wire  fetch_arbitration_haltByOther;
  reg  fetch_arbitration_removeIt;
  reg  fetch_arbitration_flushAll;
  wire  fetch_arbitration_redoIt;
  reg  fetch_arbitration_isValid;
  wire  fetch_arbitration_isStuck;
  wire  fetch_arbitration_isStuckByOthers;
  wire  fetch_arbitration_isFlushed;
  wire  fetch_arbitration_isMoving;
  wire  fetch_arbitration_isFiring;
  reg  decode_arbitration_haltItself /* verilator public */ ;
  wire  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  reg  decode_arbitration_flushAll /* verilator public */ ;
  reg  decode_arbitration_redoIt;
  reg  decode_arbitration_isValid /* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  wire  execute_arbitration_haltByOther;
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
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  reg  memory_arbitration_flushAll;
  wire  memory_arbitration_redoIt;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  reg  writeBack_arbitration_haltItself;
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
  wire  _zz_99;
  wire [31:0] _zz_100;
  wire  _zz_101;
  wire [31:0] _zz_102;
  wire [31:0] _zz_103;
  reg [3:0] _zz_104;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  _zz_105;
  wire [31:0] _zz_106;
  wire  _zz_107;
  wire [31:0] _zz_108;
  wire  _zz_109;
  reg  _zz_110;
  reg [31:0] _zz_111;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_112;
  reg  _zz_113;
  reg  _zz_114;
  reg [31:0] prefetch_PcManagerSimplePlugin_pcReg /* verilator public */ ;
  reg  prefetch_PcManagerSimplePlugin_inc;
  wire [31:0] prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  reg [31:0] prefetch_PcManagerSimplePlugin_pc;
  reg  prefetch_PcManagerSimplePlugin_samplePcNext;
  wire  prefetch_PcManagerSimplePlugin_jump_pcLoad_valid;
  wire [31:0] prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
  wire [3:0] _zz_115;
  wire [3:0] _zz_116;
  wire  _zz_117;
  wire  _zz_118;
  wire  _zz_119;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  _zz_120;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [3:0] dBus_cmd_payload_mask;
  wire [2:0] dBus_cmd_payload_length;
  wire  dBus_cmd_payload_last;
  wire  dBus_rsp_valid;
  wire [31:0] dBus_rsp_payload_data;
  wire  dBus_rsp_payload_error;
  wire [1:0] execute_DBusCachedPlugin_size;
  reg [31:0] _zz_121;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_122;
  reg [31:0] _zz_123;
  wire  _zz_124;
  reg [31:0] _zz_125;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  wire [30:0] _zz_126;
  wire  _zz_127;
  wire  _zz_128;
  wire  _zz_129;
  wire  _zz_130;
  wire  _zz_131;
  wire  _zz_132;
  wire  _zz_133;
  wire  _zz_134;
  wire  _zz_135;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_136;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_137;
  wire `AluCtrlEnum_binary_sequancial_type _zz_138;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_139;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_140;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_141;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_142;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_143;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_144;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_145;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_146;
  reg [31:0] _zz_147;
  wire  _zz_148;
  reg [19:0] _zz_149;
  wire  _zz_150;
  reg [19:0] _zz_151;
  reg [31:0] _zz_152;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrielShifterPlugin_amplitude;
  reg [31:0] _zz_153;
  wire [31:0] execute_FullBarrielShifterPlugin_reversed;
  reg [31:0] _zz_154;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [32:0] memory_DivPlugin_rs1;
  reg [31:0] memory_DivPlugin_rs2;
  reg [64:0] memory_DivPlugin_accumulator;
  reg  memory_DivPlugin_div_needRevert;
  reg  memory_DivPlugin_div_counter_willIncrement;
  reg  memory_DivPlugin_div_counter_willClear;
  reg [5:0] memory_DivPlugin_div_counter_valueNext;
  reg [5:0] memory_DivPlugin_div_counter_value;
  wire  memory_DivPlugin_div_done;
  wire  memory_DivPlugin_div_counter_willOverflow;
  reg [31:0] memory_DivPlugin_div_result;
  wire [31:0] _zz_155;
  wire [32:0] _zz_156;
  wire [32:0] _zz_157;
  wire [31:0] _zz_158;
  wire  _zz_159;
  wire  _zz_160;
  reg [32:0] _zz_161;
  reg  _zz_162;
  reg  _zz_163;
  reg  _zz_164;
  reg [4:0] _zz_165;
  reg [31:0] _zz_166;
  wire  _zz_167;
  wire  _zz_168;
  wire  _zz_169;
  wire  _zz_170;
  wire  _zz_171;
  wire  _zz_172;
  wire  _zz_173;
  reg  DebugPlugin_insertDecodeInstruction;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipActive;
  reg  _zz_174;
  wire  DebugPlugin_isPipBusy;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_175;
  reg  _zz_176;
  reg  _zz_177;
  wire  _zz_178;
  reg [18:0] _zz_179;
  wire  decode_BranchPlugin_conditionalBranchPrediction;
  wire  _zz_180;
  reg [10:0] _zz_181;
  wire  _zz_182;
  reg [18:0] _zz_183;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_184;
  reg  _zz_185;
  reg  _zz_186;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_187;
  reg [19:0] _zz_188;
  wire  _zz_189;
  reg [18:0] _zz_190;
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
  reg [63:0] CsrPlugin_mcycle = 64'b0010011111100000101101011000101111100110100000001100100100101010;
  reg [63:0] CsrPlugin_minstret = 64'b0010101101011101110000111000001101011111011001101001010000100100;
  reg  CsrPlugin_pipelineLiberator_enable;
  wire  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValids_0;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValids_1;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_2;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_3;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_4;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_5;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_0;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_1;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_2;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_3;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_4;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_5;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire  CsrPlugin_exceptionPortCtrl_pipelineHasException;
  wire [2:0] _zz_191;
  wire [2:0] _zz_192;
  wire  _zz_193;
  wire  _zz_194;
  wire [1:0] _zz_195;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_writeBackWasWfi;
  reg [31:0] _zz_196;
  reg  _zz_197;
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
  reg [31:0] _zz_198;
  reg [31:0] _zz_199;
  wire [31:0] _zz_200;
  reg `Src1CtrlEnum_binary_sequancial_type _zz_201;
  reg  _zz_202;
  reg [1:0] _zz_203;
  reg [1:0] _zz_204;
  reg  _zz_205;
  reg  _zz_206;
  reg  _zz_207;
  reg  _zz_208;
  reg  _zz_209;
  reg  _zz_210;
  reg [31:0] _zz_211;
  reg  _zz_212;
  reg  _zz_213;
  reg  _zz_214;
  reg  _zz_215;
  reg  _zz_216;
  reg  _zz_217;
  reg [51:0] _zz_218;
  reg [31:0] _zz_219;
  reg  _zz_220;
  reg [31:0] _zz_221;
  reg  _zz_222;
  reg  _zz_223;
  reg [33:0] _zz_224;
  reg [31:0] _zz_225;
  reg [31:0] _zz_226;
  reg [31:0] _zz_227;
  reg [31:0] _zz_228;
  reg [33:0] _zz_229;
  reg [33:0] _zz_230;
  reg  _zz_231;
  reg  _zz_232;
  reg  _zz_233;
  reg  _zz_234;
  reg  _zz_235;
  reg [31:0] _zz_236;
  reg [31:0] _zz_237;
  reg [31:0] _zz_238;
  reg [31:0] _zz_239;
  reg `EnvCtrlEnum_binary_sequancial_type _zz_240;
  reg `EnvCtrlEnum_binary_sequancial_type _zz_241;
  reg  _zz_242;
  reg  _zz_243;
  reg  _zz_244;
  reg [33:0] _zz_245;
  reg `BranchCtrlEnum_binary_sequancial_type _zz_246;
  reg `ShiftCtrlEnum_binary_sequancial_type _zz_247;
  reg `ShiftCtrlEnum_binary_sequancial_type _zz_248;
  reg `Src2CtrlEnum_binary_sequancial_type _zz_249;
  reg `AluCtrlEnum_binary_sequancial_type _zz_250;
  reg  _zz_251;
  reg [31:0] _zz_252;
  reg  _zz_253;
  reg [31:0] _zz_254;
  reg [31:0] _zz_255;
  reg [31:0] _zz_256;
  reg [31:0] _zz_257;
  reg [31:0] _zz_258;
  reg  _zz_259;
  reg  _zz_260;
  reg  _zz_261;
  reg  _zz_262;
  reg  _zz_263;
  reg  _zz_264;
  reg [31:0] _zz_265;
  reg [31:0] _zz_266;
  reg [31:0] _zz_267;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type _zz_268;
  reg [2:0] _zz_269;
  reg  _zz_270;
  reg [31:0] _zz_271;
  reg [2:0] _zz_272;
  wire  _zz_273;
  wire  _zz_274;
  wire  _zz_275;
  wire  _zz_276;
  wire  _zz_277;
  reg  _zz_278;
  reg [31:0] _zz_279;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign debug_bus_cmd_ready = _zz_307;
  assign iBusWishbone_CYC = _zz_308;
  assign dBusWishbone_WE = _zz_309;
  assign _zz_345 = ((_zz_101 || decodeExceptionPort_valid) || _zz_109);
  assign _zz_346 = (execute_arbitration_isFiring && execute_IS_EBREAK);
  assign _zz_347 = (! memory_arbitration_isStuck);
  assign _zz_348 = (((memory_INSTRUCTION_READY && memory_arbitration_isValid) && memory_BRANCH_DO) && (_zz_106[1 : 0] != (2'b00)));
  assign _zz_349 = debug_bus_cmd_payload_address[2 : 2];
  assign _zz_350 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_351 = (memory_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET);
  assign _zz_352 = (! memory_DivPlugin_div_done);
  assign _zz_353 = (CsrPlugin_exception || (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done));
  assign _zz_354 = (((_zz_333 || _zz_336) || _zz_334) || _zz_335);
  assign _zz_355 = (iBus_cmd_valid || (_zz_269 != (3'b000)));
  assign _zz_356 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_357 = execute_INSTRUCTION[13 : 12];
  assign _zz_358 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_359 = execute_INSTRUCTION[13];
  assign _zz_360 = {prefetch_PcManagerSimplePlugin_inc,(2'b00)};
  assign _zz_361 = {29'd0, _zz_360};
  assign _zz_362 = (_zz_115 - (4'b0001));
  assign _zz_363 = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_364 = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_365 = _zz_126[0 : 0];
  assign _zz_366 = _zz_126[1 : 1];
  assign _zz_367 = _zz_126[2 : 2];
  assign _zz_368 = _zz_126[3 : 3];
  assign _zz_369 = _zz_126[8 : 8];
  assign _zz_370 = _zz_126[9 : 9];
  assign _zz_371 = _zz_126[10 : 10];
  assign _zz_372 = _zz_126[11 : 11];
  assign _zz_373 = _zz_126[12 : 12];
  assign _zz_374 = _zz_126[17 : 17];
  assign _zz_375 = _zz_126[18 : 18];
  assign _zz_376 = _zz_126[19 : 19];
  assign _zz_377 = _zz_126[20 : 20];
  assign _zz_378 = _zz_126[23 : 23];
  assign _zz_379 = _zz_126[26 : 26];
  assign _zz_380 = _zz_126[27 : 27];
  assign _zz_381 = _zz_126[30 : 30];
  assign _zz_382 = execute_SRC_LESS;
  assign _zz_383 = execute_INSTRUCTION[31 : 20];
  assign _zz_384 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_385 = ($signed(_zz_386) + $signed(_zz_390));
  assign _zz_386 = ($signed(_zz_387) + $signed(_zz_388));
  assign _zz_387 = execute_SRC1;
  assign _zz_388 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_389 = (execute_SRC_USE_SUB_LESS ? _zz_391 : _zz_392);
  assign _zz_390 = {{30{_zz_389[1]}}, _zz_389};
  assign _zz_391 = (2'b01);
  assign _zz_392 = (2'b00);
  assign _zz_393 = ($signed(_zz_395) >>> execute_FullBarrielShifterPlugin_amplitude);
  assign _zz_394 = _zz_393[31 : 0];
  assign _zz_395 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_FullBarrielShifterPlugin_reversed[31]),execute_FullBarrielShifterPlugin_reversed};
  assign _zz_396 = ($signed(_zz_397) + $signed(_zz_402));
  assign _zz_397 = ($signed(_zz_398) + $signed(_zz_400));
  assign _zz_398 = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_399 = {1'b0,memory_MUL_LL};
  assign _zz_400 = {{19{_zz_399[32]}}, _zz_399};
  assign _zz_401 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_402 = {{2{_zz_401[49]}}, _zz_401};
  assign _zz_403 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_404 = {{2{_zz_403[49]}}, _zz_403};
  assign _zz_405 = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_406 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_407 = writeBack_MUL_LOW[31 : 0];
  assign _zz_408 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_409 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_410 = {5'd0, _zz_409};
  assign _zz_411 = {1'd0, memory_DivPlugin_rs2};
  assign _zz_412 = {_zz_155,(! _zz_157[32])};
  assign _zz_413 = _zz_157[31:0];
  assign _zz_414 = _zz_156[31:0];
  assign _zz_415 = _zz_416;
  assign _zz_416 = _zz_417;
  assign _zz_417 = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_158) : _zz_158)} + _zz_419);
  assign _zz_418 = memory_DivPlugin_div_needRevert;
  assign _zz_419 = {32'd0, _zz_418};
  assign _zz_420 = _zz_160;
  assign _zz_421 = {32'd0, _zz_420};
  assign _zz_422 = _zz_159;
  assign _zz_423 = {31'd0, _zz_422};
  assign _zz_424 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_425 = {{_zz_179,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_426 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_427 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_428 = execute_INSTRUCTION[31 : 20];
  assign _zz_429 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_430 = (_zz_191 - (3'b001));
  assign _zz_431 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_432 = {1'd0, _zz_431};
  assign _zz_433 = execute_INSTRUCTION[19 : 15];
  assign _zz_434 = {27'd0, _zz_433};
  assign _zz_435 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_436 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_437 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_438 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_439 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_440 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_441 = (iBus_cmd_payload_address >>> 5);
  assign _zz_442 = {_zz_119,_zz_118};
  assign _zz_443 = ((decode_INSTRUCTION & _zz_455) == (32'b00000000000000000001000000010000));
  assign _zz_444 = (_zz_456 == _zz_457);
  assign _zz_445 = {_zz_458,{_zz_459,_zz_460}};
  assign _zz_446 = _zz_131;
  assign _zz_447 = {_zz_461,_zz_462};
  assign _zz_448 = _zz_135;
  assign _zz_449 = {_zz_131,{_zz_463,_zz_464}};
  assign _zz_450 = _zz_132;
  assign _zz_451 = (1'b0);
  assign _zz_452 = ({_zz_465,_zz_466} != (2'b00));
  assign _zz_453 = (_zz_467 != _zz_468);
  assign _zz_454 = {_zz_469,{_zz_470,_zz_471}};
  assign _zz_455 = (32'b00000000000000000001000000010000);
  assign _zz_456 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_457 = (32'b00000000000000000010000000010000);
  assign _zz_458 = ((decode_INSTRUCTION & _zz_472) == (32'b00000000000000000000000000010000));
  assign _zz_459 = _zz_134;
  assign _zz_460 = _zz_133;
  assign _zz_461 = ((decode_INSTRUCTION & _zz_473) == (32'b00000000000000000000000000000100));
  assign _zz_462 = ((decode_INSTRUCTION & _zz_474) == (32'b00000000000000000000000000100000));
  assign _zz_463 = _zz_134;
  assign _zz_464 = _zz_133;
  assign _zz_465 = (_zz_475 == _zz_476);
  assign _zz_466 = (_zz_477 == _zz_478);
  assign _zz_467 = {_zz_479,_zz_480};
  assign _zz_468 = (2'b00);
  assign _zz_469 = ({_zz_481,_zz_482} != (3'b000));
  assign _zz_470 = (_zz_483 != _zz_484);
  assign _zz_471 = {_zz_485,{_zz_486,_zz_487}};
  assign _zz_472 = (32'b00000000000000000000000001010000);
  assign _zz_473 = (32'b00000000000000000000000000001100);
  assign _zz_474 = (32'b00000000000000000000000001110000);
  assign _zz_475 = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_476 = (32'b00000000000000000001000001010000);
  assign _zz_477 = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_478 = (32'b00000000000000000010000001010000);
  assign _zz_479 = ((decode_INSTRUCTION & _zz_488) == (32'b00000000000000000101000000010000));
  assign _zz_480 = ((decode_INSTRUCTION & _zz_489) == (32'b00000000000000000101000000100000));
  assign _zz_481 = (_zz_490 == _zz_491);
  assign _zz_482 = {_zz_492,_zz_493};
  assign _zz_483 = {_zz_494,{_zz_495,_zz_496}};
  assign _zz_484 = (3'b000);
  assign _zz_485 = ({_zz_497,_zz_498} != (2'b00));
  assign _zz_486 = (_zz_499 != _zz_500);
  assign _zz_487 = {_zz_501,{_zz_502,_zz_503}};
  assign _zz_488 = (32'b00000000000000000111000000110100);
  assign _zz_489 = (32'b00000010000000000111000001100100);
  assign _zz_490 = (decode_INSTRUCTION & (32'b01000000000000000011000001010100));
  assign _zz_491 = (32'b01000000000000000001000000010000);
  assign _zz_492 = ((decode_INSTRUCTION & (32'b00000000000000000111000000110100)) == (32'b00000000000000000001000000010000));
  assign _zz_493 = ((decode_INSTRUCTION & (32'b00000010000000000111000001010100)) == (32'b00000000000000000001000000010000));
  assign _zz_494 = ((decode_INSTRUCTION & (32'b00000000000000000001000001001000)) == (32'b00000000000000000001000000001000));
  assign _zz_495 = ((decode_INSTRUCTION & _zz_504) == (32'b00000000000000000000000000100000));
  assign _zz_496 = ((decode_INSTRUCTION & _zz_505) == (32'b00000000000000000000000000100000));
  assign _zz_497 = _zz_131;
  assign _zz_498 = _zz_130;
  assign _zz_499 = ((decode_INSTRUCTION & _zz_506) == (32'b00000000000000000000000001000000));
  assign _zz_500 = (1'b0);
  assign _zz_501 = ((_zz_507 == _zz_508) != (1'b0));
  assign _zz_502 = (_zz_132 != (1'b0));
  assign _zz_503 = {(_zz_509 != _zz_510),{_zz_511,{_zz_512,_zz_513}}};
  assign _zz_504 = (32'b00000000000000000000000000110100);
  assign _zz_505 = (32'b00000000000000000000000001100100);
  assign _zz_506 = (32'b00000000000000000000000001011000);
  assign _zz_507 = (decode_INSTRUCTION & (32'b00000000000000000001000001001000));
  assign _zz_508 = (32'b00000000000000000000000000001000);
  assign _zz_509 = {((decode_INSTRUCTION & _zz_514) == (32'b00000000000000000010000000000000)),((decode_INSTRUCTION & _zz_515) == (32'b00000000000000000001000000000000))};
  assign _zz_510 = (2'b00);
  assign _zz_511 = (((decode_INSTRUCTION & _zz_516) == (32'b00000000000000000000000000100000)) != (1'b0));
  assign _zz_512 = ((_zz_517 == _zz_518) != (1'b0));
  assign _zz_513 = {1'b0,{(_zz_519 != _zz_520),{_zz_521,{_zz_522,_zz_523}}}};
  assign _zz_514 = (32'b00000000000000000010000000010000);
  assign _zz_515 = (32'b00000000000000000101000000000000);
  assign _zz_516 = (32'b00000000000000000000000000100000);
  assign _zz_517 = (decode_INSTRUCTION & (32'b00000000000100000011000001010000));
  assign _zz_518 = (32'b00000000000000000000000001010000);
  assign _zz_519 = {((decode_INSTRUCTION & _zz_524) == (32'b00000000000000000000000000100100)),((decode_INSTRUCTION & _zz_525) == (32'b00000000000000000100000000010000))};
  assign _zz_520 = (2'b00);
  assign _zz_521 = (((decode_INSTRUCTION & _zz_526) == (32'b00000000000000000010000000010000)) != (1'b0));
  assign _zz_522 = ({_zz_129,{_zz_527,_zz_528}} != (5'b00000));
  assign _zz_523 = {(_zz_529 != (1'b0)),{(_zz_530 != _zz_531),{_zz_532,{_zz_533,_zz_534}}}};
  assign _zz_524 = (32'b00000000000000000000000001100100);
  assign _zz_525 = (32'b00000000000000000100000000010100);
  assign _zz_526 = (32'b00000000000000000110000000010100);
  assign _zz_527 = _zz_128;
  assign _zz_528 = {(_zz_535 == _zz_536),{_zz_537,_zz_538}};
  assign _zz_529 = ((decode_INSTRUCTION & (32'b00000000000000000000000000001000)) == (32'b00000000000000000000000000001000));
  assign _zz_530 = {_zz_127,(_zz_539 == _zz_540)};
  assign _zz_531 = (2'b00);
  assign _zz_532 = ((_zz_541 == _zz_542) != (1'b0));
  assign _zz_533 = (_zz_543 != (1'b0));
  assign _zz_534 = {(_zz_544 != _zz_545),{_zz_546,{_zz_547,_zz_548}}};
  assign _zz_535 = (decode_INSTRUCTION & (32'b00000000000000000100000000100000));
  assign _zz_536 = (32'b00000000000000000100000000100000);
  assign _zz_537 = ((decode_INSTRUCTION & (32'b00000000000000000000000000110000)) == (32'b00000000000000000000000000010000));
  assign _zz_538 = ((decode_INSTRUCTION & (32'b00000010000000000000000000100000)) == (32'b00000000000000000000000000100000));
  assign _zz_539 = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_540 = (32'b00000000000000000000000000000000);
  assign _zz_541 = (decode_INSTRUCTION & (32'b00100000000000000011000001010000));
  assign _zz_542 = (32'b00000000000000000000000001010000);
  assign _zz_543 = ((decode_INSTRUCTION & (32'b00000010000000000100000001100100)) == (32'b00000010000000000100000000100000));
  assign _zz_544 = {(_zz_549 == _zz_550),_zz_128};
  assign _zz_545 = (2'b00);
  assign _zz_546 = ({_zz_128,_zz_551} != (2'b00));
  assign _zz_547 = ({_zz_552,_zz_553} != (2'b00));
  assign _zz_548 = {(_zz_554 != _zz_555),{_zz_556,{_zz_557,_zz_558}}};
  assign _zz_549 = (decode_INSTRUCTION & (32'b00000000000000000001000000000000));
  assign _zz_550 = (32'b00000000000000000001000000000000);
  assign _zz_551 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_552 = _zz_131;
  assign _zz_553 = _zz_130;
  assign _zz_554 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001100)) == (32'b00000000000000000000000000000100));
  assign _zz_555 = (1'b0);
  assign _zz_556 = (((decode_INSTRUCTION & _zz_559) == (32'b00000010000000000000000000110000)) != (1'b0));
  assign _zz_557 = ({_zz_560,{_zz_561,_zz_562}} != (3'b000));
  assign _zz_558 = {({_zz_563,_zz_564} != (6'b000000)),({_zz_565,_zz_566} != (5'b00000))};
  assign _zz_559 = (32'b00000010000000000100000001110100);
  assign _zz_560 = ((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000));
  assign _zz_561 = ((decode_INSTRUCTION & _zz_567) == (32'b00000000000000000010000000010000));
  assign _zz_562 = ((decode_INSTRUCTION & _zz_568) == (32'b00000000000000000000000001000000));
  assign _zz_563 = _zz_129;
  assign _zz_564 = {_zz_128,{_zz_569,{_zz_570,_zz_571}}};
  assign _zz_565 = ((decode_INSTRUCTION & _zz_572) == (32'b00000000000000000000000000000000));
  assign _zz_566 = {(_zz_573 == _zz_574),{_zz_127,{_zz_575,_zz_576}}};
  assign _zz_567 = (32'b00000000000000000010000000010100);
  assign _zz_568 = (32'b00000000000000000000000001010100);
  assign _zz_569 = ((decode_INSTRUCTION & (32'b00000000000000000010000000110000)) == (32'b00000000000000000010000000010000));
  assign _zz_570 = ((decode_INSTRUCTION & (32'b00000010000000000010000000100000)) == (32'b00000000000000000010000000100000));
  assign _zz_571 = {((decode_INSTRUCTION & (32'b00000010000000000001000000100000)) == (32'b00000000000000000000000000100000)),((decode_INSTRUCTION & (32'b00000000000000000001000000110000)) == (32'b00000000000000000000000000010000))};
  assign _zz_572 = (32'b00000000000000000000000001000100);
  assign _zz_573 = (decode_INSTRUCTION & (32'b00000000000000000000000000011000));
  assign _zz_574 = (32'b00000000000000000000000000000000);
  assign _zz_575 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_576 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_577 = (32'b00000000000000000001000001111111);
  assign _zz_578 = (decode_INSTRUCTION & (32'b00000000000000000010000001111111));
  assign _zz_579 = (32'b00000000000000000010000001110011);
  assign _zz_580 = ((decode_INSTRUCTION & (32'b00000000000000000100000001111111)) == (32'b00000000000000000100000001100011));
  assign _zz_581 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_582 = {((decode_INSTRUCTION & (32'b00000000000000000110000000111111)) == (32'b00000000000000000000000000100011)),{((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_583) == (32'b00000000000000000000000000000011)),{(_zz_584 == _zz_585),{_zz_586,{_zz_587,_zz_588}}}}}};
  assign _zz_583 = (32'b00000000000000000101000001011111);
  assign _zz_584 = (decode_INSTRUCTION & (32'b00000000000000000111000001111011));
  assign _zz_585 = (32'b00000000000000000000000001100011);
  assign _zz_586 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000100000000001111));
  assign _zz_587 = ((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_588 = {((decode_INSTRUCTION & (32'b00000001111100000111000001111111)) == (32'b00000000000000000101000000001111)),{((decode_INSTRUCTION & (32'b10111100000000000111000001111111)) == (32'b00000000000000000101000000010011)),{((decode_INSTRUCTION & _zz_589) == (32'b00000000000000000001000000010011)),{(_zz_590 == _zz_591),{_zz_592,{_zz_593,_zz_594}}}}}};
  assign _zz_589 = (32'b11111100000000000011000001111111);
  assign _zz_590 = (decode_INSTRUCTION & (32'b10111110000000000111000001111111));
  assign _zz_591 = (32'b00000000000000000101000000110011);
  assign _zz_592 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_593 = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00110000001000000000000001110011));
  assign _zz_594 = ((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00000000000100000000000001110011));
  assign _zz_595 = decode_INSTRUCTION[31];
  assign _zz_596 = decode_INSTRUCTION[19 : 12];
  assign _zz_597 = decode_INSTRUCTION[20];
  assign _zz_598 = decode_INSTRUCTION[31];
  assign _zz_599 = decode_INSTRUCTION[7];
  always @ (posedge clk) begin
    if(_zz_57) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_143) begin
      _zz_305 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_144) begin
      _zz_306 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache instructionCache_1 ( 
    .io_flush_cmd_valid(_zz_280),
    .io_flush_cmd_ready(_zz_313),
    .io_flush_rsp(_zz_314),
    .io_cpu_prefetch_isValid(prefetch_arbitration_isValid),
    .io_cpu_prefetch_haltIt(_zz_315),
    .io_cpu_prefetch_pc(_zz_93),
    .io_cpu_fetch_isValid(fetch_arbitration_isValid),
    .io_cpu_fetch_isStuck(fetch_arbitration_isStuck),
    .io_cpu_fetch_pc(_zz_92),
    .io_cpu_fetch_data(_zz_316),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_317),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_318),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_319),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_102),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_281),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_282),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_283),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_284),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_285),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_286),
    .io_cpu_decode_isValid(_zz_287),
    .io_cpu_decode_isUser(_zz_288),
    .io_cpu_decode_isStuck(decode_arbitration_isStuck),
    .io_cpu_decode_pc(_zz_87),
    .io_cpu_decode_cacheMiss(_zz_320),
    .io_cpu_decode_error(_zz_321),
    .io_cpu_decode_mmuMiss(_zz_322),
    .io_cpu_decode_illegalAccess(_zz_323),
    .io_mem_cmd_valid(_zz_324),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_325),
    .io_mem_cmd_payload_size(_zz_326),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1 ( 
    .io_cpu_execute_isValid(_zz_289),
    .io_cpu_execute_isStuck(execute_arbitration_isStuck),
    .io_cpu_execute_args_kind(_zz_290),
    .io_cpu_execute_args_wr(execute_MEMORY_WR),
    .io_cpu_execute_args_address(_zz_291),
    .io_cpu_execute_args_data(_zz_121),
    .io_cpu_execute_args_size(execute_DBusCachedPlugin_size),
    .io_cpu_execute_args_forceUncachedAccess(_zz_292),
    .io_cpu_execute_args_clean(_zz_293),
    .io_cpu_execute_args_invalidate(_zz_294),
    .io_cpu_execute_args_way(_zz_295),
    .io_cpu_memory_isValid(_zz_296),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_haltIt(_zz_327),
    .io_cpu_memory_mmuBus_cmd_isValid(_zz_328),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(_zz_329),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(_zz_330),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(_zz_103),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_297),
    .io_cpu_memory_mmuBus_rsp_allowRead(_zz_298),
    .io_cpu_memory_mmuBus_rsp_allowWrite(_zz_299),
    .io_cpu_memory_mmuBus_rsp_allowExecute(_zz_300),
    .io_cpu_memory_mmuBus_rsp_allowUser(_zz_301),
    .io_cpu_memory_mmuBus_rsp_miss(_zz_302),
    .io_cpu_writeBack_isValid(_zz_303),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_304),
    .io_cpu_writeBack_haltIt(_zz_331),
    .io_cpu_writeBack_data(_zz_332),
    .io_cpu_writeBack_mmuMiss(_zz_333),
    .io_cpu_writeBack_illegalAccess(_zz_334),
    .io_cpu_writeBack_unalignedAccess(_zz_335),
    .io_cpu_writeBack_accessError(_zz_336),
    .io_cpu_writeBack_badAddr(_zz_337),
    .io_mem_cmd_valid(_zz_338),
    .io_mem_cmd_ready(dBus_cmd_ready),
    .io_mem_cmd_payload_wr(_zz_339),
    .io_mem_cmd_payload_address(_zz_340),
    .io_mem_cmd_payload_data(_zz_341),
    .io_mem_cmd_payload_mask(_zz_342),
    .io_mem_cmd_payload_length(_zz_343),
    .io_mem_cmd_payload_last(_zz_344),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_442)
      2'b00 : begin
        _zz_310 = _zz_106;
      end
      2'b01 : begin
        _zz_310 = _zz_111;
      end
      2'b10 : begin
        _zz_310 = _zz_100;
      end
      default : begin
        _zz_310 = _zz_108;
      end
    endcase
  end

  always @(*) begin
    case(_zz_195)
      2'b00 : begin
        _zz_311 = (_zz_322 ? (4'b1110) : (4'b0001));
        _zz_312 = decode_PC;
      end
      2'b01 : begin
        _zz_311 = decodeExceptionPort_payload_code;
        _zz_312 = decodeExceptionPort_payload_badAddr;
      end
      default : begin
        _zz_311 = (4'b0000);
        _zz_312 = _zz_108;
      end
    endcase
  end

  assign decode_ALU_BITWISE_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign execute_BRANCH_CALC = _zz_29;
  assign writeBack_REGFILE_WRITE_DATA = _zz_266;
  assign execute_REGFILE_WRITE_DATA = _zz_53;
  assign memory_MEMORY_WR = _zz_262;
  assign decode_MEMORY_WR = _zz_70;
  assign decode_IS_EBREAK = _zz_76;
  assign decode_SRC_USE_SUB_LESS = _zz_81;
  assign memory_PC = _zz_257;
  assign fetch_PC = _zz_254;
  assign decode_IS_RS2_SIGNED = _zz_68;
  assign decode_CSR_READ_OPCODE = _zz_26;
  assign decode_ALU_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign decode_SRC2_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign _zz_10 = _zz_11;
  assign decode_SHIFT_CTRL = _zz_12;
  assign _zz_13 = _zz_14;
  assign _zz_15 = _zz_16;
  assign execute_MUL_LH = _zz_38;
  assign execute_INSTRUCTION_READY = _zz_243;
  assign decode_CSR_WRITE_OPCODE = _zz_27;
  assign execute_ENV_CTRL = _zz_17;
  assign _zz_18 = _zz_19;
  assign decode_ENV_CTRL = _zz_20;
  assign _zz_21 = _zz_22;
  assign memory_FORMAL_PC_NEXT = _zz_239;
  assign execute_FORMAL_PC_NEXT = _zz_238;
  assign decode_FORMAL_PC_NEXT = _zz_237;
  assign fetch_FORMAL_PC_NEXT = _zz_236;
  assign prefetch_FORMAL_PC_NEXT = _zz_96;
  assign decode_MEMORY_MANAGMENT = _zz_74;
  assign memory_IS_MUL = _zz_233;
  assign execute_IS_MUL = _zz_232;
  assign decode_IS_MUL = _zz_80;
  assign memory_MUL_HH = _zz_229;
  assign execute_MUL_HH = _zz_36;
  assign fetch_INSTRUCTION = _zz_91;
  assign execute_MUL_HL = _zz_37;
  assign decode_IS_DIV = _zz_77;
  assign execute_SHIFT_RIGHT = _zz_42;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_82;
  assign memory_MUL_LOW = _zz_35;
  assign decode_SRC_LESS_UNSIGNED = _zz_69;
  assign execute_FLUSH_ALL = _zz_215;
  assign decode_FLUSH_ALL = _zz_67;
  assign decode_MEMORY_ENABLE = _zz_75;
  assign execute_MUL_LL = _zz_39;
  assign execute_BYPASSABLE_MEMORY_STAGE = _zz_206;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_73;
  assign decode_IS_RS1_SIGNED = _zz_62;
  assign memory_MEMORY_ADDRESS_LOW = _zz_203;
  assign execute_MEMORY_ADDRESS_LOW = _zz_86;
  assign execute_BRANCH_DO = _zz_30;
  assign decode_SRC1_CTRL = _zz_23;
  assign _zz_24 = _zz_25;
  assign execute_CSR_READ_OPCODE = _zz_251;
  assign execute_CSR_WRITE_OPCODE = _zz_242;
  assign memory_REGFILE_WRITE_DATA = _zz_265;
  assign execute_IS_CSR = _zz_264;
  assign decode_IS_CSR = _zz_63;
  assign memory_ENV_CTRL = _zz_28;
  assign memory_INSTRUCTION_READY = _zz_244;
  assign memory_BRANCH_CALC = _zz_267;
  assign memory_BRANCH_DO = _zz_202;
  assign execute_PC = _zz_256;
  assign execute_PREDICTION_HAD_BRANCHED2 = _zz_231;
  assign execute_BRANCH_CTRL = _zz_31;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_33;
  assign decode_BRANCH_CTRL = _zz_32;
  assign execute_IS_EBREAK = _zz_260;
  assign decode_RS2_USE = _zz_65;
  assign decode_RS1_USE = _zz_83;
  always @ (*) begin
    _zz_34 = execute_REGFILE_WRITE_DATA;
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_34 = execute_CsrPlugin_readData;
    end
  end

  assign execute_REGFILE_WRITE_VALID = _zz_208;
  assign execute_BYPASSABLE_EXECUTE_STAGE = _zz_220;
  assign memory_REGFILE_WRITE_VALID = _zz_209;
  assign memory_BYPASSABLE_MEMORY_STAGE = _zz_207;
  assign writeBack_REGFILE_WRITE_VALID = _zz_210;
  always @ (*) begin
    decode_RS2 = _zz_58;
    decode_RS1 = _zz_59;
    if(_zz_164)begin
      if((_zz_165 == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_166;
      end
      if((_zz_165 == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_166;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(_zz_167)begin
        if(_zz_168)begin
          decode_RS1 = _zz_85;
        end
        if(_zz_169)begin
          decode_RS2 = _zz_85;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_170)begin
          decode_RS1 = _zz_40;
        end
        if(_zz_171)begin
          decode_RS2 = _zz_40;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_172)begin
          decode_RS1 = _zz_34;
        end
        if(_zz_173)begin
          decode_RS2 = _zz_34;
        end
      end
    end
  end

  assign execute_IS_RS1_SIGNED = _zz_205;
  assign execute_RS1 = _zz_219;
  assign execute_IS_DIV = _zz_222;
  assign execute_IS_RS2_SIGNED = _zz_253;
  assign memory_INSTRUCTION = _zz_227;
  assign memory_IS_DIV = _zz_223;
  assign writeBack_IS_MUL = _zz_234;
  assign writeBack_MUL_HH = _zz_230;
  assign writeBack_MUL_LOW = _zz_218;
  assign memory_MUL_HL = _zz_224;
  assign memory_MUL_LH = _zz_245;
  assign memory_MUL_LL = _zz_211;
  assign memory_SHIFT_RIGHT = _zz_221;
  always @ (*) begin
    _zz_40 = memory_REGFILE_WRITE_DATA;
    prefetch_arbitration_haltByOther = 1'b0;
    decode_arbitration_flushAll = 1'b0;
    decode_arbitration_redoIt = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    _zz_110 = 1'b0;
    _zz_111 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(_zz_99)begin
      decode_arbitration_redoIt = 1'b1;
      decode_arbitration_flushAll = 1'b1;
    end
    _zz_280 = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_280 = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_313))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_327)begin
      memory_arbitration_haltItself = 1'b1;
    end
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_40 = _zz_154;
      end
      `ShiftCtrlEnum_binary_sequancial_SRL_1, `ShiftCtrlEnum_binary_sequancial_SRA_1 : begin
        _zz_40 = memory_SHIFT_RIGHT;
      end
      default : begin
      end
    endcase
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_350)begin
      if(_zz_352)begin
        memory_arbitration_haltItself = 1'b1;
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_40 = memory_DivPlugin_div_result;
    end
    if(_zz_346)begin
      prefetch_arbitration_haltByOther = 1'b1;
      decode_arbitration_flushAll = 1'b1;
    end
    if(DebugPlugin_haltIt)begin
      prefetch_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_pipelineLiberator_enable)begin
      prefetch_arbitration_haltByOther = 1'b1;
    end
    if(_zz_353)begin
      _zz_110 = 1'b1;
      _zz_111 = CsrPlugin_mtvec;
    end
    if(_zz_351)begin
      memory_arbitration_haltItself = writeBack_arbitration_isValid;
      if(memory_arbitration_isFiring)begin
        _zz_110 = 1'b1;
        _zz_111 = CsrPlugin_mepc;
      end
    end
  end

  assign memory_SHIFT_CTRL = _zz_41;
  assign execute_SHIFT_CTRL = _zz_43;
  assign execute_SRC_LESS_UNSIGNED = _zz_217;
  assign execute_SRC_USE_SUB_LESS = _zz_259;
  assign _zz_47 = execute_PC;
  assign execute_SRC2_CTRL = _zz_48;
  assign execute_SRC1_CTRL = _zz_50;
  assign execute_SRC_ADD_SUB = _zz_46;
  assign execute_SRC_LESS = _zz_44;
  assign execute_ALU_CTRL = _zz_52;
  assign execute_SRC2 = _zz_49;
  assign execute_SRC1 = _zz_51;
  assign execute_ALU_BITWISE_CTRL = _zz_54;
  assign _zz_55 = writeBack_INSTRUCTION;
  assign _zz_56 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_57 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_57 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_90;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_60;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_84;
  assign decode_INSTRUCTION_READY = _zz_88;
  always @ (*) begin
    _zz_85 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_85 = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_358)
        2'b00 : begin
          _zz_85 = _zz_407;
        end
        2'b01, 2'b10, 2'b11 : begin
          _zz_85 = _zz_408;
        end
        default : begin
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ADDRESS_LOW = _zz_204;
  assign writeBack_MEMORY_WR = _zz_263;
  assign writeBack_MEMORY_ENABLE = _zz_214;
  assign memory_MEMORY_ENABLE = _zz_213;
  assign execute_MEMORY_MANAGMENT = _zz_235;
  assign execute_RS2 = _zz_252;
  assign execute_SRC_ADD = _zz_45;
  assign execute_MEMORY_WR = _zz_261;
  assign execute_MEMORY_ENABLE = _zz_212;
  assign execute_INSTRUCTION = _zz_226;
  assign memory_FLUSH_ALL = _zz_216;
  assign _zz_87 = decode_PC;
  assign _zz_89 = fetch_INSTRUCTION;
  assign _zz_92 = fetch_PC;
  assign _zz_93 = prefetch_PC;
  always @ (*) begin
    _zz_94 = execute_FORMAL_PC_NEXT;
    if(_zz_110)begin
      _zz_94 = _zz_111;
    end
  end

  always @ (*) begin
    _zz_95 = decode_FORMAL_PC_NEXT;
    if(_zz_99)begin
      _zz_95 = _zz_100;
    end
    if(_zz_107)begin
      _zz_95 = _zz_108;
    end
  end

  assign prefetch_PC = _zz_97;
  assign prefetch_PC_CALC_WITHOUT_JUMP = _zz_98;
  assign writeBack_PC = _zz_258;
  assign writeBack_INSTRUCTION = _zz_228;
  assign decode_PC = _zz_255;
  assign decode_INSTRUCTION = _zz_225;
  always @ (*) begin
    prefetch_arbitration_haltItself = 1'b0;
    if(_zz_315)begin
      prefetch_arbitration_haltItself = 1'b1;
    end
  end

  assign prefetch_arbitration_removeIt = 1'b0;
  assign prefetch_arbitration_flushAll = 1'b0;
  assign prefetch_arbitration_redoIt = 1'b0;
  assign fetch_arbitration_haltItself = 1'b0;
  assign fetch_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    fetch_arbitration_removeIt = 1'b0;
    if(fetch_arbitration_isFlushed)begin
      fetch_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    fetch_arbitration_flushAll = 1'b0;
    if(_zz_107)begin
      fetch_arbitration_flushAll = 1'b1;
    end
    CsrPlugin_exceptionPortCtrl_exceptionValids_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_2;
    if(_zz_345)begin
      fetch_arbitration_flushAll = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_2 = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_2 = 1'b0;
    end
  end

  assign fetch_arbitration_redoIt = 1'b0;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    if((decode_arbitration_isValid && (_zz_162 || _zz_163)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    DebugPlugin_insertDecodeInstruction = 1'b0;
    _zz_307 = 1'b1;
    if(debug_bus_cmd_valid)begin
      case(_zz_349)
        1'b0 : begin
        end
        default : begin
          if(debug_bus_cmd_payload_wr)begin
            DebugPlugin_insertDecodeInstruction = 1'b1;
            if(DebugPlugin_secondCycle)begin
              decode_arbitration_haltItself = 1'b1;
            end
            _zz_307 = (! ((DebugPlugin_firstCycle || DebugPlugin_secondCycle) || decode_arbitration_isValid));
          end
        end
      endcase
    end
    if(((decode_arbitration_isValid && decode_IS_CSR) && (execute_arbitration_isValid || memory_arbitration_isValid)))begin
      decode_arbitration_haltItself = 1'b1;
    end
  end

  assign decode_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_345)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_haltItself = 1'b0;
    if((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_readDataRegValid)))begin
      execute_arbitration_haltItself = 1'b1;
    end
  end

  assign execute_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(_zz_105)begin
      execute_arbitration_flushAll = 1'b1;
    end
    if(_zz_348)begin
      execute_arbitration_flushAll = 1'b1;
    end
    if(_zz_351)begin
      if(memory_arbitration_isFiring)begin
        execute_arbitration_flushAll = 1'b1;
      end
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(_zz_348)begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_flushAll = 1'b0;
    writeBack_arbitration_removeIt = 1'b0;
    CsrPlugin_exceptionPortCtrl_exceptionValids_5 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_5;
    if(_zz_354)begin
      memory_arbitration_flushAll = 1'b1;
      writeBack_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_5 = 1'b1;
    end
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_5 = 1'b0;
    end
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_redoIt = 1'b0;
  always @ (*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(_zz_331)begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  always @ (*) begin
    _zz_113 = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      _zz_113 = 1'b0;
    end
  end

  always @ (*) begin
    _zz_114 = 1'b1;
    if(DebugPlugin_haltIt)begin
      _zz_114 = 1'b0;
    end
  end

  assign prefetch_PcManagerSimplePlugin_pcBeforeJumps = (prefetch_PcManagerSimplePlugin_pcReg + _zz_361);
  assign _zz_98 = prefetch_PcManagerSimplePlugin_pcBeforeJumps;
  always @ (*) begin
    prefetch_PcManagerSimplePlugin_pc = prefetch_PC_CALC_WITHOUT_JUMP;
    prefetch_PcManagerSimplePlugin_samplePcNext = 1'b0;
    if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
      prefetch_PcManagerSimplePlugin_pc = prefetch_PcManagerSimplePlugin_jump_pcLoad_payload;
    end
    if(prefetch_arbitration_isFiring)begin
      prefetch_PcManagerSimplePlugin_samplePcNext = 1'b1;
    end
  end

  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_valid = (((_zz_99 || _zz_105) || _zz_107) || _zz_110);
  assign _zz_115 = {_zz_107,{_zz_99,{_zz_110,_zz_105}}};
  assign _zz_116 = (_zz_115 & (~ _zz_362));
  assign _zz_117 = _zz_116[3];
  assign _zz_118 = (_zz_116[1] || _zz_117);
  assign _zz_119 = (_zz_116[2] || _zz_117);
  assign prefetch_PcManagerSimplePlugin_jump_pcLoad_payload = _zz_310;
  assign _zz_97 = prefetch_PcManagerSimplePlugin_pc;
  assign _zz_96 = (prefetch_PC + (32'b00000000000000000000000000000100));
  assign iBus_cmd_valid = _zz_324;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_325;
    iBus_cmd_payload_address = _zz_325;
  end

  assign iBus_cmd_payload_size = _zz_326;
  assign _zz_281 = _zz_102[31];
  assign _zz_282 = 1'b1;
  assign _zz_283 = 1'b1;
  assign _zz_284 = 1'b1;
  assign _zz_285 = 1'b1;
  assign _zz_286 = 1'b0;
  assign _zz_91 = _zz_316;
  assign _zz_90 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_89);
  assign _zz_88 = 1'b1;
  assign _zz_120 = (1'b1 && (! _zz_177));
  assign _zz_287 = (decode_arbitration_isValid && _zz_120);
  assign _zz_288 = (_zz_112 == (2'b00));
  assign _zz_99 = ((((decode_arbitration_isValid && _zz_120) && _zz_320) && (! _zz_322)) && (! _zz_323));
  assign _zz_100 = decode_PC;
  assign _zz_101 = ((decode_arbitration_isValid && _zz_120) && ((_zz_321 || _zz_322) || _zz_323));
  assign dBus_cmd_valid = _zz_338;
  assign dBus_cmd_payload_wr = _zz_339;
  assign dBus_cmd_payload_address = _zz_340;
  assign dBus_cmd_payload_data = _zz_341;
  assign dBus_cmd_payload_mask = _zz_342;
  assign dBus_cmd_payload_length = _zz_343;
  assign dBus_cmd_payload_last = _zz_344;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign _zz_289 = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign _zz_291 = execute_SRC_ADD;
  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
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

  assign _zz_292 = 1'b0;
  assign _zz_290 = (execute_MEMORY_MANAGMENT ? `DataCacheCpuCmdKind_binary_sequancial_MANAGMENT : `DataCacheCpuCmdKind_binary_sequancial_MEMORY);
  assign _zz_293 = execute_INSTRUCTION[28];
  assign _zz_294 = execute_INSTRUCTION[29];
  assign _zz_295 = execute_INSTRUCTION[30];
  assign _zz_86 = _zz_291[1 : 0];
  assign _zz_296 = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign _zz_297 = _zz_103[31];
  assign _zz_298 = 1'b1;
  assign _zz_299 = 1'b1;
  assign _zz_300 = 1'b1;
  assign _zz_301 = 1'b1;
  assign _zz_302 = 1'b0;
  assign _zz_303 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_304 = (_zz_112 == (2'b00));
  always @ (*) begin
    _zz_104 = (4'bxxxx);
    if((_zz_334 || _zz_336))begin
      _zz_104 = {1'd0, _zz_363};
    end
    if(_zz_335)begin
      _zz_104 = {1'd0, _zz_364};
    end
    if(_zz_333)begin
      _zz_104 = (4'b1101);
    end
  end

  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = _zz_332;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_332[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = _zz_332[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_332[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_122 = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_123[31] = _zz_122;
    _zz_123[30] = _zz_122;
    _zz_123[29] = _zz_122;
    _zz_123[28] = _zz_122;
    _zz_123[27] = _zz_122;
    _zz_123[26] = _zz_122;
    _zz_123[25] = _zz_122;
    _zz_123[24] = _zz_122;
    _zz_123[23] = _zz_122;
    _zz_123[22] = _zz_122;
    _zz_123[21] = _zz_122;
    _zz_123[20] = _zz_122;
    _zz_123[19] = _zz_122;
    _zz_123[18] = _zz_122;
    _zz_123[17] = _zz_122;
    _zz_123[16] = _zz_122;
    _zz_123[15] = _zz_122;
    _zz_123[14] = _zz_122;
    _zz_123[13] = _zz_122;
    _zz_123[12] = _zz_122;
    _zz_123[11] = _zz_122;
    _zz_123[10] = _zz_122;
    _zz_123[9] = _zz_122;
    _zz_123[8] = _zz_122;
    _zz_123[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_124 = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_125[31] = _zz_124;
    _zz_125[30] = _zz_124;
    _zz_125[29] = _zz_124;
    _zz_125[28] = _zz_124;
    _zz_125[27] = _zz_124;
    _zz_125[26] = _zz_124;
    _zz_125[25] = _zz_124;
    _zz_125[24] = _zz_124;
    _zz_125[23] = _zz_124;
    _zz_125[22] = _zz_124;
    _zz_125[21] = _zz_124;
    _zz_125[20] = _zz_124;
    _zz_125[19] = _zz_124;
    _zz_125[18] = _zz_124;
    _zz_125[17] = _zz_124;
    _zz_125[16] = _zz_124;
    _zz_125[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_356)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_123;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_125;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  assign _zz_102 = _zz_318;
  assign _zz_103 = _zz_329;
  assign _zz_127 = ((decode_INSTRUCTION & (32'b00000000000000000001000001010000)) == (32'b00000000000000000001000000000000));
  assign _zz_128 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_129 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_130 = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_131 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_132 = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_133 = ((decode_INSTRUCTION & (32'b00000000000000000000000000101000)) == (32'b00000000000000000000000000000000));
  assign _zz_134 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_135 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_126 = {({_zz_131,{_zz_443,{_zz_444,_zz_445}}} != (6'b000000)),{({_zz_135,{_zz_446,_zz_447}} != (4'b0000)),{({_zz_448,_zz_449} != (4'b0000)),{(_zz_450 != _zz_451),{_zz_452,{_zz_453,_zz_454}}}}}};
  assign _zz_84 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000000000001111111)) == (32'b00000000000000000000000001101111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_577) == (32'b00000000000000000001000001110011)),{(_zz_578 == _zz_579),{_zz_580,{_zz_581,_zz_582}}}}}}} != (20'b00000000000000000000));
  assign _zz_83 = _zz_365[0];
  assign _zz_82 = _zz_366[0];
  assign _zz_81 = _zz_367[0];
  assign _zz_80 = _zz_368[0];
  assign _zz_136 = _zz_126[5 : 4];
  assign _zz_79 = _zz_136;
  assign _zz_137 = _zz_126[7 : 6];
  assign _zz_78 = _zz_137;
  assign _zz_77 = _zz_369[0];
  assign _zz_76 = _zz_370[0];
  assign _zz_75 = _zz_371[0];
  assign _zz_74 = _zz_372[0];
  assign _zz_73 = _zz_373[0];
  assign _zz_138 = _zz_126[14 : 13];
  assign _zz_72 = _zz_138;
  assign _zz_139 = _zz_126[16 : 15];
  assign _zz_71 = _zz_139;
  assign _zz_70 = _zz_374[0];
  assign _zz_69 = _zz_375[0];
  assign _zz_68 = _zz_376[0];
  assign _zz_67 = _zz_377[0];
  assign _zz_140 = _zz_126[22 : 21];
  assign _zz_66 = _zz_140;
  assign _zz_65 = _zz_378[0];
  assign _zz_141 = _zz_126[25 : 24];
  assign _zz_64 = _zz_141;
  assign _zz_63 = _zz_379[0];
  assign _zz_62 = _zz_380[0];
  assign _zz_142 = _zz_126[29 : 28];
  assign _zz_61 = _zz_142;
  assign _zz_60 = _zz_381[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_143 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_305;
  assign _zz_144 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_306;
  assign _zz_59 = decode_RegFilePlugin_rs1Data;
  assign _zz_58 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_56 && writeBack_arbitration_isFiring);
    if(_zz_145)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_55[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_85;
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
        _zz_146 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_146 = {31'd0, _zz_382};
      end
      default : begin
        _zz_146 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_53 = _zz_146;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_147 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_FOUR : begin
        _zz_147 = (32'b00000000000000000000000000000100);
      end
      default : begin
        _zz_147 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_51 = _zz_147;
  assign _zz_148 = _zz_383[11];
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

  assign _zz_150 = _zz_384[11];
  always @ (*) begin
    _zz_151[19] = _zz_150;
    _zz_151[18] = _zz_150;
    _zz_151[17] = _zz_150;
    _zz_151[16] = _zz_150;
    _zz_151[15] = _zz_150;
    _zz_151[14] = _zz_150;
    _zz_151[13] = _zz_150;
    _zz_151[12] = _zz_150;
    _zz_151[11] = _zz_150;
    _zz_151[10] = _zz_150;
    _zz_151[9] = _zz_150;
    _zz_151[8] = _zz_150;
    _zz_151[7] = _zz_150;
    _zz_151[6] = _zz_150;
    _zz_151[5] = _zz_150;
    _zz_151[4] = _zz_150;
    _zz_151[3] = _zz_150;
    _zz_151[2] = _zz_150;
    _zz_151[1] = _zz_150;
    _zz_151[0] = _zz_150;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_152 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_152 = {_zz_149,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_152 = {_zz_151,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_152 = _zz_47;
      end
    endcase
  end

  assign _zz_49 = _zz_152;
  assign execute_SrcPlugin_addSub = _zz_385;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_46 = execute_SrcPlugin_addSub;
  assign _zz_45 = execute_SrcPlugin_addSub;
  assign _zz_44 = execute_SrcPlugin_less;
  assign execute_FullBarrielShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_153[0] = execute_SRC1[31];
    _zz_153[1] = execute_SRC1[30];
    _zz_153[2] = execute_SRC1[29];
    _zz_153[3] = execute_SRC1[28];
    _zz_153[4] = execute_SRC1[27];
    _zz_153[5] = execute_SRC1[26];
    _zz_153[6] = execute_SRC1[25];
    _zz_153[7] = execute_SRC1[24];
    _zz_153[8] = execute_SRC1[23];
    _zz_153[9] = execute_SRC1[22];
    _zz_153[10] = execute_SRC1[21];
    _zz_153[11] = execute_SRC1[20];
    _zz_153[12] = execute_SRC1[19];
    _zz_153[13] = execute_SRC1[18];
    _zz_153[14] = execute_SRC1[17];
    _zz_153[15] = execute_SRC1[16];
    _zz_153[16] = execute_SRC1[15];
    _zz_153[17] = execute_SRC1[14];
    _zz_153[18] = execute_SRC1[13];
    _zz_153[19] = execute_SRC1[12];
    _zz_153[20] = execute_SRC1[11];
    _zz_153[21] = execute_SRC1[10];
    _zz_153[22] = execute_SRC1[9];
    _zz_153[23] = execute_SRC1[8];
    _zz_153[24] = execute_SRC1[7];
    _zz_153[25] = execute_SRC1[6];
    _zz_153[26] = execute_SRC1[5];
    _zz_153[27] = execute_SRC1[4];
    _zz_153[28] = execute_SRC1[3];
    _zz_153[29] = execute_SRC1[2];
    _zz_153[30] = execute_SRC1[1];
    _zz_153[31] = execute_SRC1[0];
  end

  assign execute_FullBarrielShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SLL_1) ? _zz_153 : execute_SRC1);
  assign _zz_42 = _zz_394;
  always @ (*) begin
    _zz_154[0] = memory_SHIFT_RIGHT[31];
    _zz_154[1] = memory_SHIFT_RIGHT[30];
    _zz_154[2] = memory_SHIFT_RIGHT[29];
    _zz_154[3] = memory_SHIFT_RIGHT[28];
    _zz_154[4] = memory_SHIFT_RIGHT[27];
    _zz_154[5] = memory_SHIFT_RIGHT[26];
    _zz_154[6] = memory_SHIFT_RIGHT[25];
    _zz_154[7] = memory_SHIFT_RIGHT[24];
    _zz_154[8] = memory_SHIFT_RIGHT[23];
    _zz_154[9] = memory_SHIFT_RIGHT[22];
    _zz_154[10] = memory_SHIFT_RIGHT[21];
    _zz_154[11] = memory_SHIFT_RIGHT[20];
    _zz_154[12] = memory_SHIFT_RIGHT[19];
    _zz_154[13] = memory_SHIFT_RIGHT[18];
    _zz_154[14] = memory_SHIFT_RIGHT[17];
    _zz_154[15] = memory_SHIFT_RIGHT[16];
    _zz_154[16] = memory_SHIFT_RIGHT[15];
    _zz_154[17] = memory_SHIFT_RIGHT[14];
    _zz_154[18] = memory_SHIFT_RIGHT[13];
    _zz_154[19] = memory_SHIFT_RIGHT[12];
    _zz_154[20] = memory_SHIFT_RIGHT[11];
    _zz_154[21] = memory_SHIFT_RIGHT[10];
    _zz_154[22] = memory_SHIFT_RIGHT[9];
    _zz_154[23] = memory_SHIFT_RIGHT[8];
    _zz_154[24] = memory_SHIFT_RIGHT[7];
    _zz_154[25] = memory_SHIFT_RIGHT[6];
    _zz_154[26] = memory_SHIFT_RIGHT[5];
    _zz_154[27] = memory_SHIFT_RIGHT[4];
    _zz_154[28] = memory_SHIFT_RIGHT[3];
    _zz_154[29] = memory_SHIFT_RIGHT[2];
    _zz_154[30] = memory_SHIFT_RIGHT[1];
    _zz_154[31] = memory_SHIFT_RIGHT[0];
  end

  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_357)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_39 = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_38 = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_37 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_36 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_35 = ($signed(_zz_396) + $signed(_zz_404));
  assign writeBack_MulPlugin_result = ($signed(_zz_405) + $signed(_zz_406));
  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_347)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_done = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_done && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_410);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_155 = memory_DivPlugin_rs1[31 : 0];
  assign _zz_156 = {memory_DivPlugin_accumulator[31 : 0],_zz_155[31]};
  assign _zz_157 = (_zz_156 - _zz_411);
  assign _zz_158 = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_159 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_160 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_161[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_161[31 : 0] = execute_RS1;
  end

  always @ (*) begin
    _zz_162 = 1'b0;
    _zz_163 = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! _zz_167)))begin
        if(_zz_168)begin
          _zz_162 = 1'b1;
        end
        if(_zz_169)begin
          _zz_163 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_170)begin
          _zz_162 = 1'b1;
        end
        if(_zz_171)begin
          _zz_163 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_172)begin
          _zz_162 = 1'b1;
        end
        if(_zz_173)begin
          _zz_163 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_162 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_163 = 1'b0;
    end
  end

  assign _zz_167 = 1'b1;
  assign _zz_168 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_169 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_170 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_171 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_172 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_173 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign DebugPlugin_isPipBusy = (DebugPlugin_isPipActive || _zz_174);
  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_175))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign debug_resetOut = _zz_176;
  assign _zz_178 = _zz_424[11];
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

  assign decode_BranchPlugin_conditionalBranchPrediction = _zz_425[31];
  assign _zz_33 = ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_B) && decode_BranchPlugin_conditionalBranchPrediction));
  assign _zz_107 = (decode_PREDICTION_HAD_BRANCHED2 && decode_arbitration_isFiring);
  assign _zz_180 = _zz_426[19];
  always @ (*) begin
    _zz_181[10] = _zz_180;
    _zz_181[9] = _zz_180;
    _zz_181[8] = _zz_180;
    _zz_181[7] = _zz_180;
    _zz_181[6] = _zz_180;
    _zz_181[5] = _zz_180;
    _zz_181[4] = _zz_180;
    _zz_181[3] = _zz_180;
    _zz_181[2] = _zz_180;
    _zz_181[1] = _zz_180;
    _zz_181[0] = _zz_180;
  end

  assign _zz_182 = _zz_427[11];
  always @ (*) begin
    _zz_183[18] = _zz_182;
    _zz_183[17] = _zz_182;
    _zz_183[16] = _zz_182;
    _zz_183[15] = _zz_182;
    _zz_183[14] = _zz_182;
    _zz_183[13] = _zz_182;
    _zz_183[12] = _zz_182;
    _zz_183[11] = _zz_182;
    _zz_183[10] = _zz_182;
    _zz_183[9] = _zz_182;
    _zz_183[8] = _zz_182;
    _zz_183[7] = _zz_182;
    _zz_183[6] = _zz_182;
    _zz_183[5] = _zz_182;
    _zz_183[4] = _zz_182;
    _zz_183[3] = _zz_182;
    _zz_183[2] = _zz_182;
    _zz_183[1] = _zz_182;
    _zz_183[0] = _zz_182;
  end

  assign _zz_108 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) ? {{_zz_181,{{{_zz_595,_zz_596},_zz_597},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_183,{{{_zz_598,_zz_599},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign _zz_109 = (((decode_INSTRUCTION_READY && decode_PREDICTION_HAD_BRANCHED2) && decode_arbitration_isValid) && (_zz_108[1 : 0] != (2'b00)));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_184 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_184 == (3'b000))) begin
        _zz_185 = execute_BranchPlugin_eq;
    end else if((_zz_184 == (3'b001))) begin
        _zz_185 = (! execute_BranchPlugin_eq);
    end else if((((_zz_184 & (3'b101)) == (3'b101)))) begin
        _zz_185 = (! execute_SRC_LESS);
    end else begin
        _zz_185 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_186 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_186 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_186 = 1'b1;
      end
      default : begin
        _zz_186 = _zz_185;
      end
    endcase
  end

  assign _zz_30 = (execute_PREDICTION_HAD_BRANCHED2 != _zz_186);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_188,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = (execute_PREDICTION_HAD_BRANCHED2 ? (32'b00000000000000000000000000000100) : {{_zz_190,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
      end
    endcase
  end

  assign _zz_187 = _zz_428[11];
  always @ (*) begin
    _zz_188[19] = _zz_187;
    _zz_188[18] = _zz_187;
    _zz_188[17] = _zz_187;
    _zz_188[16] = _zz_187;
    _zz_188[15] = _zz_187;
    _zz_188[14] = _zz_187;
    _zz_188[13] = _zz_187;
    _zz_188[12] = _zz_187;
    _zz_188[11] = _zz_187;
    _zz_188[10] = _zz_187;
    _zz_188[9] = _zz_187;
    _zz_188[8] = _zz_187;
    _zz_188[7] = _zz_187;
    _zz_188[6] = _zz_187;
    _zz_188[5] = _zz_187;
    _zz_188[4] = _zz_187;
    _zz_188[3] = _zz_187;
    _zz_188[2] = _zz_187;
    _zz_188[1] = _zz_187;
    _zz_188[0] = _zz_187;
  end

  assign _zz_189 = _zz_429[11];
  always @ (*) begin
    _zz_190[18] = _zz_189;
    _zz_190[17] = _zz_189;
    _zz_190[16] = _zz_189;
    _zz_190[15] = _zz_189;
    _zz_190[14] = _zz_189;
    _zz_190[13] = _zz_189;
    _zz_190[12] = _zz_189;
    _zz_190[11] = _zz_189;
    _zz_190[10] = _zz_189;
    _zz_190[9] = _zz_189;
    _zz_190[8] = _zz_189;
    _zz_190[7] = _zz_189;
    _zz_190[6] = _zz_189;
    _zz_190[5] = _zz_189;
    _zz_190[4] = _zz_189;
    _zz_190[3] = _zz_189;
    _zz_190[2] = _zz_189;
    _zz_190[1] = _zz_189;
    _zz_190[0] = _zz_189;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_29 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_105 = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_106 = memory_BRANCH_CALC;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_enable = 1'b0;
    if(CsrPlugin_exceptionPortCtrl_pipelineHasException)begin
      CsrPlugin_pipelineLiberator_enable = 1'b1;
    end
    if(CsrPlugin_interrupt)begin
      CsrPlugin_pipelineLiberator_enable = 1'b1;
    end
  end

  assign CsrPlugin_pipelineLiberator_done = (! ((((fetch_arbitration_isValid || decode_arbitration_isValid) || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid));
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_0 = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_1 = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_pipelineHasException = (((((CsrPlugin_exceptionPortCtrl_exceptionValids_0 || CsrPlugin_exceptionPortCtrl_exceptionValids_1) || CsrPlugin_exceptionPortCtrl_exceptionValids_2) || CsrPlugin_exceptionPortCtrl_exceptionValids_3) || CsrPlugin_exceptionPortCtrl_exceptionValids_4) || CsrPlugin_exceptionPortCtrl_exceptionValids_5);
  assign _zz_191 = {_zz_109,{decodeExceptionPort_valid,_zz_101}};
  assign _zz_192 = (_zz_191 & (~ _zz_430));
  assign _zz_193 = _zz_192[1];
  assign _zz_194 = _zz_192[2];
  assign _zz_195 = {_zz_194,_zz_193};
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_0;
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_1;
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_3;
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_3 = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_4 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_4;
    if(_zz_348)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_4 = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_4 = 1'b0;
    end
  end

  assign CsrPlugin_interruptRequest = ((((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) || (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE)) || (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE)) && CsrPlugin_mstatus_MIE);
  assign CsrPlugin_interrupt = (CsrPlugin_interruptRequest && _zz_113);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_5 && _zz_114);
  assign CsrPlugin_writeBackWasWfi = 1'b0;
  always @ (*) begin
    case(CsrPlugin_exception)
      1'b1 : begin
        _zz_196 = writeBack_PC;
      end
      default : begin
        _zz_196 = (CsrPlugin_writeBackWasWfi ? writeBack_PC : prefetch_PC_CALC_WITHOUT_JUMP);
      end
    endcase
  end

  assign contextSwitching = _zz_110;
  assign _zz_27 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_26 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b001101100000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_200;
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
      12'b110011000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[12 : 0] = (13'b1000000000000);
        execute_CsrPlugin_readData[25 : 20] = (6'b100000);
      end
      12'b001101000011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mbadaddr;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b001100110000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_198;
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
    if((_zz_112 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_434 : execute_SRC1);
  always @ (*) begin
    case(_zz_359)
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
  assign _zz_200 = (_zz_198 & _zz_199);
  assign externalInterrupt = (_zz_200 != (32'b00000000000000000000000000000000));
  assign _zz_25 = decode_SRC1_CTRL;
  assign _zz_23 = _zz_79;
  assign _zz_50 = _zz_201;
  assign _zz_22 = decode_ENV_CTRL;
  assign _zz_19 = execute_ENV_CTRL;
  assign _zz_20 = _zz_71;
  assign _zz_17 = _zz_240;
  assign _zz_28 = _zz_241;
  assign _zz_16 = decode_BRANCH_CTRL;
  assign _zz_32 = _zz_66;
  assign _zz_31 = _zz_246;
  assign _zz_14 = decode_SHIFT_CTRL;
  assign _zz_11 = execute_SHIFT_CTRL;
  assign _zz_12 = _zz_64;
  assign _zz_43 = _zz_247;
  assign _zz_41 = _zz_248;
  assign _zz_9 = decode_SRC2_CTRL;
  assign _zz_7 = _zz_61;
  assign _zz_48 = _zz_249;
  assign _zz_6 = decode_ALU_CTRL;
  assign _zz_4 = _zz_72;
  assign _zz_52 = _zz_250;
  assign _zz_3 = decode_ALU_BITWISE_CTRL;
  assign _zz_1 = _zz_78;
  assign _zz_54 = _zz_268;
  assign prefetch_arbitration_isFlushed = (((((prefetch_arbitration_flushAll || fetch_arbitration_flushAll) || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign fetch_arbitration_isFlushed = ((((fetch_arbitration_flushAll || decode_arbitration_flushAll) || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign decode_arbitration_isFlushed = (((decode_arbitration_flushAll || execute_arbitration_flushAll) || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign execute_arbitration_isFlushed = ((execute_arbitration_flushAll || memory_arbitration_flushAll) || writeBack_arbitration_flushAll);
  assign memory_arbitration_isFlushed = (memory_arbitration_flushAll || writeBack_arbitration_flushAll);
  assign writeBack_arbitration_isFlushed = writeBack_arbitration_flushAll;
  assign prefetch_arbitration_isStuckByOthers = (prefetch_arbitration_haltByOther || (((((1'b0 || fetch_arbitration_haltItself) || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign prefetch_arbitration_isStuck = (prefetch_arbitration_haltItself || prefetch_arbitration_isStuckByOthers);
  assign prefetch_arbitration_isMoving = ((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt));
  assign prefetch_arbitration_isFiring = ((prefetch_arbitration_isValid && (! prefetch_arbitration_isStuck)) && (! prefetch_arbitration_removeIt));
  assign fetch_arbitration_isStuckByOthers = (fetch_arbitration_haltByOther || ((((1'b0 || decode_arbitration_haltItself) || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign fetch_arbitration_isStuck = (fetch_arbitration_haltItself || fetch_arbitration_isStuckByOthers);
  assign fetch_arbitration_isMoving = ((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt));
  assign fetch_arbitration_isFiring = ((fetch_arbitration_isValid && (! fetch_arbitration_isStuck)) && (! fetch_arbitration_removeIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_haltItself) || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_haltItself) || writeBack_arbitration_haltItself));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_haltItself));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBusWishbone_ADR = {_zz_441,_zz_269};
  assign iBusWishbone_CTI = ((_zz_269 == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    _zz_308 = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_355)begin
      _zz_308 = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_270;
  assign iBus_rsp_payload_data = _zz_271;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_277 = (dBus_cmd_payload_length != (3'b000));
  assign _zz_273 = dBus_cmd_valid;
  assign _zz_275 = dBus_cmd_payload_wr;
  assign _zz_276 = (_zz_272 == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_274 && (_zz_275 || _zz_276));
  assign dBusWishbone_ADR = ((_zz_277 ? {{dBus_cmd_payload_address[31 : 5],_zz_272},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_277 ? (_zz_276 ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_275 ? dBus_cmd_payload_mask : (4'b1111));
  assign _zz_309 = _zz_275;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_274 = (_zz_273 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_273;
  assign dBusWishbone_STB = _zz_273;
  assign dBus_rsp_valid = _zz_278;
  assign dBus_rsp_payload_data = _zz_279;
  assign dBus_rsp_payload_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      prefetch_arbitration_isValid <= 1'b0;
      fetch_arbitration_isValid <= 1'b0;
      decode_arbitration_isValid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_112 <= (2'b11);
      prefetch_PcManagerSimplePlugin_pcReg <= externalResetVector;
      prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      _zz_145 <= 1'b1;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_164 <= 1'b0;
      _zz_177 <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mip_MEIP <= 1'b0;
      CsrPlugin_mip_MTIP <= 1'b0;
      CsrPlugin_mip_MSIP <= 1'b0;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_2 <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_3 <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_4 <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_5 <= 1'b0;
      _zz_198 <= (32'b00000000000000000000000000000000);
      _zz_266 <= (32'b00000000000000000000000000000000);
      _zz_228 <= (32'b00000000000000000000000000000000);
      _zz_269 <= (3'b000);
      _zz_270 <= 1'b0;
      _zz_272 <= (3'b000);
      _zz_278 <= 1'b0;
    end else begin
      prefetch_arbitration_isValid <= 1'b1;
      if(prefetch_PcManagerSimplePlugin_jump_pcLoad_valid)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b0;
      end
      if(prefetch_arbitration_isFiring)begin
        prefetch_PcManagerSimplePlugin_inc <= 1'b1;
      end
      if(prefetch_PcManagerSimplePlugin_samplePcNext)begin
        prefetch_PcManagerSimplePlugin_pcReg <= prefetch_PcManagerSimplePlugin_pc;
      end
      _zz_145 <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      _zz_164 <= (_zz_56 && writeBack_arbitration_isFiring);
      if(debug_bus_cmd_valid)begin
        case(_zz_349)
          1'b0 : begin
          end
          default : begin
            if(debug_bus_cmd_payload_wr)begin
              if(DebugPlugin_firstCycle)begin
                decode_arbitration_isValid <= 1'b1;
              end
            end
          end
        endcase
      end
      _zz_177 <= DebugPlugin_insertDecodeInstruction;
      CsrPlugin_mip_MEIP <= externalInterrupt;
      CsrPlugin_mip_MTIP <= timerInterrupt;
      if((! decode_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_2 <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_2 <= CsrPlugin_exceptionPortCtrl_exceptionValids_2;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_3 <= CsrPlugin_exceptionPortCtrl_exceptionValids_2;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_3 <= CsrPlugin_exceptionPortCtrl_exceptionValids_3;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_4 <= CsrPlugin_exceptionPortCtrl_exceptionValids_3;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_4 <= CsrPlugin_exceptionPortCtrl_exceptionValids_4;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_5 <= CsrPlugin_exceptionPortCtrl_exceptionValids_4;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_5 <= CsrPlugin_exceptionPortCtrl_exceptionValids_5;
      end
      if(_zz_353)begin
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_112;
      end
      if(_zz_351)begin
        if(memory_arbitration_isFiring)begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_112 <= CsrPlugin_mstatus_MPP;
        end
      end
      if((! writeBack_arbitration_isStuck))begin
        _zz_228 <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        _zz_266 <= _zz_40;
      end
      if(((! fetch_arbitration_isStuck) || fetch_arbitration_removeIt))begin
        fetch_arbitration_isValid <= 1'b0;
      end
      if(((! prefetch_arbitration_isStuck) && (! prefetch_arbitration_removeIt)))begin
        fetch_arbitration_isValid <= prefetch_arbitration_isValid;
      end
      if(((! decode_arbitration_isStuck) || decode_arbitration_removeIt))begin
        decode_arbitration_isValid <= 1'b0;
      end
      if(((! fetch_arbitration_isStuck) && (! fetch_arbitration_removeIt)))begin
        decode_arbitration_isValid <= fetch_arbitration_isValid;
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
        12'b001101100000 : begin
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_435[0];
            CsrPlugin_mstatus_MIE <= _zz_436[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_437[0];
          end
        end
        12'b110011000000 : begin
        end
        12'b001101000011 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_438[0];
            CsrPlugin_mie_MTIE <= _zz_439[0];
            CsrPlugin_mie_MSIE <= _zz_440[0];
          end
        end
        12'b001100110000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_198 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_355)begin
        if(iBusWishbone_ACK)begin
          _zz_269 <= (_zz_269 + (3'b001));
        end
      end
      _zz_270 <= (_zz_308 && iBusWishbone_ACK);
      if((_zz_273 && _zz_274))begin
        _zz_272 <= (_zz_272 + (3'b001));
        if(_zz_276)begin
          _zz_272 <= (3'b000);
        end
      end
      _zz_278 <= ((_zz_273 && (! _zz_309)) && dBusWishbone_ACK);
    end
  end

  always @ (posedge clk) begin
    if(_zz_350)begin
      if(_zz_352)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_412[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_157[32]) ? _zz_413 : _zz_414);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_415[31:0];
        end
      end
    end
    if(_zz_347)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_160 ? (~ _zz_161) : _zz_161) + _zz_421);
      memory_DivPlugin_rs2 <= ((_zz_159 ? (~ execute_RS2) : execute_RS2) + _zz_423);
      memory_DivPlugin_div_needRevert <= (_zz_160 ^ (_zz_159 && (! execute_INSTRUCTION[13])));
    end
    _zz_165 <= _zz_55[11 : 7];
    _zz_166 <= _zz_85;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(_zz_345)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= _zz_311;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= _zz_312;
    end
    if(_zz_348)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (4'b0000);
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= _zz_106;
    end
    if(_zz_354)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= _zz_104;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= _zz_337;
    end
    if(_zz_353)begin
      CsrPlugin_mepc <= _zz_196;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interrupt;
      CsrPlugin_mcause_exceptionCode <= ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_432);
    end
    _zz_197 <= CsrPlugin_exception;
    if(_zz_197)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    _zz_199 <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      _zz_201 <= _zz_24;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_202 <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_203 <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_204 <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_205 <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_206 <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_207 <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_208 <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_209 <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_210 <= memory_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_211 <= execute_MUL_LL;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_212 <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_213 <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_214 <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_215 <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_216 <= execute_FLUSH_ALL;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_217 <= decode_SRC_LESS_UNSIGNED;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_218 <= memory_MUL_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_219 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_220 <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_221 <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_222 <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_223 <= execute_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_224 <= execute_MUL_HL;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_225 <= _zz_89;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_226 <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_227 <= execute_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_229 <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_230 <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_231 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_232 <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_233 <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_234 <= memory_IS_MUL;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_235 <= decode_MEMORY_MANAGMENT;
    end
    if((! fetch_arbitration_isStuck))begin
      _zz_236 <= prefetch_FORMAL_PC_NEXT;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_237 <= fetch_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_238 <= _zz_95;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_239 <= _zz_94;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_240 <= _zz_21;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_241 <= _zz_18;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_242 <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_243 <= decode_INSTRUCTION_READY;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_244 <= execute_INSTRUCTION_READY;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_245 <= execute_MUL_LH;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_246 <= _zz_15;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_247 <= _zz_13;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_248 <= _zz_10;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_249 <= _zz_8;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_250 <= _zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_251 <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_252 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_253 <= decode_IS_RS2_SIGNED;
    end
    if((! fetch_arbitration_isStuck))begin
      _zz_254 <= _zz_93;
    end
    if((! decode_arbitration_isStuck))begin
      _zz_255 <= _zz_92;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_256 <= _zz_87;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_257 <= _zz_47;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_258 <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_259 <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_260 <= decode_IS_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_261 <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_262 <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      _zz_263 <= memory_MEMORY_WR;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_264 <= decode_IS_CSR;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_265 <= _zz_34;
    end
    if((! memory_arbitration_isStuck))begin
      _zz_267 <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      _zz_268 <= _zz_2;
    end
    if (!(prefetch_arbitration_removeIt == 1'b0)) begin
      $display("ERROR removeIt should never be asserted on this stage");
    end
    if(DebugPlugin_insertDecodeInstruction)begin
      _zz_225 <= debug_bus_cmd_payload_data;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b001101100000 : begin
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
      12'b110011000000 : begin
      end
      12'b001101000011 : begin
      end
      12'b001100000100 : begin
      end
      12'b001100110000 : begin
      end
      12'b001101000010 : begin
      end
      default : begin
      end
    endcase
    _zz_271 <= iBusWishbone_DAT_MISO;
    _zz_279 <= dBusWishbone_DAT_MISO;
  end

  always @ (posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(_zz_307)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipActive <= ((((fetch_arbitration_isValid || decode_arbitration_isValid) || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid);
    _zz_174 <= DebugPlugin_isPipActive;
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_85;
    end
    _zz_175 <= debug_bus_cmd_payload_address[2];
    _zz_176 <= DebugPlugin_resetIt;
  end

  always @ (posedge clk) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if(debug_bus_cmd_valid)begin
        case(_zz_349)
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
      if(_zz_346)begin
        DebugPlugin_haltIt <= 1'b1;
        DebugPlugin_haltedByBreak <= 1'b1;
      end
      if((DebugPlugin_stepIt && prefetch_arbitration_isFiring))begin
        DebugPlugin_haltIt <= 1'b1;
      end
      if((DebugPlugin_stepIt && ({writeBack_arbitration_redoIt,{memory_arbitration_redoIt,{execute_arbitration_redoIt,{decode_arbitration_redoIt,{fetch_arbitration_redoIt,prefetch_arbitration_redoIt}}}}} != (6'b000000))))begin
        DebugPlugin_haltIt <= 1'b0;
      end
    end
  end

endmodule

