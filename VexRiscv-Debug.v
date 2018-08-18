// Generator : SpinalHDL v1.1.6    git head : 2643ea2afba86dc6321cd50da8126412cf13d7ec
// Date      : 18/08/2018, 22:23:58
// Component : VexRiscv


`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

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

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_PC_INCREMENT 2'b10

`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define EnvCtrlEnum_binary_sequancial_type [1:0]
`define EnvCtrlEnum_binary_sequancial_NONE 2'b00
`define EnvCtrlEnum_binary_sequancial_EBREAK 2'b01
`define EnvCtrlEnum_binary_sequancial_MRET 2'b10

`define DataCacheCpuCmdKind_binary_sequancial_type [0:0]
`define DataCacheCpuCmdKind_binary_sequancial_MEMORY 1'b0
`define DataCacheCpuCmdKind_binary_sequancial_MANAGMENT 1'b1

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
  reg [21:0] _zz_13;
  reg [31:0] _zz_14;
  wire  _zz_15;
  wire  _zz_16;
  wire  _zz_17;
  wire [0:0] _zz_18;
  wire [0:0] _zz_19;
  wire [21:0] _zz_20;
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
  reg  decodeStage_mmuRsp_hit;
  reg  decodeStage_hit_tags_0_valid;
  reg  decodeStage_hit_tags_0_error;
  reg [19:0] decodeStage_hit_tags_0_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_valid;
  wire  decodeStage_hit_error;
  reg [31:0] _zz_12;
  wire [31:0] decodeStage_hit_data;
  wire [31:0] decodeStage_hit_word;
  reg [21:0] ways_0_tags [0:127];
  reg [31:0] ways_0_datas [0:1023];
  assign io_flush_cmd_ready = _zz_15;
  assign io_mem_cmd_valid = _zz_16;
  assign _zz_17 = (! lineLoader_flushCounter[7]);
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
  assign _zz_4 = lineLoader_flushCounter[7];
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
  assign _zz_9 = _zz_13;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_18[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_19[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_9[21 : 2];
  assign _zz_10 = io_cpu_prefetch_pc[11 : 2];
  assign _zz_11 = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_14;
  assign io_cpu_fetch_data = fetchStage_read_waysValues_0_data[31 : 0];
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 12]));
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
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(_zz_17)begin
        lineLoader_flushCounter <= (lineLoader_flushCounter + (8'b00000001));
      end
      if(io_flush_cmd_valid)begin
        if(_zz_15)begin
          lineLoader_flushCounter <= (8'b00000000);
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
      input   io_cpu_memory_mmuBus_rsp_hit,
      output  io_cpu_memory_mmuBus_end,
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
  reg  stageB_mmuRsp_hit;
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
  assign _zz_46 = (! _zz_27);
  assign _zz_47 = (! io_cpu_writeBack_isStuck);
  assign _zz_48 = (! victim_readLineCmdCounter[3]);
  assign _zz_49 = (! _zz_40);
  assign _zz_50 = (stageB_mmuRsp_physicalAddress[11 : 5] != (7'b1111111));
  assign _zz_51 = ((! victim_memCmdAlreadyUsed) && io_mem_cmd_ready);
  assign _zz_52 = (! victim_request_valid);
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
      if(_zz_48)begin
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
      if(_zz_50)begin
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
              if(_zz_52)begin
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
  assign io_cpu_memory_mmuBus_end = ((! io_cpu_memory_isStuck) || io_cpu_memory_isRemoved);
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
    if(_zz_46)begin
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
    if(_zz_47)begin
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuBus_rsp_isIoAccess;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuBus_rsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuBus_rsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuBus_rsp_allowExecute;
      stageB_mmuRsp_allowUser <= io_cpu_memory_mmuBus_rsp_allowUser;
      stageB_mmuRsp_miss <= io_cpu_memory_mmuBus_rsp_miss;
      stageB_mmuRsp_hit <= io_cpu_memory_mmuBus_rsp_hit;
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
      if(_zz_46)begin
        _zz_27 <= victim_requestIn_valid;
        _zz_28 <= (! victim_requestIn_valid);
      end else begin
        _zz_27 <= (! victim_request_ready);
        _zz_28 <= victim_request_ready;
      end
      if(victim_request_valid)begin
        if(_zz_48)begin
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
      if(_zz_47)begin
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
        if(_zz_50)begin
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
      if(_zz_52)begin
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
      output [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset,
      input   debugReset);
  reg  _zz_224;
  wire  _zz_225;
  wire  _zz_226;
  wire  _zz_227;
  wire  _zz_228;
  wire  _zz_229;
  wire  _zz_230;
  wire  _zz_231;
  wire  _zz_232;
  wire  _zz_233;
  wire  _zz_234;
  wire `DataCacheCpuCmdKind_binary_sequancial_type _zz_235;
  wire [31:0] _zz_236;
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
  wire  _zz_247;
  wire  _zz_248;
  reg [31:0] _zz_249;
  reg [31:0] _zz_250;
  reg  _zz_251;
  reg  _zz_252;
  wire  _zz_253;
  reg [31:0] _zz_254;
  reg [3:0] _zz_255;
  reg [31:0] _zz_256;
  wire  _zz_257;
  wire  _zz_258;
  wire  _zz_259;
  wire [31:0] _zz_260;
  wire [31:0] _zz_261;
  wire  _zz_262;
  wire [31:0] _zz_263;
  wire  _zz_264;
  wire  _zz_265;
  wire  _zz_266;
  wire  _zz_267;
  wire  _zz_268;
  wire [31:0] _zz_269;
  wire  _zz_270;
  wire [31:0] _zz_271;
  wire  _zz_272;
  wire [31:0] _zz_273;
  wire [2:0] _zz_274;
  wire  _zz_275;
  wire  _zz_276;
  wire [31:0] _zz_277;
  wire  _zz_278;
  wire  _zz_279;
  wire  _zz_280;
  wire [31:0] _zz_281;
  wire  _zz_282;
  wire  _zz_283;
  wire  _zz_284;
  wire  _zz_285;
  wire [31:0] _zz_286;
  wire  _zz_287;
  wire  _zz_288;
  wire [31:0] _zz_289;
  wire [31:0] _zz_290;
  wire [3:0] _zz_291;
  wire [2:0] _zz_292;
  wire  _zz_293;
  wire  _zz_294;
  wire  _zz_295;
  wire  _zz_296;
  wire  _zz_297;
  wire [0:0] _zz_298;
  wire  _zz_299;
  wire  _zz_300;
  wire  _zz_301;
  wire  _zz_302;
  wire  _zz_303;
  wire [1:0] _zz_304;
  wire [1:0] _zz_305;
  wire [1:0] _zz_306;
  wire  _zz_307;
  wire [3:0] _zz_308;
  wire [2:0] _zz_309;
  wire [31:0] _zz_310;
  wire [11:0] _zz_311;
  wire [31:0] _zz_312;
  wire [19:0] _zz_313;
  wire [11:0] _zz_314;
  wire [2:0] _zz_315;
  wire [2:0] _zz_316;
  wire [0:0] _zz_317;
  wire [0:0] _zz_318;
  wire [0:0] _zz_319;
  wire [0:0] _zz_320;
  wire [0:0] _zz_321;
  wire [0:0] _zz_322;
  wire [0:0] _zz_323;
  wire [0:0] _zz_324;
  wire [0:0] _zz_325;
  wire [0:0] _zz_326;
  wire [0:0] _zz_327;
  wire [0:0] _zz_328;
  wire [0:0] _zz_329;
  wire [0:0] _zz_330;
  wire [0:0] _zz_331;
  wire [0:0] _zz_332;
  wire [0:0] _zz_333;
  wire [0:0] _zz_334;
  wire [2:0] _zz_335;
  wire [11:0] _zz_336;
  wire [11:0] _zz_337;
  wire [31:0] _zz_338;
  wire [31:0] _zz_339;
  wire [31:0] _zz_340;
  wire [31:0] _zz_341;
  wire [1:0] _zz_342;
  wire [31:0] _zz_343;
  wire [1:0] _zz_344;
  wire [1:0] _zz_345;
  wire [32:0] _zz_346;
  wire [31:0] _zz_347;
  wire [32:0] _zz_348;
  wire [51:0] _zz_349;
  wire [51:0] _zz_350;
  wire [51:0] _zz_351;
  wire [32:0] _zz_352;
  wire [51:0] _zz_353;
  wire [49:0] _zz_354;
  wire [51:0] _zz_355;
  wire [49:0] _zz_356;
  wire [51:0] _zz_357;
  wire [65:0] _zz_358;
  wire [65:0] _zz_359;
  wire [31:0] _zz_360;
  wire [31:0] _zz_361;
  wire [0:0] _zz_362;
  wire [5:0] _zz_363;
  wire [32:0] _zz_364;
  wire [32:0] _zz_365;
  wire [31:0] _zz_366;
  wire [31:0] _zz_367;
  wire [32:0] _zz_368;
  wire [32:0] _zz_369;
  wire [32:0] _zz_370;
  wire [0:0] _zz_371;
  wire [32:0] _zz_372;
  wire [0:0] _zz_373;
  wire [32:0] _zz_374;
  wire [0:0] _zz_375;
  wire [31:0] _zz_376;
  wire [11:0] _zz_377;
  wire [11:0] _zz_378;
  wire [2:0] _zz_379;
  wire [31:0] _zz_380;
  wire [1:0] _zz_381;
  wire [1:0] _zz_382;
  wire [2:0] _zz_383;
  wire [3:0] _zz_384;
  wire [4:0] _zz_385;
  wire [31:0] _zz_386;
  wire [0:0] _zz_387;
  wire [0:0] _zz_388;
  wire [0:0] _zz_389;
  wire [0:0] _zz_390;
  wire [0:0] _zz_391;
  wire [0:0] _zz_392;
  wire [26:0] _zz_393;
  wire [1:0] _zz_394;
  wire [0:0] _zz_395;
  wire [7:0] _zz_396;
  wire  _zz_397;
  wire [0:0] _zz_398;
  wire [0:0] _zz_399;
  wire  _zz_400;
  wire [0:0] _zz_401;
  wire [0:0] _zz_402;
  wire [0:0] _zz_403;
  wire [0:0] _zz_404;
  wire  _zz_405;
  wire [0:0] _zz_406;
  wire [24:0] _zz_407;
  wire [31:0] _zz_408;
  wire [31:0] _zz_409;
  wire  _zz_410;
  wire [0:0] _zz_411;
  wire [2:0] _zz_412;
  wire [3:0] _zz_413;
  wire [3:0] _zz_414;
  wire  _zz_415;
  wire [0:0] _zz_416;
  wire [21:0] _zz_417;
  wire  _zz_418;
  wire  _zz_419;
  wire [0:0] _zz_420;
  wire [0:0] _zz_421;
  wire [31:0] _zz_422;
  wire [31:0] _zz_423;
  wire [0:0] _zz_424;
  wire [0:0] _zz_425;
  wire [0:0] _zz_426;
  wire [0:0] _zz_427;
  wire  _zz_428;
  wire [0:0] _zz_429;
  wire [18:0] _zz_430;
  wire [31:0] _zz_431;
  wire [31:0] _zz_432;
  wire [31:0] _zz_433;
  wire [31:0] _zz_434;
  wire [31:0] _zz_435;
  wire [0:0] _zz_436;
  wire [1:0] _zz_437;
  wire [1:0] _zz_438;
  wire [1:0] _zz_439;
  wire  _zz_440;
  wire [0:0] _zz_441;
  wire [15:0] _zz_442;
  wire [31:0] _zz_443;
  wire [31:0] _zz_444;
  wire [31:0] _zz_445;
  wire [31:0] _zz_446;
  wire [31:0] _zz_447;
  wire [31:0] _zz_448;
  wire [31:0] _zz_449;
  wire [0:0] _zz_450;
  wire [3:0] _zz_451;
  wire [0:0] _zz_452;
  wire [4:0] _zz_453;
  wire [1:0] _zz_454;
  wire [1:0] _zz_455;
  wire  _zz_456;
  wire [0:0] _zz_457;
  wire [12:0] _zz_458;
  wire [31:0] _zz_459;
  wire [31:0] _zz_460;
  wire  _zz_461;
  wire [0:0] _zz_462;
  wire [0:0] _zz_463;
  wire [31:0] _zz_464;
  wire [31:0] _zz_465;
  wire  _zz_466;
  wire [0:0] _zz_467;
  wire [1:0] _zz_468;
  wire [31:0] _zz_469;
  wire [31:0] _zz_470;
  wire [0:0] _zz_471;
  wire [0:0] _zz_472;
  wire [0:0] _zz_473;
  wire [0:0] _zz_474;
  wire  _zz_475;
  wire [0:0] _zz_476;
  wire [9:0] _zz_477;
  wire [31:0] _zz_478;
  wire [31:0] _zz_479;
  wire [31:0] _zz_480;
  wire [31:0] _zz_481;
  wire [31:0] _zz_482;
  wire [31:0] _zz_483;
  wire [31:0] _zz_484;
  wire [31:0] _zz_485;
  wire [31:0] _zz_486;
  wire [31:0] _zz_487;
  wire [0:0] _zz_488;
  wire [0:0] _zz_489;
  wire [0:0] _zz_490;
  wire [0:0] _zz_491;
  wire  _zz_492;
  wire [0:0] _zz_493;
  wire [7:0] _zz_494;
  wire [31:0] _zz_495;
  wire [31:0] _zz_496;
  wire [31:0] _zz_497;
  wire [31:0] _zz_498;
  wire [31:0] _zz_499;
  wire [0:0] _zz_500;
  wire [0:0] _zz_501;
  wire  _zz_502;
  wire [0:0] _zz_503;
  wire [4:0] _zz_504;
  wire [31:0] _zz_505;
  wire [31:0] _zz_506;
  wire  _zz_507;
  wire [31:0] _zz_508;
  wire [31:0] _zz_509;
  wire [0:0] _zz_510;
  wire [3:0] _zz_511;
  wire [1:0] _zz_512;
  wire [1:0] _zz_513;
  wire  _zz_514;
  wire [0:0] _zz_515;
  wire [0:0] _zz_516;
  wire  _zz_517;
  wire [0:0] _zz_518;
  wire [0:0] _zz_519;
  wire [31:0] _zz_520;
  wire [31:0] _zz_521;
  wire [31:0] _zz_522;
  wire [31:0] _zz_523;
  wire  _zz_524;
  wire [0:0] _zz_525;
  wire [0:0] _zz_526;
  wire [0:0] _zz_527;
  wire [3:0] _zz_528;
  wire  _zz_529;
  wire [31:0] _zz_530;
  wire [31:0] _zz_531;
  wire [31:0] _zz_532;
  wire [31:0] _zz_533;
  wire [31:0] _zz_534;
  wire [31:0] _zz_535;
  wire [31:0] _zz_536;
  wire [0:0] _zz_537;
  wire [0:0] _zz_538;
  wire [31:0] _zz_539;
  wire [31:0] _zz_540;
  wire [31:0] _zz_541;
  wire  _zz_542;
  wire [0:0] _zz_543;
  wire [13:0] _zz_544;
  wire [31:0] _zz_545;
  wire [31:0] _zz_546;
  wire [31:0] _zz_547;
  wire  _zz_548;
  wire [0:0] _zz_549;
  wire [7:0] _zz_550;
  wire [31:0] _zz_551;
  wire [31:0] _zz_552;
  wire [31:0] _zz_553;
  wire  _zz_554;
  wire [0:0] _zz_555;
  wire [1:0] _zz_556;
  wire [51:0] memory_MUL_LOW;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire [31:0] execute_SHIFT_RIGHT;
  wire  decode_IS_RS2_SIGNED;
  wire [31:0] memory_PC;
  wire  decode_IS_DIV;
  wire  decode_IS_EBREAK;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  decode_SRC_LESS_UNSIGNED;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire [33:0] execute_MUL_HL;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire  execute_BRANCH_DO;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_1;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_2;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_3;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_4;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_5;
  wire  decode_IS_RS1_SIGNED;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_6;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_7;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_8;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire  decode_CSR_WRITE_OPCODE;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_9;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_10;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_11;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_12;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_13;
  wire [31:0] execute_BRANCH_CALC;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_14;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_15;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_16;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire  decode_MEMORY_MANAGMENT;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_17;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_18;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_19;
  wire [33:0] execute_MUL_LH;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_20;
  wire `AluCtrlEnum_binary_sequancial_type _zz_21;
  wire `AluCtrlEnum_binary_sequancial_type _zz_22;
  wire [31:0] execute_MUL_LL;
  wire  decode_CSR_READ_OPCODE;
  wire  decode_MEMORY_ENABLE;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire  execute_IS_EBREAK;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  execute_IS_CSR;
  wire  decode_IS_CSR;
  wire  _zz_23;
  wire  _zz_24;
  wire `EnvCtrlEnum_binary_sequancial_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_25;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_26;
  wire [31:0] execute_PC;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_27;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_28;
  wire  _zz_29;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_30;
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
  wire [51:0] _zz_31;
  wire [33:0] _zz_32;
  wire [33:0] _zz_33;
  wire [33:0] _zz_34;
  wire [31:0] _zz_35;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_36;
  wire `ShiftCtrlEnum_binary_sequancial_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_37;
  wire [31:0] _zz_38;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_39;
  wire  _zz_40;
  wire [31:0] _zz_41;
  wire [31:0] _zz_42;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_43;
  wire `Src2CtrlEnum_binary_sequancial_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_44;
  wire [31:0] _zz_45;
  wire `Src1CtrlEnum_binary_sequancial_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_46;
  wire [31:0] _zz_47;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_48;
  wire [31:0] _zz_49;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_50;
  wire [31:0] _zz_51;
  wire  _zz_52;
  reg  _zz_53;
  wire [31:0] _zz_54;
  wire [31:0] _zz_55;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire  _zz_56;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_57;
  wire  _zz_58;
  wire  _zz_59;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_60;
  wire  _zz_61;
  wire  _zz_62;
  wire  _zz_63;
  wire  _zz_64;
  wire  _zz_65;
  wire  _zz_66;
  wire  _zz_67;
  wire  _zz_68;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_69;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_70;
  wire `AluCtrlEnum_binary_sequancial_type _zz_71;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_72;
  wire  _zz_73;
  wire  _zz_74;
  wire  _zz_75;
  wire  _zz_76;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_77;
  wire  _zz_78;
  wire  _zz_79;
  wire  _zz_80;
  reg [31:0] _zz_81;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire  writeBack_MEMORY_ENABLE;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_82;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_WR;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_issueDetected;
  reg  _zz_83;
  wire [31:0] _zz_84;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_85;
  reg [31:0] _zz_86;
  reg [31:0] _zz_87;
  wire [31:0] _zz_88;
  wire  _zz_89;
  wire [31:0] _zz_90;
  wire [31:0] _zz_91;
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
  reg  _zz_92;
  reg  _zz_93;
  reg  _zz_94;
  wire  _zz_95;
  wire [31:0] _zz_96;
  wire  _zz_97;
  wire  _zz_98;
  wire [31:0] _zz_99;
  reg  _zz_100;
  wire [31:0] _zz_101;
  wire  _zz_102;
  wire  _zz_103;
  wire [31:0] _zz_104;
  wire  _zz_105;
  wire  _zz_106;
  wire  writeBack_exception_agregat_valid;
  reg [3:0] writeBack_exception_agregat_payload_code;
  wire [31:0] writeBack_exception_agregat_payload_badAddr;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  _zz_107;
  wire [31:0] _zz_108;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_109;
  reg [31:0] _zz_110;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_111;
  reg  _zz_112;
  reg  _zz_113;
  reg  _zz_114;
  reg  _zz_115;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_116;
  wire [3:0] _zz_117;
  wire  _zz_118;
  wire  _zz_119;
  wire  _zz_120;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_121;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_122;
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
  wire  _zz_123;
  reg  _zz_124;
  reg [31:0] _zz_125;
  wire  _zz_126;
  wire  _zz_127;
  wire  _zz_128;
  reg  _zz_129;
  reg [31:0] _zz_130;
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
  wire  _zz_131;
  reg [18:0] _zz_132;
  wire  _zz_133;
  reg [10:0] _zz_134;
  wire  _zz_135;
  reg [18:0] _zz_136;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  _zz_137;
  wire  IBusCachedPlugin_iBusRspOutputHalt;
  wire  _zz_138;
  reg  IBusCachedPlugin_redoFetch;
  wire  _zz_139;
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
  reg [31:0] _zz_140;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_141;
  reg [31:0] _zz_142;
  wire  _zz_143;
  reg [31:0] _zz_144;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  wire [30:0] _zz_145;
  wire  _zz_146;
  wire  _zz_147;
  wire  _zz_148;
  wire  _zz_149;
  wire  _zz_150;
  wire  _zz_151;
  wire  _zz_152;
  wire  _zz_153;
  wire  _zz_154;
  wire  _zz_155;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_156;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_157;
  wire `AluCtrlEnum_binary_sequancial_type _zz_158;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_159;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_160;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_161;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_162;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_163;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_164;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_165;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_166;
  reg [31:0] _zz_167;
  wire  _zz_168;
  reg [19:0] _zz_169;
  wire  _zz_170;
  reg [19:0] _zz_171;
  reg [31:0] _zz_172;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
  reg [31:0] _zz_173;
  wire [31:0] execute_FullBarrelShifterPlugin_reversed;
  reg [31:0] _zz_174;
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
  wire [31:0] _zz_175;
  wire [32:0] _zz_176;
  wire [32:0] _zz_177;
  wire [31:0] _zz_178;
  wire  _zz_179;
  wire  _zz_180;
  reg [32:0] _zz_181;
  reg  _zz_182;
  reg  _zz_183;
  reg  _zz_184;
  reg [4:0] _zz_185;
  reg [31:0] _zz_186;
  wire  _zz_187;
  wire  _zz_188;
  wire  _zz_189;
  wire  _zz_190;
  wire  _zz_191;
  wire  _zz_192;
  wire  _zz_193;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_194;
  reg  _zz_195;
  reg  _zz_196;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_197;
  reg [19:0] _zz_198;
  wire  _zz_199;
  reg [18:0] _zz_200;
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
  reg [63:0] CsrPlugin_mcycle = 64'b1000011001000111000111100111001110111100010111110010100010111100;
  reg [63:0] CsrPlugin_minstret = 64'b0000011010111100100100001100101101000000001101000000011110010010;
  reg  CsrPlugin_pipelineLiberator_enable;
  wire  CsrPlugin_pipelineLiberator_done;
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
  wire [1:0] _zz_201;
  wire  _zz_202;
  wire [0:0] _zz_203;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_writeBackWasWfi;
  reg  _zz_204;
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
  reg [31:0] _zz_205;
  reg [31:0] _zz_206;
  wire [31:0] _zz_207;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipActive;
  reg  _zz_208;
  wire  DebugPlugin_isPipBusy;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_209;
  reg  _zz_210;
  reg  decode_to_execute_MEMORY_WR;
  reg  execute_to_memory_MEMORY_WR;
  reg  memory_to_writeBack_MEMORY_WR;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg [31:0] execute_to_memory_MUL_LL;
  reg `AluCtrlEnum_binary_sequancial_type decode_to_execute_ALU_CTRL;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg [33:0] execute_to_memory_MUL_LH;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type decode_to_execute_ALU_BITWISE_CTRL;
  reg  decode_to_execute_MEMORY_MANAGMENT;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg `EnvCtrlEnum_binary_sequancial_type decode_to_execute_ENV_CTRL;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg `ShiftCtrlEnum_binary_sequancial_type decode_to_execute_SHIFT_CTRL;
  reg `ShiftCtrlEnum_binary_sequancial_type execute_to_memory_SHIFT_CTRL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg `Src1CtrlEnum_binary_sequancial_type decode_to_execute_SRC1_CTRL;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg `BranchCtrlEnum_binary_sequancial_type decode_to_execute_BRANCH_CTRL;
  reg `Src2CtrlEnum_binary_sequancial_type decode_to_execute_SRC2_CTRL;
  reg  execute_to_memory_BRANCH_DO;
  reg [31:0] decode_to_execute_RS2;
  reg [31:0] decode_to_execute_RS1;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg [33:0] execute_to_memory_MUL_HL;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  decode_to_execute_IS_EBREAK;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg  decode_to_execute_IS_CSR;
  reg [31:0] execute_to_memory_SHIFT_RIGHT;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [2:0] _zz_211;
  reg [31:0] _zz_212;
  reg [2:0] _zz_213;
  reg  _zz_214;
  reg [31:0] _zz_215;
  reg [2:0] _zz_216;
  wire  _zz_217;
  wire  _zz_218;
  wire  _zz_219;
  wire  _zz_220;
  wire  _zz_221;
  reg  _zz_222;
  reg [31:0] _zz_223;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign debug_bus_cmd_ready = _zz_251;
  assign iBusWishbone_CYC = _zz_252;
  assign dBusWishbone_WE = _zz_253;
  assign _zz_294 = (! memory_arbitration_isStuck);
  assign _zz_295 = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  assign _zz_296 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_297 = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_298 = debug_bus_cmd_payload_address[2 : 2];
  assign _zz_299 = (CsrPlugin_exception || (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done));
  assign _zz_300 = (DebugPlugin_stepIt && _zz_94);
  assign _zz_301 = (! memory_DivPlugin_div_done);
  assign _zz_302 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET));
  assign _zz_303 = (iBus_cmd_valid || (_zz_213 != (3'b000)));
  assign _zz_304 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_305 = execute_INSTRUCTION[13 : 12];
  assign _zz_306 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_307 = execute_INSTRUCTION[13];
  assign _zz_308 = (_zz_116 - (4'b0001));
  assign _zz_309 = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_310 = {29'd0, _zz_309};
  assign _zz_311 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_312 = {{_zz_132,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_313 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_314 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_315 = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_316 = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_317 = _zz_145[0 : 0];
  assign _zz_318 = _zz_145[1 : 1];
  assign _zz_319 = _zz_145[4 : 4];
  assign _zz_320 = _zz_145[5 : 5];
  assign _zz_321 = _zz_145[6 : 6];
  assign _zz_322 = _zz_145[7 : 7];
  assign _zz_323 = _zz_145[16 : 16];
  assign _zz_324 = _zz_145[17 : 17];
  assign _zz_325 = _zz_145[18 : 18];
  assign _zz_326 = _zz_145[19 : 19];
  assign _zz_327 = _zz_145[20 : 20];
  assign _zz_328 = _zz_145[21 : 21];
  assign _zz_329 = _zz_145[22 : 22];
  assign _zz_330 = _zz_145[23 : 23];
  assign _zz_331 = _zz_145[26 : 26];
  assign _zz_332 = _zz_145[27 : 27];
  assign _zz_333 = _zz_145[30 : 30];
  assign _zz_334 = execute_SRC_LESS;
  assign _zz_335 = (3'b100);
  assign _zz_336 = execute_INSTRUCTION[31 : 20];
  assign _zz_337 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_338 = ($signed(_zz_339) + $signed(_zz_343));
  assign _zz_339 = ($signed(_zz_340) + $signed(_zz_341));
  assign _zz_340 = execute_SRC1;
  assign _zz_341 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_342 = (execute_SRC_USE_SUB_LESS ? _zz_344 : _zz_345);
  assign _zz_343 = {{30{_zz_342[1]}}, _zz_342};
  assign _zz_344 = (2'b01);
  assign _zz_345 = (2'b00);
  assign _zz_346 = ($signed(_zz_348) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_347 = _zz_346[31 : 0];
  assign _zz_348 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_349 = ($signed(_zz_350) + $signed(_zz_355));
  assign _zz_350 = ($signed(_zz_351) + $signed(_zz_353));
  assign _zz_351 = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_352 = {1'b0,memory_MUL_LL};
  assign _zz_353 = {{19{_zz_352[32]}}, _zz_352};
  assign _zz_354 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_355 = {{2{_zz_354[49]}}, _zz_354};
  assign _zz_356 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_357 = {{2{_zz_356[49]}}, _zz_356};
  assign _zz_358 = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_359 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_360 = writeBack_MUL_LOW[31 : 0];
  assign _zz_361 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_362 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_363 = {5'd0, _zz_362};
  assign _zz_364 = {1'd0, memory_DivPlugin_rs2};
  assign _zz_365 = {_zz_175,(! _zz_177[32])};
  assign _zz_366 = _zz_177[31:0];
  assign _zz_367 = _zz_176[31:0];
  assign _zz_368 = _zz_369;
  assign _zz_369 = _zz_370;
  assign _zz_370 = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_178) : _zz_178)} + _zz_372);
  assign _zz_371 = memory_DivPlugin_div_needRevert;
  assign _zz_372 = {32'd0, _zz_371};
  assign _zz_373 = _zz_180;
  assign _zz_374 = {32'd0, _zz_373};
  assign _zz_375 = _zz_179;
  assign _zz_376 = {31'd0, _zz_375};
  assign _zz_377 = execute_INSTRUCTION[31 : 20];
  assign _zz_378 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_379 = (3'b100);
  assign _zz_380 = {29'd0, _zz_379};
  assign _zz_381 = (_zz_201 & (~ _zz_382));
  assign _zz_382 = (_zz_201 - (2'b01));
  assign _zz_383 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_384 = {1'd0, _zz_383};
  assign _zz_385 = execute_INSTRUCTION[19 : 15];
  assign _zz_386 = {27'd0, _zz_385};
  assign _zz_387 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_388 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_389 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_390 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_391 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_392 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_393 = (iBus_cmd_payload_address >>> 5);
  assign _zz_394 = {_zz_120,_zz_119};
  assign _zz_395 = decode_INSTRUCTION[31];
  assign _zz_396 = decode_INSTRUCTION[19 : 12];
  assign _zz_397 = decode_INSTRUCTION[20];
  assign _zz_398 = decode_INSTRUCTION[31];
  assign _zz_399 = decode_INSTRUCTION[7];
  assign _zz_400 = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_401 = _zz_147;
  assign _zz_402 = ((decode_INSTRUCTION & _zz_408) == (32'b00000000000000000010000000000000));
  assign _zz_403 = ((decode_INSTRUCTION & _zz_409) == (32'b00000000000000000000000000100000));
  assign _zz_404 = (1'b0);
  assign _zz_405 = ({_zz_146,_zz_410} != (2'b00));
  assign _zz_406 = ({_zz_411,_zz_412} != (4'b0000));
  assign _zz_407 = {(_zz_413 != _zz_414),{_zz_415,{_zz_416,_zz_417}}};
  assign _zz_408 = (32'b00000000000000000011000000000000);
  assign _zz_409 = (32'b00000000000000000000000000100000);
  assign _zz_410 = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000000000000));
  assign _zz_411 = _zz_155;
  assign _zz_412 = {_zz_152,{_zz_418,_zz_419}};
  assign _zz_413 = {_zz_155,{_zz_152,{_zz_420,_zz_421}}};
  assign _zz_414 = (4'b0000);
  assign _zz_415 = ((_zz_422 == _zz_423) != (1'b0));
  assign _zz_416 = ({_zz_424,_zz_425} != (2'b00));
  assign _zz_417 = {(_zz_426 != _zz_427),{_zz_428,{_zz_429,_zz_430}}};
  assign _zz_418 = ((decode_INSTRUCTION & (32'b00000000000000000000000000001100)) == (32'b00000000000000000000000000000100));
  assign _zz_419 = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_420 = _zz_154;
  assign _zz_421 = _zz_153;
  assign _zz_422 = (decode_INSTRUCTION & (32'b00000000000000000000000000001000));
  assign _zz_423 = (32'b00000000000000000000000000001000);
  assign _zz_424 = ((decode_INSTRUCTION & _zz_431) == (32'b00000000000000000010000000000000));
  assign _zz_425 = ((decode_INSTRUCTION & _zz_432) == (32'b00000000000000000001000000000000));
  assign _zz_426 = ((decode_INSTRUCTION & _zz_433) == (32'b00000000000000000000000000001000));
  assign _zz_427 = (1'b0);
  assign _zz_428 = ((_zz_434 == _zz_435) != (1'b0));
  assign _zz_429 = ({_zz_436,_zz_437} != (3'b000));
  assign _zz_430 = {(_zz_438 != _zz_439),{_zz_440,{_zz_441,_zz_442}}};
  assign _zz_431 = (32'b00000000000000000010000000010000);
  assign _zz_432 = (32'b00000000000000000101000000000000);
  assign _zz_433 = (32'b00000000000000000001000001001000);
  assign _zz_434 = (decode_INSTRUCTION & (32'b00100000000000000011000001010000));
  assign _zz_435 = (32'b00000000000000000000000001010000);
  assign _zz_436 = ((decode_INSTRUCTION & _zz_443) == (32'b00000000000000000001000000001000));
  assign _zz_437 = {(_zz_444 == _zz_445),_zz_149};
  assign _zz_438 = {(_zz_446 == _zz_447),(_zz_448 == _zz_449)};
  assign _zz_439 = (2'b00);
  assign _zz_440 = ({_zz_148,{_zz_450,_zz_451}} != (6'b000000));
  assign _zz_441 = ({_zz_452,_zz_453} != (6'b000000));
  assign _zz_442 = {(_zz_454 != _zz_455),{_zz_456,{_zz_457,_zz_458}}};
  assign _zz_443 = (32'b00000000000000000001000001001000);
  assign _zz_444 = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_445 = (32'b00000000000000000000000000100000);
  assign _zz_446 = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_447 = (32'b00000000000000000001000001010000);
  assign _zz_448 = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_449 = (32'b00000000000000000010000001010000);
  assign _zz_450 = _zz_147;
  assign _zz_451 = {(_zz_459 == _zz_460),{_zz_461,{_zz_462,_zz_463}}};
  assign _zz_452 = _zz_152;
  assign _zz_453 = {(_zz_464 == _zz_465),{_zz_466,{_zz_467,_zz_468}}};
  assign _zz_454 = {_zz_152,_zz_151};
  assign _zz_455 = (2'b00);
  assign _zz_456 = ((_zz_469 == _zz_470) != (1'b0));
  assign _zz_457 = ({_zz_471,_zz_472} != (2'b00));
  assign _zz_458 = {(_zz_473 != _zz_474),{_zz_475,{_zz_476,_zz_477}}};
  assign _zz_459 = (decode_INSTRUCTION & (32'b00000000000000000010000000110000));
  assign _zz_460 = (32'b00000000000000000010000000010000);
  assign _zz_461 = ((decode_INSTRUCTION & _zz_478) == (32'b00000000000000000010000000100000));
  assign _zz_462 = (_zz_479 == _zz_480);
  assign _zz_463 = (_zz_481 == _zz_482);
  assign _zz_464 = (decode_INSTRUCTION & (32'b00000000000000000001000000010000));
  assign _zz_465 = (32'b00000000000000000001000000010000);
  assign _zz_466 = ((decode_INSTRUCTION & _zz_483) == (32'b00000000000000000010000000010000));
  assign _zz_467 = (_zz_484 == _zz_485);
  assign _zz_468 = {_zz_154,_zz_153};
  assign _zz_469 = (decode_INSTRUCTION & (32'b00000000000000000000000001001100));
  assign _zz_470 = (32'b00000000000000000000000000000100);
  assign _zz_471 = _zz_152;
  assign _zz_472 = _zz_151;
  assign _zz_473 = (_zz_486 == _zz_487);
  assign _zz_474 = (1'b0);
  assign _zz_475 = ({_zz_488,_zz_489} != (2'b00));
  assign _zz_476 = (_zz_490 != _zz_491);
  assign _zz_477 = {_zz_492,{_zz_493,_zz_494}};
  assign _zz_478 = (32'b00000010000000000010000000100000);
  assign _zz_479 = (decode_INSTRUCTION & (32'b00000010000000000001000000100000));
  assign _zz_480 = (32'b00000000000000000000000000100000);
  assign _zz_481 = (decode_INSTRUCTION & (32'b00000000000000000001000000110000));
  assign _zz_482 = (32'b00000000000000000000000000010000);
  assign _zz_483 = (32'b00000000000000000010000000010000);
  assign _zz_484 = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_485 = (32'b00000000000000000000000000010000);
  assign _zz_486 = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_487 = (32'b00000000000000000000000001000000);
  assign _zz_488 = ((decode_INSTRUCTION & _zz_495) == (32'b00000000000000000000000000100100));
  assign _zz_489 = ((decode_INSTRUCTION & _zz_496) == (32'b00000000000000000100000000010000));
  assign _zz_490 = ((decode_INSTRUCTION & _zz_497) == (32'b00000000000000000010000000010000));
  assign _zz_491 = (1'b0);
  assign _zz_492 = ((_zz_498 == _zz_499) != (1'b0));
  assign _zz_493 = 1'b0;
  assign _zz_494 = {(_zz_500 != _zz_501),{_zz_502,{_zz_503,_zz_504}}};
  assign _zz_495 = (32'b00000000000000000000000001100100);
  assign _zz_496 = (32'b00000000000000000100000000010100);
  assign _zz_497 = (32'b00000000000000000110000000010100);
  assign _zz_498 = (decode_INSTRUCTION & (32'b00000000000100000011000001010000));
  assign _zz_499 = (32'b00000000000000000000000001010000);
  assign _zz_500 = _zz_150;
  assign _zz_501 = (1'b0);
  assign _zz_502 = ({(_zz_505 == _zz_506),{_zz_507,_zz_149}} != (3'b000));
  assign _zz_503 = ((_zz_508 == _zz_509) != (1'b0));
  assign _zz_504 = {({_zz_510,_zz_511} != (5'b00000)),{(_zz_512 != _zz_513),{_zz_514,{_zz_515,_zz_516}}}};
  assign _zz_505 = (decode_INSTRUCTION & (32'b01000000000000000000000000110000));
  assign _zz_506 = (32'b01000000000000000000000000110000);
  assign _zz_507 = ((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000));
  assign _zz_508 = (decode_INSTRUCTION & (32'b00000010000000000100000001110100));
  assign _zz_509 = (32'b00000010000000000000000000110000);
  assign _zz_510 = _zz_148;
  assign _zz_511 = {_zz_147,{_zz_517,{_zz_518,_zz_519}}};
  assign _zz_512 = {(_zz_520 == _zz_521),(_zz_522 == _zz_523)};
  assign _zz_513 = (2'b00);
  assign _zz_514 = ({_zz_524,{_zz_525,_zz_526}} != (3'b000));
  assign _zz_515 = ({_zz_527,_zz_528} != (5'b00000));
  assign _zz_516 = (_zz_529 != (1'b0));
  assign _zz_517 = ((decode_INSTRUCTION & (32'b00000000000000000100000000100000)) == (32'b00000000000000000100000000100000));
  assign _zz_518 = ((decode_INSTRUCTION & _zz_530) == (32'b00000000000000000000000000010000));
  assign _zz_519 = ((decode_INSTRUCTION & _zz_531) == (32'b00000000000000000000000000100000));
  assign _zz_520 = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_521 = (32'b00000000000000000101000000010000);
  assign _zz_522 = (decode_INSTRUCTION & (32'b00000010000000000111000001100100));
  assign _zz_523 = (32'b00000000000000000101000000100000);
  assign _zz_524 = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_525 = ((decode_INSTRUCTION & _zz_532) == (32'b00000000000000000001000000010000));
  assign _zz_526 = ((decode_INSTRUCTION & _zz_533) == (32'b00000000000000000001000000010000));
  assign _zz_527 = ((decode_INSTRUCTION & _zz_534) == (32'b00000000000000000000000000000000));
  assign _zz_528 = {(_zz_535 == _zz_536),{_zz_146,{_zz_537,_zz_538}}};
  assign _zz_529 = ((decode_INSTRUCTION & (32'b00000010000000000100000001100100)) == (32'b00000010000000000100000000100000));
  assign _zz_530 = (32'b00000000000000000000000000110000);
  assign _zz_531 = (32'b00000010000000000000000000100000);
  assign _zz_532 = (32'b00000000000000000111000000110100);
  assign _zz_533 = (32'b00000010000000000111000001010100);
  assign _zz_534 = (32'b00000000000000000000000001000100);
  assign _zz_535 = (decode_INSTRUCTION & (32'b00000000000000000000000000011000));
  assign _zz_536 = (32'b00000000000000000000000000000000);
  assign _zz_537 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_538 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_539 = (32'b00000000000000000010000001111111);
  assign _zz_540 = (decode_INSTRUCTION & (32'b00000000001000000000000001111111));
  assign _zz_541 = (32'b00000000000000000000000001101111);
  assign _zz_542 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_543 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011));
  assign _zz_544 = {((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_545) == (32'b00000000000000000100000001100011)),{(_zz_546 == _zz_547),{_zz_548,{_zz_549,_zz_550}}}}}};
  assign _zz_545 = (32'b00000000000000000100000101111111);
  assign _zz_546 = (decode_INSTRUCTION & (32'b00000000000000000010000101111111));
  assign _zz_547 = (32'b00000000000000000000000001100011);
  assign _zz_548 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000100000000001111));
  assign _zz_549 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000000000001100111));
  assign _zz_550 = {((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b00000001111100000111000001111111)) == (32'b00000000000000000101000000001111)),{((decode_INSTRUCTION & _zz_551) == (32'b00000000000000000101000000010011)),{(_zz_552 == _zz_553),{_zz_554,{_zz_555,_zz_556}}}}}};
  assign _zz_551 = (32'b10111100000000000111000001111111);
  assign _zz_552 = (decode_INSTRUCTION & (32'b11111100000000000011000001111111));
  assign _zz_553 = (32'b00000000000000000001000000010011);
  assign _zz_554 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011));
  assign _zz_555 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_556 = {((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00110000001000000000000001110011)),((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00000000000100000000000001110011))};
  always @ (posedge clk) begin
    if(_zz_53) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_163) begin
      _zz_249 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_164) begin
      _zz_250 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_224),
    .io_flush_cmd_ready(_zz_257),
    .io_flush_rsp(_zz_258),
    .io_cpu_prefetch_isValid(IBusCachedPlugin_fetchPc_output_valid),
    .io_cpu_prefetch_haltIt(_zz_259),
    .io_cpu_prefetch_pc(IBusCachedPlugin_fetchPc_output_payload),
    .io_cpu_fetch_isValid(IBusCachedPlugin_iBusRsp_inputPipeline_0_valid),
    .io_cpu_fetch_isStuck(_zz_225),
    .io_cpu_fetch_isRemoved(_zz_226),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_inputPipeline_0_payload),
    .io_cpu_fetch_data(_zz_260),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_262),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_263),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_264),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_101),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_227),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_228),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_229),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_230),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_231),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_102),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_103),
    .io_cpu_fetch_mmuBus_end(_zz_265),
    .io_cpu_fetch_physicalAddress(_zz_261),
    .io_cpu_decode_isValid(IBusCachedPlugin_cacheRspArbitration_valid),
    .io_cpu_decode_isStuck(_zz_232),
    .io_cpu_decode_pc(IBusCachedPlugin_cacheRspArbitration_payload),
    .io_cpu_decode_physicalAddress(_zz_271),
    .io_cpu_decode_data(_zz_269),
    .io_cpu_decode_cacheMiss(_zz_270),
    .io_cpu_decode_error(_zz_266),
    .io_cpu_decode_mmuMiss(_zz_267),
    .io_cpu_decode_illegalAccess(_zz_268),
    .io_cpu_decode_isUser(_zz_233),
    .io_cpu_fill_valid(IBusCachedPlugin_redoFetch),
    .io_cpu_fill_payload(_zz_271),
    .io_mem_cmd_valid(_zz_272),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_273),
    .io_mem_cmd_payload_size(_zz_274),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1 ( 
    .io_cpu_execute_isValid(_zz_234),
    .io_cpu_execute_isStuck(execute_arbitration_isStuck),
    .io_cpu_execute_args_kind(_zz_235),
    .io_cpu_execute_args_wr(execute_MEMORY_WR),
    .io_cpu_execute_args_address(_zz_236),
    .io_cpu_execute_args_data(_zz_140),
    .io_cpu_execute_args_size(execute_DBusCachedPlugin_size),
    .io_cpu_execute_args_forceUncachedAccess(_zz_237),
    .io_cpu_execute_args_clean(_zz_238),
    .io_cpu_execute_args_invalidate(_zz_239),
    .io_cpu_execute_args_way(_zz_240),
    .io_cpu_memory_isValid(_zz_241),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_haltIt(_zz_275),
    .io_cpu_memory_mmuBus_cmd_isValid(_zz_276),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(_zz_277),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(_zz_278),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(_zz_104),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_242),
    .io_cpu_memory_mmuBus_rsp_allowRead(_zz_243),
    .io_cpu_memory_mmuBus_rsp_allowWrite(_zz_244),
    .io_cpu_memory_mmuBus_rsp_allowExecute(_zz_245),
    .io_cpu_memory_mmuBus_rsp_allowUser(_zz_246),
    .io_cpu_memory_mmuBus_rsp_miss(_zz_105),
    .io_cpu_memory_mmuBus_rsp_hit(_zz_106),
    .io_cpu_memory_mmuBus_end(_zz_279),
    .io_cpu_writeBack_isValid(_zz_247),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_248),
    .io_cpu_writeBack_haltIt(_zz_280),
    .io_cpu_writeBack_data(_zz_281),
    .io_cpu_writeBack_mmuMiss(_zz_282),
    .io_cpu_writeBack_illegalAccess(_zz_283),
    .io_cpu_writeBack_unalignedAccess(_zz_284),
    .io_cpu_writeBack_accessError(_zz_285),
    .io_cpu_writeBack_badAddr(_zz_286),
    .io_mem_cmd_valid(_zz_287),
    .io_mem_cmd_ready(dBus_cmd_ready),
    .io_mem_cmd_payload_wr(_zz_288),
    .io_mem_cmd_payload_address(_zz_289),
    .io_mem_cmd_payload_data(_zz_290),
    .io_mem_cmd_payload_mask(_zz_291),
    .io_mem_cmd_payload_length(_zz_292),
    .io_mem_cmd_payload_last(_zz_293),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_394)
      2'b00 : begin
        _zz_254 = _zz_110;
      end
      2'b01 : begin
        _zz_254 = _zz_108;
      end
      2'b10 : begin
        _zz_254 = _zz_99;
      end
      default : begin
        _zz_254 = _zz_96;
      end
    endcase
  end

  always @(*) begin
    case(_zz_203)
      1'b0 : begin
        _zz_255 = (_zz_267 ? (4'b1110) : (4'b0001));
        _zz_256 = IBusCachedPlugin_cacheRspArbitration_payload;
      end
      default : begin
        _zz_255 = decodeExceptionPort_payload_code;
        _zz_256 = decodeExceptionPort_payload_badAddr;
      end
    endcase
  end

  assign memory_MUL_LOW = _zz_31;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_75;
  assign execute_SHIFT_RIGHT = _zz_38;
  assign decode_IS_RS2_SIGNED = _zz_56;
  assign memory_PC = execute_to_memory_PC;
  assign decode_IS_DIV = _zz_79;
  assign decode_IS_EBREAK = _zz_64;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_49;
  assign decode_SRC_LESS_UNSIGNED = _zz_62;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_32;
  assign execute_MUL_HL = _zz_33;
  assign decode_SRC_USE_SUB_LESS = _zz_74;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_29;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_63;
  assign execute_BRANCH_DO = _zz_27;
  assign decode_SRC2_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign _zz_4 = _zz_5;
  assign decode_IS_RS1_SIGNED = _zz_73;
  assign decode_SRC1_CTRL = _zz_6;
  assign _zz_7 = _zz_8;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_82;
  assign decode_CSR_WRITE_OPCODE = _zz_24;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_88;
  assign _zz_9 = _zz_10;
  assign decode_SHIFT_CTRL = _zz_11;
  assign _zz_12 = _zz_13;
  assign execute_BRANCH_CALC = _zz_26;
  assign decode_ENV_CTRL = _zz_14;
  assign _zz_15 = _zz_16;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_67;
  assign decode_MEMORY_MANAGMENT = _zz_61;
  assign decode_ALU_BITWISE_CTRL = _zz_17;
  assign _zz_18 = _zz_19;
  assign execute_MUL_LH = _zz_34;
  assign decode_ALU_CTRL = _zz_20;
  assign _zz_21 = _zz_22;
  assign execute_MUL_LL = _zz_35;
  assign decode_CSR_READ_OPCODE = _zz_23;
  assign decode_MEMORY_ENABLE = _zz_59;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_76;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_58;
  assign execute_IS_EBREAK = decode_to_execute_IS_EBREAK;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign decode_IS_CSR = _zz_66;
  assign execute_ENV_CTRL = _zz_25;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_28;
  assign decode_RS2_USE = _zz_65;
  assign decode_RS1_USE = _zz_78;
  always @ (*) begin
    _zz_30 = execute_REGFILE_WRITE_DATA;
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_30 = execute_CsrPlugin_readData;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_54;
    decode_RS1 = _zz_55;
    if(_zz_184)begin
      if((_zz_185 == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_186;
      end
      if((_zz_185 == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_186;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(_zz_187)begin
        if(_zz_188)begin
          decode_RS1 = _zz_81;
        end
        if(_zz_189)begin
          decode_RS2 = _zz_81;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_190)begin
          decode_RS1 = _zz_36;
        end
        if(_zz_191)begin
          decode_RS2 = _zz_36;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_192)begin
          decode_RS1 = _zz_30;
        end
        if(_zz_193)begin
          decode_RS2 = _zz_30;
        end
      end
    end
  end

  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @ (*) begin
    _zz_36 = memory_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_haltItself = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    memory_arbitration_flushAll = 1'b0;
    _zz_92 = 1'b0;
    _zz_93 = 1'b0;
    _zz_109 = 1'b0;
    _zz_110 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    _zz_224 = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_224 = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_257))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_275)begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(((_zz_276 && (! _zz_106)) && (! _zz_105)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_36 = _zz_174;
      end
      `ShiftCtrlEnum_binary_sequancial_SRL_1, `ShiftCtrlEnum_binary_sequancial_SRA_1 : begin
        _zz_36 = memory_SHIFT_RIGHT;
      end
      default : begin
      end
    endcase
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_296)begin
      if(_zz_301)begin
        memory_arbitration_haltItself = 1'b1;
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_36 = memory_DivPlugin_div_result;
    end
    if(_zz_299)begin
      _zz_109 = 1'b1;
      _zz_110 = CsrPlugin_mtvec;
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_302)begin
      if(_zz_295)begin
        execute_arbitration_haltItself = 1'b1;
      end else begin
        _zz_109 = 1'b1;
        _zz_110 = CsrPlugin_mepc;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_readDataRegValid)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(execute_IS_EBREAK)begin
      if(execute_arbitration_isValid)begin
        _zz_93 = 1'b1;
        _zz_92 = 1'b1;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      _zz_92 = 1'b1;
    end
    if(_zz_300)begin
      _zz_92 = 1'b1;
    end
  end

  assign memory_SHIFT_CTRL = _zz_37;
  assign execute_SHIFT_CTRL = _zz_39;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_43 = execute_PC;
  assign execute_SRC2_CTRL = _zz_44;
  assign execute_SRC1_CTRL = _zz_46;
  assign execute_SRC_ADD_SUB = _zz_42;
  assign execute_SRC_LESS = _zz_40;
  assign execute_ALU_CTRL = _zz_48;
  assign execute_SRC2 = _zz_45;
  assign execute_SRC1 = _zz_47;
  assign execute_ALU_BITWISE_CTRL = _zz_50;
  assign _zz_51 = writeBack_INSTRUCTION;
  assign _zz_52 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_53 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_53 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_84;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_68;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_80;
  assign decode_INSTRUCTION_READY = _zz_89;
  always @ (*) begin
    _zz_81 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_81 = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_306)
        2'b00 : begin
          _zz_81 = _zz_360;
        end
        2'b01, 2'b10, 2'b11 : begin
          _zz_81 = _zz_361;
        end
        default : begin
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_SRC_ADD = _zz_41;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_issueDetected = _zz_83;
    _zz_100 = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && ((_zz_266 || _zz_267) || _zz_268)) && (! _zz_83)))begin
      IBusCachedPlugin_issueDetected = 1'b1;
      _zz_100 = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    _zz_83 = _zz_138;
    IBusCachedPlugin_redoFetch = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && _zz_270) && (! _zz_138)))begin
      _zz_83 = 1'b1;
      IBusCachedPlugin_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_85;
  always @ (*) begin
    _zz_86 = memory_FORMAL_PC_NEXT;
    if(_zz_107)begin
      _zz_86 = _zz_108;
    end
  end

  always @ (*) begin
    _zz_87 = decode_FORMAL_PC_NEXT;
    if(_zz_95)begin
      _zz_87 = _zz_96;
    end
    if(_zz_98)begin
      _zz_87 = _zz_99;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_91;
  always @ (*) begin
    decode_INSTRUCTION = _zz_90;
    if((_zz_211 != (3'b000)))begin
      decode_INSTRUCTION = _zz_212;
    end
  end

  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_output_valid && (! IBusCachedPlugin_injector_decodeRemoved));
    if((decode_arbitration_isValid && (_zz_182 || _zz_183)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(((decode_arbitration_isValid && decode_IS_CSR) && (execute_arbitration_isValid || memory_arbitration_isValid)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    _zz_115 = 1'b0;
    case(_zz_211)
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
        _zz_115 = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if((CsrPlugin_pipelineLiberator_enable && decode_arbitration_isValid))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute)begin
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
    if(_zz_107)begin
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
  always @ (*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(_zz_280)begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_exception_agregat_valid)begin
      writeBack_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  always @ (*) begin
    _zz_94 = 1'b0;
    if((IBusCachedPlugin_iBusRsp_inputPipeline_0_valid || IBusCachedPlugin_cacheRspArbitration_valid))begin
      _zz_94 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_112 = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      _zz_112 = 1'b0;
    end
  end

  always @ (*) begin
    _zz_113 = 1'b1;
    if(DebugPlugin_haltIt)begin
      _zz_113 = 1'b0;
    end
  end

  assign IBusCachedPlugin_jump_pcLoad_valid = (((_zz_95 || _zz_98) || _zz_107) || _zz_109);
  assign _zz_116 = {_zz_95,{_zz_98,{_zz_107,_zz_109}}};
  assign _zz_117 = (_zz_116 & (~ _zz_308));
  assign _zz_118 = _zz_117[3];
  assign _zz_119 = (_zz_117[1] || _zz_118);
  assign _zz_120 = (_zz_117[2] || _zz_118);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_254;
  assign _zz_121 = (! _zz_92);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_121);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_121);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_310);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_297)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_122;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b0;
    if(((_zz_262 && (! _zz_103)) && (! _zz_102)))begin
      IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_input_ready = ((1'b0 && (! _zz_123)) || IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_123 = _zz_124;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_valid = _zz_123;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_payload = _zz_125;
  assign _zz_126 = (! IBusCachedPlugin_iBusRsp_inputPipelineHalt_0);
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_ready = (_zz_127 && _zz_126);
  assign _zz_127 = ((1'b0 && (! _zz_128)) || IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_128 = _zz_129;
  assign IBusCachedPlugin_cacheRspArbitration_valid = _zz_128;
  assign IBusCachedPlugin_cacheRspArbitration_payload = _zz_130;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck);
  assign _zz_91 = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign _zz_90 = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  assign _zz_89 = 1'b1;
  assign _zz_88 = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_131 = _zz_311[11];
  always @ (*) begin
    _zz_132[18] = _zz_131;
    _zz_132[17] = _zz_131;
    _zz_132[16] = _zz_131;
    _zz_132[15] = _zz_131;
    _zz_132[14] = _zz_131;
    _zz_132[13] = _zz_131;
    _zz_132[12] = _zz_131;
    _zz_132[11] = _zz_131;
    _zz_132[10] = _zz_131;
    _zz_132[9] = _zz_131;
    _zz_132[8] = _zz_131;
    _zz_132[7] = _zz_131;
    _zz_132[6] = _zz_131;
    _zz_132[5] = _zz_131;
    _zz_132[4] = _zz_131;
    _zz_132[3] = _zz_131;
    _zz_132[2] = _zz_131;
    _zz_132[1] = _zz_131;
    _zz_132[0] = _zz_131;
  end

  assign _zz_97 = ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_B) && _zz_312[31]));
  assign _zz_95 = (_zz_97 && decode_arbitration_isFiring);
  assign _zz_133 = _zz_313[19];
  always @ (*) begin
    _zz_134[10] = _zz_133;
    _zz_134[9] = _zz_133;
    _zz_134[8] = _zz_133;
    _zz_134[7] = _zz_133;
    _zz_134[6] = _zz_133;
    _zz_134[5] = _zz_133;
    _zz_134[4] = _zz_133;
    _zz_134[3] = _zz_133;
    _zz_134[2] = _zz_133;
    _zz_134[1] = _zz_133;
    _zz_134[0] = _zz_133;
  end

  assign _zz_135 = _zz_314[11];
  always @ (*) begin
    _zz_136[18] = _zz_135;
    _zz_136[17] = _zz_135;
    _zz_136[16] = _zz_135;
    _zz_136[15] = _zz_135;
    _zz_136[14] = _zz_135;
    _zz_136[13] = _zz_135;
    _zz_136[12] = _zz_135;
    _zz_136[11] = _zz_135;
    _zz_136[10] = _zz_135;
    _zz_136[9] = _zz_135;
    _zz_136[8] = _zz_135;
    _zz_136[7] = _zz_135;
    _zz_136[6] = _zz_135;
    _zz_136[5] = _zz_135;
    _zz_136[4] = _zz_135;
    _zz_136[3] = _zz_135;
    _zz_136[2] = _zz_135;
    _zz_136[1] = _zz_135;
    _zz_136[0] = _zz_135;
  end

  assign _zz_96 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) ? {{_zz_134,{{{_zz_395,_zz_396},_zz_397},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_136,{{{_zz_398,_zz_399},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = _zz_272;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_273;
    iBus_cmd_payload_address = _zz_273;
  end

  assign iBus_cmd_payload_size = _zz_274;
  assign _zz_137 = (! _zz_259);
  assign IBusCachedPlugin_fetchPc_output_ready = (IBusCachedPlugin_iBusRsp_input_ready && _zz_137);
  assign IBusCachedPlugin_iBusRsp_input_valid = (IBusCachedPlugin_fetchPc_output_valid && _zz_137);
  assign IBusCachedPlugin_iBusRsp_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign _zz_226 = (IBusCachedPlugin_jump_pcLoad_valid || _zz_93);
  assign IBusCachedPlugin_iBusRspOutputHalt = 1'b0;
  assign _zz_227 = _zz_101[31];
  assign _zz_228 = 1'b1;
  assign _zz_229 = 1'b1;
  assign _zz_230 = 1'b1;
  assign _zz_231 = 1'b1;
  assign _zz_225 = (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_232 = (! IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_233 = (_zz_111 == (2'b00));
  assign _zz_84 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_260);
  assign _zz_138 = 1'b0;
  assign _zz_98 = IBusCachedPlugin_redoFetch;
  assign _zz_99 = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_139 = (! (IBusCachedPlugin_issueDetected || IBusCachedPlugin_iBusRspOutputHalt));
  assign IBusCachedPlugin_cacheRspArbitration_ready = (IBusCachedPlugin_iBusRsp_output_ready && _zz_139);
  assign IBusCachedPlugin_iBusRsp_output_valid = (IBusCachedPlugin_cacheRspArbitration_valid && _zz_139);
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = _zz_269;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_cacheRspArbitration_payload;
  assign dBus_cmd_valid = _zz_287;
  assign dBus_cmd_payload_wr = _zz_288;
  assign dBus_cmd_payload_address = _zz_289;
  assign dBus_cmd_payload_data = _zz_290;
  assign dBus_cmd_payload_mask = _zz_291;
  assign dBus_cmd_payload_length = _zz_292;
  assign dBus_cmd_payload_last = _zz_293;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign _zz_234 = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign _zz_236 = execute_SRC_ADD;
  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_140 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_140 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_140 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign _zz_237 = 1'b0;
  assign _zz_235 = (execute_MEMORY_MANAGMENT ? `DataCacheCpuCmdKind_binary_sequancial_MANAGMENT : `DataCacheCpuCmdKind_binary_sequancial_MEMORY);
  assign _zz_238 = execute_INSTRUCTION[28];
  assign _zz_239 = execute_INSTRUCTION[29];
  assign _zz_240 = execute_INSTRUCTION[30];
  assign _zz_82 = _zz_236[1 : 0];
  assign _zz_241 = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign _zz_242 = _zz_104[31];
  assign _zz_243 = 1'b1;
  assign _zz_244 = 1'b1;
  assign _zz_245 = 1'b1;
  assign _zz_246 = 1'b1;
  assign _zz_247 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_248 = (_zz_111 == (2'b00));
  assign writeBack_exception_agregat_valid = (((_zz_282 || _zz_285) || _zz_283) || _zz_284);
  assign writeBack_exception_agregat_payload_badAddr = _zz_286;
  always @ (*) begin
    writeBack_exception_agregat_payload_code = (4'bxxxx);
    if((_zz_283 || _zz_285))begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_315};
    end
    if(_zz_284)begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_316};
    end
    if(_zz_282)begin
      writeBack_exception_agregat_payload_code = (4'b1101);
    end
  end

  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = _zz_281;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_281[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = _zz_281[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_281[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_141 = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_142[31] = _zz_141;
    _zz_142[30] = _zz_141;
    _zz_142[29] = _zz_141;
    _zz_142[28] = _zz_141;
    _zz_142[27] = _zz_141;
    _zz_142[26] = _zz_141;
    _zz_142[25] = _zz_141;
    _zz_142[24] = _zz_141;
    _zz_142[23] = _zz_141;
    _zz_142[22] = _zz_141;
    _zz_142[21] = _zz_141;
    _zz_142[20] = _zz_141;
    _zz_142[19] = _zz_141;
    _zz_142[18] = _zz_141;
    _zz_142[17] = _zz_141;
    _zz_142[16] = _zz_141;
    _zz_142[15] = _zz_141;
    _zz_142[14] = _zz_141;
    _zz_142[13] = _zz_141;
    _zz_142[12] = _zz_141;
    _zz_142[11] = _zz_141;
    _zz_142[10] = _zz_141;
    _zz_142[9] = _zz_141;
    _zz_142[8] = _zz_141;
    _zz_142[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_143 = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_144[31] = _zz_143;
    _zz_144[30] = _zz_143;
    _zz_144[29] = _zz_143;
    _zz_144[28] = _zz_143;
    _zz_144[27] = _zz_143;
    _zz_144[26] = _zz_143;
    _zz_144[25] = _zz_143;
    _zz_144[24] = _zz_143;
    _zz_144[23] = _zz_143;
    _zz_144[22] = _zz_143;
    _zz_144[21] = _zz_143;
    _zz_144[20] = _zz_143;
    _zz_144[19] = _zz_143;
    _zz_144[18] = _zz_143;
    _zz_144[17] = _zz_143;
    _zz_144[16] = _zz_143;
    _zz_144[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_304)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_142;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_144;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  assign _zz_101 = _zz_263;
  assign _zz_102 = 1'b0;
  assign _zz_103 = 1'b1;
  assign _zz_104 = _zz_277;
  assign _zz_105 = 1'b0;
  assign _zz_106 = 1'b1;
  assign _zz_146 = ((decode_INSTRUCTION & (32'b00000000000000000001000001010000)) == (32'b00000000000000000001000000000000));
  assign _zz_147 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_148 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_149 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010100)) == (32'b00000000000000000000000001000000));
  assign _zz_150 = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_151 = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_152 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_153 = ((decode_INSTRUCTION & (32'b00000000000000000000000000101000)) == (32'b00000000000000000000000000000000));
  assign _zz_154 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_155 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_145 = {(_zz_150 != (1'b0)),{({_zz_400,_zz_147} != (2'b00)),{({_zz_401,_zz_402} != (2'b00)),{(_zz_403 != _zz_404),{_zz_405,{_zz_406,_zz_407}}}}}};
  assign _zz_80 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000001000001111111)) == (32'b00000000000000000001000001110011)),{((decode_INSTRUCTION & _zz_539) == (32'b00000000000000000010000001110011)),{(_zz_540 == _zz_541),{_zz_542,{_zz_543,_zz_544}}}}}}} != (21'b000000000000000000000));
  assign _zz_79 = _zz_317[0];
  assign _zz_78 = _zz_318[0];
  assign _zz_156 = _zz_145[3 : 2];
  assign _zz_77 = _zz_156;
  assign _zz_76 = _zz_319[0];
  assign _zz_75 = _zz_320[0];
  assign _zz_74 = _zz_321[0];
  assign _zz_73 = _zz_322[0];
  assign _zz_157 = _zz_145[9 : 8];
  assign _zz_72 = _zz_157;
  assign _zz_158 = _zz_145[11 : 10];
  assign _zz_71 = _zz_158;
  assign _zz_159 = _zz_145[13 : 12];
  assign _zz_70 = _zz_159;
  assign _zz_160 = _zz_145[15 : 14];
  assign _zz_69 = _zz_160;
  assign _zz_68 = _zz_323[0];
  assign _zz_67 = _zz_324[0];
  assign _zz_66 = _zz_325[0];
  assign _zz_65 = _zz_326[0];
  assign _zz_64 = _zz_327[0];
  assign _zz_63 = _zz_328[0];
  assign _zz_62 = _zz_329[0];
  assign _zz_61 = _zz_330[0];
  assign _zz_161 = _zz_145[25 : 24];
  assign _zz_60 = _zz_161;
  assign _zz_59 = _zz_331[0];
  assign _zz_58 = _zz_332[0];
  assign _zz_162 = _zz_145[29 : 28];
  assign _zz_57 = _zz_162;
  assign _zz_56 = _zz_333[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_163 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_249;
  assign _zz_164 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_250;
  assign _zz_55 = decode_RegFilePlugin_rs1Data;
  assign _zz_54 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_52 && writeBack_arbitration_isFiring);
    if(_zz_165)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_51[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_81;
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
        _zz_166 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_166 = {31'd0, _zz_334};
      end
      default : begin
        _zz_166 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_49 = _zz_166;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_167 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_PC_INCREMENT : begin
        _zz_167 = {29'd0, _zz_335};
      end
      default : begin
        _zz_167 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_47 = _zz_167;
  assign _zz_168 = _zz_336[11];
  always @ (*) begin
    _zz_169[19] = _zz_168;
    _zz_169[18] = _zz_168;
    _zz_169[17] = _zz_168;
    _zz_169[16] = _zz_168;
    _zz_169[15] = _zz_168;
    _zz_169[14] = _zz_168;
    _zz_169[13] = _zz_168;
    _zz_169[12] = _zz_168;
    _zz_169[11] = _zz_168;
    _zz_169[10] = _zz_168;
    _zz_169[9] = _zz_168;
    _zz_169[8] = _zz_168;
    _zz_169[7] = _zz_168;
    _zz_169[6] = _zz_168;
    _zz_169[5] = _zz_168;
    _zz_169[4] = _zz_168;
    _zz_169[3] = _zz_168;
    _zz_169[2] = _zz_168;
    _zz_169[1] = _zz_168;
    _zz_169[0] = _zz_168;
  end

  assign _zz_170 = _zz_337[11];
  always @ (*) begin
    _zz_171[19] = _zz_170;
    _zz_171[18] = _zz_170;
    _zz_171[17] = _zz_170;
    _zz_171[16] = _zz_170;
    _zz_171[15] = _zz_170;
    _zz_171[14] = _zz_170;
    _zz_171[13] = _zz_170;
    _zz_171[12] = _zz_170;
    _zz_171[11] = _zz_170;
    _zz_171[10] = _zz_170;
    _zz_171[9] = _zz_170;
    _zz_171[8] = _zz_170;
    _zz_171[7] = _zz_170;
    _zz_171[6] = _zz_170;
    _zz_171[5] = _zz_170;
    _zz_171[4] = _zz_170;
    _zz_171[3] = _zz_170;
    _zz_171[2] = _zz_170;
    _zz_171[1] = _zz_170;
    _zz_171[0] = _zz_170;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_172 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_172 = {_zz_169,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_172 = {_zz_171,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_172 = _zz_43;
      end
    endcase
  end

  assign _zz_45 = _zz_172;
  assign execute_SrcPlugin_addSub = _zz_338;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_42 = execute_SrcPlugin_addSub;
  assign _zz_41 = execute_SrcPlugin_addSub;
  assign _zz_40 = execute_SrcPlugin_less;
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_173[0] = execute_SRC1[31];
    _zz_173[1] = execute_SRC1[30];
    _zz_173[2] = execute_SRC1[29];
    _zz_173[3] = execute_SRC1[28];
    _zz_173[4] = execute_SRC1[27];
    _zz_173[5] = execute_SRC1[26];
    _zz_173[6] = execute_SRC1[25];
    _zz_173[7] = execute_SRC1[24];
    _zz_173[8] = execute_SRC1[23];
    _zz_173[9] = execute_SRC1[22];
    _zz_173[10] = execute_SRC1[21];
    _zz_173[11] = execute_SRC1[20];
    _zz_173[12] = execute_SRC1[19];
    _zz_173[13] = execute_SRC1[18];
    _zz_173[14] = execute_SRC1[17];
    _zz_173[15] = execute_SRC1[16];
    _zz_173[16] = execute_SRC1[15];
    _zz_173[17] = execute_SRC1[14];
    _zz_173[18] = execute_SRC1[13];
    _zz_173[19] = execute_SRC1[12];
    _zz_173[20] = execute_SRC1[11];
    _zz_173[21] = execute_SRC1[10];
    _zz_173[22] = execute_SRC1[9];
    _zz_173[23] = execute_SRC1[8];
    _zz_173[24] = execute_SRC1[7];
    _zz_173[25] = execute_SRC1[6];
    _zz_173[26] = execute_SRC1[5];
    _zz_173[27] = execute_SRC1[4];
    _zz_173[28] = execute_SRC1[3];
    _zz_173[29] = execute_SRC1[2];
    _zz_173[30] = execute_SRC1[1];
    _zz_173[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SLL_1) ? _zz_173 : execute_SRC1);
  assign _zz_38 = _zz_347;
  always @ (*) begin
    _zz_174[0] = memory_SHIFT_RIGHT[31];
    _zz_174[1] = memory_SHIFT_RIGHT[30];
    _zz_174[2] = memory_SHIFT_RIGHT[29];
    _zz_174[3] = memory_SHIFT_RIGHT[28];
    _zz_174[4] = memory_SHIFT_RIGHT[27];
    _zz_174[5] = memory_SHIFT_RIGHT[26];
    _zz_174[6] = memory_SHIFT_RIGHT[25];
    _zz_174[7] = memory_SHIFT_RIGHT[24];
    _zz_174[8] = memory_SHIFT_RIGHT[23];
    _zz_174[9] = memory_SHIFT_RIGHT[22];
    _zz_174[10] = memory_SHIFT_RIGHT[21];
    _zz_174[11] = memory_SHIFT_RIGHT[20];
    _zz_174[12] = memory_SHIFT_RIGHT[19];
    _zz_174[13] = memory_SHIFT_RIGHT[18];
    _zz_174[14] = memory_SHIFT_RIGHT[17];
    _zz_174[15] = memory_SHIFT_RIGHT[16];
    _zz_174[16] = memory_SHIFT_RIGHT[15];
    _zz_174[17] = memory_SHIFT_RIGHT[14];
    _zz_174[18] = memory_SHIFT_RIGHT[13];
    _zz_174[19] = memory_SHIFT_RIGHT[12];
    _zz_174[20] = memory_SHIFT_RIGHT[11];
    _zz_174[21] = memory_SHIFT_RIGHT[10];
    _zz_174[22] = memory_SHIFT_RIGHT[9];
    _zz_174[23] = memory_SHIFT_RIGHT[8];
    _zz_174[24] = memory_SHIFT_RIGHT[7];
    _zz_174[25] = memory_SHIFT_RIGHT[6];
    _zz_174[26] = memory_SHIFT_RIGHT[5];
    _zz_174[27] = memory_SHIFT_RIGHT[4];
    _zz_174[28] = memory_SHIFT_RIGHT[3];
    _zz_174[29] = memory_SHIFT_RIGHT[2];
    _zz_174[30] = memory_SHIFT_RIGHT[1];
    _zz_174[31] = memory_SHIFT_RIGHT[0];
  end

  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_305)
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
  assign _zz_35 = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_34 = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_33 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_32 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_31 = ($signed(_zz_349) + $signed(_zz_357));
  assign writeBack_MulPlugin_result = ($signed(_zz_358) + $signed(_zz_359));
  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_294)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_done = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_done && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_363);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_175 = memory_DivPlugin_rs1[31 : 0];
  assign _zz_176 = {memory_DivPlugin_accumulator[31 : 0],_zz_175[31]};
  assign _zz_177 = (_zz_176 - _zz_364);
  assign _zz_178 = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_179 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_180 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_181[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_181[31 : 0] = execute_RS1;
  end

  always @ (*) begin
    _zz_182 = 1'b0;
    _zz_183 = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! _zz_187)))begin
        if(_zz_188)begin
          _zz_182 = 1'b1;
        end
        if(_zz_189)begin
          _zz_183 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_190)begin
          _zz_182 = 1'b1;
        end
        if(_zz_191)begin
          _zz_183 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_192)begin
          _zz_182 = 1'b1;
        end
        if(_zz_193)begin
          _zz_183 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_182 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_183 = 1'b0;
    end
  end

  assign _zz_187 = 1'b1;
  assign _zz_188 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_189 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_190 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_191 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_192 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_193 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_29 = _zz_97;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_194 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_194 == (3'b000))) begin
        _zz_195 = execute_BranchPlugin_eq;
    end else if((_zz_194 == (3'b001))) begin
        _zz_195 = (! execute_BranchPlugin_eq);
    end else if((((_zz_194 & (3'b101)) == (3'b101)))) begin
        _zz_195 = (! execute_SRC_LESS);
    end else begin
        _zz_195 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_196 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_196 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_196 = 1'b1;
      end
      default : begin
        _zz_196 = _zz_195;
      end
    endcase
  end

  assign _zz_27 = (execute_PREDICTION_HAD_BRANCHED2 != _zz_196);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_198,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = (execute_PREDICTION_HAD_BRANCHED2 ? _zz_380 : {{_zz_200,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
      end
    endcase
  end

  assign _zz_197 = _zz_377[11];
  always @ (*) begin
    _zz_198[19] = _zz_197;
    _zz_198[18] = _zz_197;
    _zz_198[17] = _zz_197;
    _zz_198[16] = _zz_197;
    _zz_198[15] = _zz_197;
    _zz_198[14] = _zz_197;
    _zz_198[13] = _zz_197;
    _zz_198[12] = _zz_197;
    _zz_198[11] = _zz_197;
    _zz_198[10] = _zz_197;
    _zz_198[9] = _zz_197;
    _zz_198[8] = _zz_197;
    _zz_198[7] = _zz_197;
    _zz_198[6] = _zz_197;
    _zz_198[5] = _zz_197;
    _zz_198[4] = _zz_197;
    _zz_198[3] = _zz_197;
    _zz_198[2] = _zz_197;
    _zz_198[1] = _zz_197;
    _zz_198[0] = _zz_197;
  end

  assign _zz_199 = _zz_378[11];
  always @ (*) begin
    _zz_200[18] = _zz_199;
    _zz_200[17] = _zz_199;
    _zz_200[16] = _zz_199;
    _zz_200[15] = _zz_199;
    _zz_200[14] = _zz_199;
    _zz_200[13] = _zz_199;
    _zz_200[12] = _zz_199;
    _zz_200[11] = _zz_199;
    _zz_200[10] = _zz_199;
    _zz_200[9] = _zz_199;
    _zz_200[8] = _zz_199;
    _zz_200[7] = _zz_199;
    _zz_200[6] = _zz_199;
    _zz_200[5] = _zz_199;
    _zz_200[4] = _zz_199;
    _zz_200[3] = _zz_199;
    _zz_200[2] = _zz_199;
    _zz_200[1] = _zz_199;
    _zz_200[0] = _zz_199;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_26 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_107 = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_108 = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && (memory_BRANCH_CALC[1 : 0] != (2'b00))));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = memory_BRANCH_CALC;
  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000001000010);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_enable = 1'b0;
    if(CsrPlugin_interrupt)begin
      CsrPlugin_pipelineLiberator_enable = 1'b1;
    end
  end

  assign CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusCachedPlugin_injector_nextPcCalc_valids_4);
  assign decode_exception_agregat_valid = (_zz_100 || decodeExceptionPort_valid);
  assign _zz_201 = {decodeExceptionPort_valid,_zz_100};
  assign _zz_202 = _zz_381[1];
  assign _zz_203 = _zz_202;
  assign decode_exception_agregat_payload_code = _zz_255;
  assign decode_exception_agregat_payload_badAddr = _zz_256;
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

  assign CsrPlugin_interruptRequest = ((((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) || (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE)) || (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE)) && CsrPlugin_mstatus_MIE);
  assign CsrPlugin_interrupt = (CsrPlugin_interruptRequest && _zz_112);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && _zz_113);
  assign CsrPlugin_writeBackWasWfi = 1'b0;
  assign contextSwitching = _zz_109;
  assign _zz_24 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_23 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_205;
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
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_207;
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
    if((_zz_111 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_386 : execute_SRC1);
  always @ (*) begin
    case(_zz_307)
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
  assign _zz_207 = (_zz_205 & _zz_206);
  assign externalInterrupt = (_zz_207 != (32'b00000000000000000000000000000000));
  assign DebugPlugin_isPipBusy = (DebugPlugin_isPipActive || _zz_208);
  always @ (*) begin
    _zz_251 = 1'b1;
    _zz_114 = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_298)
        1'b0 : begin
        end
        default : begin
          if(debug_bus_cmd_payload_wr)begin
            _zz_114 = 1'b1;
            _zz_251 = _zz_115;
          end
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_209))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign debug_resetOut = _zz_210;
  assign _zz_22 = decode_ALU_CTRL;
  assign _zz_20 = _zz_71;
  assign _zz_48 = decode_to_execute_ALU_CTRL;
  assign _zz_19 = decode_ALU_BITWISE_CTRL;
  assign _zz_17 = _zz_57;
  assign _zz_50 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_16 = decode_ENV_CTRL;
  assign _zz_14 = _zz_72;
  assign _zz_25 = decode_to_execute_ENV_CTRL;
  assign _zz_13 = decode_SHIFT_CTRL;
  assign _zz_10 = execute_SHIFT_CTRL;
  assign _zz_11 = _zz_77;
  assign _zz_39 = decode_to_execute_SHIFT_CTRL;
  assign _zz_37 = execute_to_memory_SHIFT_CTRL;
  assign _zz_8 = decode_SRC1_CTRL;
  assign _zz_6 = _zz_69;
  assign _zz_46 = decode_to_execute_SRC1_CTRL;
  assign _zz_5 = decode_BRANCH_CTRL;
  assign _zz_85 = _zz_70;
  assign _zz_28 = decode_to_execute_BRANCH_CTRL;
  assign _zz_3 = decode_SRC2_CTRL;
  assign _zz_1 = _zz_60;
  assign _zz_44 = decode_to_execute_SRC2_CTRL;
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
  assign iBusWishbone_ADR = {_zz_393,_zz_213};
  assign iBusWishbone_CTI = ((_zz_213 == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    _zz_252 = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_303)begin
      _zz_252 = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_214;
  assign iBus_rsp_payload_data = _zz_215;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_221 = (dBus_cmd_payload_length != (3'b000));
  assign _zz_217 = dBus_cmd_valid;
  assign _zz_219 = dBus_cmd_payload_wr;
  assign _zz_220 = (_zz_216 == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_218 && (_zz_219 || _zz_220));
  assign dBusWishbone_ADR = ((_zz_221 ? {{dBus_cmd_payload_address[31 : 5],_zz_216},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_221 ? (_zz_220 ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_219 ? dBus_cmd_payload_mask : (4'b1111));
  assign _zz_253 = _zz_219;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_218 = (_zz_217 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_217;
  assign dBusWishbone_STB = _zz_217;
  assign dBus_rsp_valid = _zz_222;
  assign dBus_rsp_payload_data = _zz_223;
  assign dBus_rsp_payload_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_111 <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_122 <= 1'b0;
      _zz_124 <= 1'b0;
      _zz_129 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      _zz_165 <= 1'b1;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_184 <= 1'b0;
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
      _zz_205 <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_211 <= (3'b000);
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_213 <= (3'b000);
      _zz_214 <= 1'b0;
      _zz_216 <= (3'b000);
      _zz_222 <= 1'b0;
    end else begin
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_297)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_122 <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        _zz_124 <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_input_ready)begin
        _zz_124 <= IBusCachedPlugin_iBusRsp_input_valid;
      end
      if(_zz_127)begin
        _zz_129 <= (IBusCachedPlugin_iBusRsp_inputPipeline_0_valid && _zz_126);
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        _zz_129 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_cacheRspArbitration_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_93))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      _zz_165 <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      _zz_184 <= (_zz_52 && writeBack_arbitration_isFiring);
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
      if(_zz_299)begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_111;
      end
      if(_zz_302)begin
        if(! _zz_295) begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_111 <= CsrPlugin_mstatus_MPP;
        end
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_36;
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
      case(_zz_211)
        3'b000 : begin
          if(_zz_114)begin
            _zz_211 <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_211 <= (3'b010);
        end
        3'b010 : begin
          _zz_211 <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_211 <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_211 <= (3'b000);
        end
        default : begin
        end
      endcase
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_205 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_387[0];
            CsrPlugin_mstatus_MIE <= _zz_388[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_389[0];
          end
        end
        12'b110011000000 : begin
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_390[0];
            CsrPlugin_mie_MTIE <= _zz_391[0];
            CsrPlugin_mie_MSIE <= _zz_392[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_303)begin
        if(iBusWishbone_ACK)begin
          _zz_213 <= (_zz_213 + (3'b001));
        end
      end
      _zz_214 <= (_zz_252 && iBusWishbone_ACK);
      if((_zz_217 && _zz_218))begin
        _zz_216 <= (_zz_216 + (3'b001));
        if(_zz_220)begin
          _zz_216 <= (3'b000);
        end
      end
      _zz_222 <= ((_zz_217 && (! _zz_253)) && dBusWishbone_ACK);
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_input_ready)begin
      _zz_125 <= IBusCachedPlugin_iBusRsp_input_payload;
    end
    if(_zz_127)begin
      _zz_130 <= IBusCachedPlugin_iBusRsp_inputPipeline_0_payload;
    end
    if(_zz_296)begin
      if(_zz_301)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_365[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_177[32]) ? _zz_366 : _zz_367);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_368[31:0];
        end
      end
    end
    if(_zz_294)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_180 ? (~ _zz_181) : _zz_181) + _zz_374);
      memory_DivPlugin_rs2 <= ((_zz_179 ? (~ execute_RS2) : execute_RS2) + _zz_376);
      memory_DivPlugin_div_needRevert <= (_zz_180 ^ (_zz_179 && (! execute_INSTRUCTION[13])));
    end
    _zz_185 <= _zz_51[11 : 7];
    _zz_186 <= _zz_81;
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
    if(writeBack_exception_agregat_valid)begin
      if((! 1'b0))begin
        CsrPlugin_exceptionPortCtrl_exceptionContext_code <= writeBack_exception_agregat_payload_code;
        CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= writeBack_exception_agregat_payload_badAddr;
      end
    end
    if(_zz_299)begin
      CsrPlugin_mepc <= writeBack_PC;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interrupt;
      CsrPlugin_mcause_exceptionCode <= ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_384);
    end
    _zz_204 <= CsrPlugin_exception;
    if(_zz_204)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    _zz_206 <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
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
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_21;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_18;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_15;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_12;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_CTRL <= _zz_9;
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
      decode_to_execute_FORMAL_PC_NEXT <= _zz_87;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_86;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_7;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_4;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_2;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FLUSH_ALL <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FLUSH_ALL <= execute_FLUSH_ALL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_30;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_EBREAK <= decode_IS_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_43;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
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
      12'b110011000000 : begin
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
    _zz_215 <= iBusWishbone_DAT_MISO;
    _zz_223 <= dBusWishbone_DAT_MISO;
  end

  always @ (posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(_zz_251)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipActive <= (((decode_arbitration_isValid || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid);
    _zz_208 <= DebugPlugin_isPipActive;
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_81;
    end
    _zz_209 <= debug_bus_cmd_payload_address[2];
    _zz_210 <= DebugPlugin_resetIt;
  end

  always @ (posedge clk) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if(debug_bus_cmd_valid)begin
        case(_zz_298)
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
      if(_zz_300)begin
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
    _zz_212 <= debug_bus_cmd_payload_data;
  end

endmodule

