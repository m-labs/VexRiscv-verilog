// Generator : SpinalHDL v1.1.6    git head : 369ec039630c441c429b64ffc0a9ec31d21b7196
// Date      : 15/04/2019, 11:45:59
// Component : VexRiscv


`define BranchCtrlEnum_binary_sequancial_type [1:0]
`define BranchCtrlEnum_binary_sequancial_INC 2'b00
`define BranchCtrlEnum_binary_sequancial_B 2'b01
`define BranchCtrlEnum_binary_sequancial_JAL 2'b10
`define BranchCtrlEnum_binary_sequancial_JALR 2'b11

`define AluBitwiseCtrlEnum_binary_sequancial_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequancial_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequancial_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequancial_AND_1 2'b10
`define AluBitwiseCtrlEnum_binary_sequancial_SRC1 2'b11

`define Src2CtrlEnum_binary_sequancial_type [1:0]
`define Src2CtrlEnum_binary_sequancial_RS 2'b00
`define Src2CtrlEnum_binary_sequancial_IMI 2'b01
`define Src2CtrlEnum_binary_sequancial_IMS 2'b10
`define Src2CtrlEnum_binary_sequancial_PC 2'b11

`define DataCacheCpuCmdKind_binary_sequancial_type [0:0]
`define DataCacheCpuCmdKind_binary_sequancial_MEMORY 1'b0
`define DataCacheCpuCmdKind_binary_sequancial_MANAGMENT 1'b1

`define AluCtrlEnum_binary_sequancial_type [1:0]
`define AluCtrlEnum_binary_sequancial_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequancial_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequancial_BITWISE 2'b10

`define ShiftCtrlEnum_binary_sequancial_type [1:0]
`define ShiftCtrlEnum_binary_sequancial_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequancial_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequancial_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequancial_SRA_1 2'b11

`define EnvCtrlEnum_binary_sequancial_type [2:0]
`define EnvCtrlEnum_binary_sequancial_NONE 3'b000
`define EnvCtrlEnum_binary_sequancial_EBREAK 3'b001
`define EnvCtrlEnum_binary_sequancial_MRET 3'b010
`define EnvCtrlEnum_binary_sequancial_WFI 3'b011
`define EnvCtrlEnum_binary_sequancial_ECALL 3'b100

`define Src1CtrlEnum_binary_sequancial_type [1:0]
`define Src1CtrlEnum_binary_sequancial_RS 2'b00
`define Src1CtrlEnum_binary_sequancial_IMU 2'b01
`define Src1CtrlEnum_binary_sequancial_PC_INCREMENT 2'b10

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
  assign _zz_46 = ((! victim_memCmdAlreadyUsed) && io_mem_cmd_ready);
  assign _zz_47 = (! io_cpu_writeBack_isStuck);
  assign _zz_48 = (stageB_mmuRsp_physicalAddress[11 : 5] != (7'b1111111));
  assign _zz_49 = (! victim_request_valid);
  assign _zz_50 = (! _zz_27);
  assign _zz_51 = (! victim_readLineCmdCounter[3]);
  assign _zz_52 = (! _zz_40);
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
      if(_zz_51)begin
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
      if(_zz_46)begin
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
              if(_zz_49)begin
                io_mem_cmd_payload_wr = stageB_request_wr;
                io_mem_cmd_payload_address = {stageB_mmuRsp_physicalAddress[31 : 2],(2'b00)};
                io_mem_cmd_payload_mask = stageB_writeMask;
                io_mem_cmd_payload_data = stageB_request_data;
                io_mem_cmd_payload_length = (3'b000);
                io_mem_cmd_payload_last = 1'b1;
                if(_zz_52)begin
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
      if(_zz_50)begin
        _zz_27 <= victim_requestIn_valid;
        _zz_28 <= (! victim_requestIn_valid);
      end else begin
        _zz_27 <= (! victim_request_ready);
        _zz_28 <= victim_request_ready;
      end
      if(victim_request_valid)begin
        if(_zz_51)begin
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
        if(_zz_46)begin
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
      if(_zz_49)begin
        if(_zz_52)begin
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
  reg  _zz_236;
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
  wire `DataCacheCpuCmdKind_binary_sequancial_type _zz_247;
  wire [31:0] _zz_248;
  wire  _zz_249;
  wire  _zz_250;
  wire  _zz_251;
  wire  _zz_252;
  wire  _zz_253;
  wire  _zz_254;
  wire  _zz_255;
  wire  _zz_256;
  wire  _zz_257;
  wire  _zz_258;
  wire  _zz_259;
  wire  _zz_260;
  reg [31:0] _zz_261;
  reg [31:0] _zz_262;
  reg  _zz_263;
  reg  _zz_264;
  wire  _zz_265;
  reg [31:0] _zz_266;
  reg [3:0] _zz_267;
  reg [31:0] _zz_268;
  reg [3:0] _zz_269;
  reg [31:0] _zz_270;
  wire  _zz_271;
  wire  _zz_272;
  wire  _zz_273;
  wire [31:0] _zz_274;
  wire [31:0] _zz_275;
  wire  _zz_276;
  wire [31:0] _zz_277;
  wire  _zz_278;
  wire  _zz_279;
  wire  _zz_280;
  wire  _zz_281;
  wire  _zz_282;
  wire [31:0] _zz_283;
  wire  _zz_284;
  wire [31:0] _zz_285;
  wire  _zz_286;
  wire [31:0] _zz_287;
  wire [2:0] _zz_288;
  wire  _zz_289;
  wire  _zz_290;
  wire [31:0] _zz_291;
  wire  _zz_292;
  wire  _zz_293;
  wire  _zz_294;
  wire [31:0] _zz_295;
  wire  _zz_296;
  wire  _zz_297;
  wire  _zz_298;
  wire  _zz_299;
  wire [31:0] _zz_300;
  wire  _zz_301;
  wire  _zz_302;
  wire [31:0] _zz_303;
  wire [31:0] _zz_304;
  wire [3:0] _zz_305;
  wire [2:0] _zz_306;
  wire  _zz_307;
  wire  _zz_308;
  wire  _zz_309;
  wire  _zz_310;
  wire [0:0] _zz_311;
  wire  _zz_312;
  wire  _zz_313;
  wire  _zz_314;
  wire  _zz_315;
  wire  _zz_316;
  wire  _zz_317;
  wire [1:0] _zz_318;
  wire  _zz_319;
  wire [1:0] _zz_320;
  wire [1:0] _zz_321;
  wire [3:0] _zz_322;
  wire [2:0] _zz_323;
  wire [31:0] _zz_324;
  wire [11:0] _zz_325;
  wire [31:0] _zz_326;
  wire [19:0] _zz_327;
  wire [11:0] _zz_328;
  wire [2:0] _zz_329;
  wire [2:0] _zz_330;
  wire [0:0] _zz_331;
  wire [0:0] _zz_332;
  wire [0:0] _zz_333;
  wire [0:0] _zz_334;
  wire [0:0] _zz_335;
  wire [0:0] _zz_336;
  wire [0:0] _zz_337;
  wire [0:0] _zz_338;
  wire [0:0] _zz_339;
  wire [0:0] _zz_340;
  wire [0:0] _zz_341;
  wire [0:0] _zz_342;
  wire [0:0] _zz_343;
  wire [0:0] _zz_344;
  wire [0:0] _zz_345;
  wire [0:0] _zz_346;
  wire [0:0] _zz_347;
  wire [0:0] _zz_348;
  wire [2:0] _zz_349;
  wire [11:0] _zz_350;
  wire [11:0] _zz_351;
  wire [31:0] _zz_352;
  wire [31:0] _zz_353;
  wire [31:0] _zz_354;
  wire [31:0] _zz_355;
  wire [1:0] _zz_356;
  wire [31:0] _zz_357;
  wire [1:0] _zz_358;
  wire [1:0] _zz_359;
  wire [32:0] _zz_360;
  wire [31:0] _zz_361;
  wire [32:0] _zz_362;
  wire [11:0] _zz_363;
  wire [11:0] _zz_364;
  wire [2:0] _zz_365;
  wire [31:0] _zz_366;
  wire [1:0] _zz_367;
  wire [1:0] _zz_368;
  wire [1:0] _zz_369;
  wire [1:0] _zz_370;
  wire [2:0] _zz_371;
  wire [3:0] _zz_372;
  wire [4:0] _zz_373;
  wire [31:0] _zz_374;
  wire [51:0] _zz_375;
  wire [51:0] _zz_376;
  wire [51:0] _zz_377;
  wire [32:0] _zz_378;
  wire [51:0] _zz_379;
  wire [49:0] _zz_380;
  wire [51:0] _zz_381;
  wire [49:0] _zz_382;
  wire [51:0] _zz_383;
  wire [65:0] _zz_384;
  wire [65:0] _zz_385;
  wire [31:0] _zz_386;
  wire [31:0] _zz_387;
  wire [0:0] _zz_388;
  wire [5:0] _zz_389;
  wire [32:0] _zz_390;
  wire [32:0] _zz_391;
  wire [31:0] _zz_392;
  wire [31:0] _zz_393;
  wire [32:0] _zz_394;
  wire [32:0] _zz_395;
  wire [32:0] _zz_396;
  wire [0:0] _zz_397;
  wire [32:0] _zz_398;
  wire [0:0] _zz_399;
  wire [32:0] _zz_400;
  wire [0:0] _zz_401;
  wire [31:0] _zz_402;
  wire [0:0] _zz_403;
  wire [0:0] _zz_404;
  wire [0:0] _zz_405;
  wire [0:0] _zz_406;
  wire [0:0] _zz_407;
  wire [0:0] _zz_408;
  wire [0:0] _zz_409;
  wire [26:0] _zz_410;
  wire [1:0] _zz_411;
  wire [0:0] _zz_412;
  wire [7:0] _zz_413;
  wire  _zz_414;
  wire [0:0] _zz_415;
  wire [0:0] _zz_416;
  wire [31:0] _zz_417;
  wire [31:0] _zz_418;
  wire  _zz_419;
  wire [0:0] _zz_420;
  wire [1:0] _zz_421;
  wire  _zz_422;
  wire  _zz_423;
  wire [0:0] _zz_424;
  wire [0:0] _zz_425;
  wire [1:0] _zz_426;
  wire [1:0] _zz_427;
  wire  _zz_428;
  wire [0:0] _zz_429;
  wire [25:0] _zz_430;
  wire [31:0] _zz_431;
  wire  _zz_432;
  wire  _zz_433;
  wire [31:0] _zz_434;
  wire [31:0] _zz_435;
  wire [31:0] _zz_436;
  wire [31:0] _zz_437;
  wire [31:0] _zz_438;
  wire [31:0] _zz_439;
  wire  _zz_440;
  wire [1:0] _zz_441;
  wire [1:0] _zz_442;
  wire  _zz_443;
  wire [0:0] _zz_444;
  wire [23:0] _zz_445;
  wire [31:0] _zz_446;
  wire [31:0] _zz_447;
  wire [31:0] _zz_448;
  wire [31:0] _zz_449;
  wire  _zz_450;
  wire [0:0] _zz_451;
  wire [0:0] _zz_452;
  wire [0:0] _zz_453;
  wire [0:0] _zz_454;
  wire  _zz_455;
  wire [0:0] _zz_456;
  wire [20:0] _zz_457;
  wire [31:0] _zz_458;
  wire [31:0] _zz_459;
  wire [31:0] _zz_460;
  wire [0:0] _zz_461;
  wire [1:0] _zz_462;
  wire [0:0] _zz_463;
  wire [2:0] _zz_464;
  wire [5:0] _zz_465;
  wire [5:0] _zz_466;
  wire  _zz_467;
  wire [0:0] _zz_468;
  wire [17:0] _zz_469;
  wire [31:0] _zz_470;
  wire [31:0] _zz_471;
  wire [31:0] _zz_472;
  wire [31:0] _zz_473;
  wire [0:0] _zz_474;
  wire [2:0] _zz_475;
  wire  _zz_476;
  wire  _zz_477;
  wire  _zz_478;
  wire [4:0] _zz_479;
  wire [4:0] _zz_480;
  wire  _zz_481;
  wire [0:0] _zz_482;
  wire [14:0] _zz_483;
  wire [31:0] _zz_484;
  wire [31:0] _zz_485;
  wire  _zz_486;
  wire [0:0] _zz_487;
  wire [0:0] _zz_488;
  wire [31:0] _zz_489;
  wire [31:0] _zz_490;
  wire [31:0] _zz_491;
  wire [0:0] _zz_492;
  wire [2:0] _zz_493;
  wire  _zz_494;
  wire [0:0] _zz_495;
  wire [0:0] _zz_496;
  wire  _zz_497;
  wire [0:0] _zz_498;
  wire [12:0] _zz_499;
  wire [31:0] _zz_500;
  wire [31:0] _zz_501;
  wire [31:0] _zz_502;
  wire [31:0] _zz_503;
  wire  _zz_504;
  wire  _zz_505;
  wire  _zz_506;
  wire [5:0] _zz_507;
  wire [5:0] _zz_508;
  wire  _zz_509;
  wire [0:0] _zz_510;
  wire [9:0] _zz_511;
  wire  _zz_512;
  wire [0:0] _zz_513;
  wire [2:0] _zz_514;
  wire  _zz_515;
  wire [0:0] _zz_516;
  wire [0:0] _zz_517;
  wire  _zz_518;
  wire [0:0] _zz_519;
  wire [0:0] _zz_520;
  wire  _zz_521;
  wire [0:0] _zz_522;
  wire [6:0] _zz_523;
  wire [31:0] _zz_524;
  wire [31:0] _zz_525;
  wire [31:0] _zz_526;
  wire  _zz_527;
  wire [0:0] _zz_528;
  wire [0:0] _zz_529;
  wire [31:0] _zz_530;
  wire [31:0] _zz_531;
  wire [31:0] _zz_532;
  wire [31:0] _zz_533;
  wire [31:0] _zz_534;
  wire [31:0] _zz_535;
  wire  _zz_536;
  wire [0:0] _zz_537;
  wire [0:0] _zz_538;
  wire  _zz_539;
  wire [0:0] _zz_540;
  wire [4:0] _zz_541;
  wire [31:0] _zz_542;
  wire [31:0] _zz_543;
  wire [31:0] _zz_544;
  wire  _zz_545;
  wire [1:0] _zz_546;
  wire [1:0] _zz_547;
  wire  _zz_548;
  wire [0:0] _zz_549;
  wire [1:0] _zz_550;
  wire [31:0] _zz_551;
  wire [31:0] _zz_552;
  wire  _zz_553;
  wire [0:0] _zz_554;
  wire [0:0] _zz_555;
  wire [0:0] _zz_556;
  wire [1:0] _zz_557;
  wire [31:0] _zz_558;
  wire [31:0] _zz_559;
  wire [31:0] _zz_560;
  wire  _zz_561;
  wire [0:0] _zz_562;
  wire [14:0] _zz_563;
  wire [31:0] _zz_564;
  wire [31:0] _zz_565;
  wire [31:0] _zz_566;
  wire  _zz_567;
  wire [0:0] _zz_568;
  wire [8:0] _zz_569;
  wire [31:0] _zz_570;
  wire [31:0] _zz_571;
  wire [31:0] _zz_572;
  wire  _zz_573;
  wire [0:0] _zz_574;
  wire [2:0] _zz_575;
  wire  decode_IS_DIV;
  wire `Src2CtrlEnum_binary_sequancial_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_1;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_2;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_3;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire  execute_BRANCH_DO;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire [31:0] execute_MUL_LL;
  wire  decode_SRC_USE_SUB_LESS;
  wire [31:0] execute_SHIFT_RIGHT;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire  decode_CSR_READ_OPCODE;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_4;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_5;
  wire `ShiftCtrlEnum_binary_sequancial_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_6;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_7;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_8;
  wire `EnvCtrlEnum_binary_sequancial_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_9;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_10;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_11;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_12;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_13;
  wire `EnvCtrlEnum_binary_sequancial_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_14;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_15;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_16;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_IS_EBREAK;
  wire  decode_IS_RS1_SIGNED;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] memory_PC;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_17;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_18;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_19;
  wire [51:0] memory_MUL_LOW;
  wire `Src1CtrlEnum_binary_sequancial_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_20;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_21;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_22;
  wire  decode_MEMORY_MANAGMENT;
  wire `AluCtrlEnum_binary_sequancial_type decode_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_23;
  wire `AluCtrlEnum_binary_sequancial_type _zz_24;
  wire `AluCtrlEnum_binary_sequancial_type _zz_25;
  wire  memory_MEMORY_WR;
  wire  decode_MEMORY_WR;
  wire  decode_MEMORY_ENABLE;
  wire [33:0] execute_MUL_HL;
  wire  decode_IS_RS2_SIGNED;
  wire  decode_SRC_LESS_UNSIGNED;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_26;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_27;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire [33:0] execute_MUL_LH;
  wire  execute_IS_EBREAK;
  wire  execute_IS_RS1_SIGNED;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_28;
  wire [33:0] _zz_29;
  wire [33:0] _zz_30;
  wire [33:0] _zz_31;
  wire [31:0] _zz_32;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  execute_IS_CSR;
  wire  decode_IS_CSR;
  wire  _zz_33;
  wire  _zz_34;
  wire `EnvCtrlEnum_binary_sequancial_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_35;
  wire `EnvCtrlEnum_binary_sequancial_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_36;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_37;
  wire [31:0] execute_PC;
  wire [31:0] execute_RS1;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_38;
  wire `BranchCtrlEnum_binary_sequancial_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_39;
  wire  _zz_40;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  reg [31:0] _zz_41;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  reg [31:0] decode_RS2;
  reg [31:0] decode_RS1;
  wire [31:0] memory_SHIFT_RIGHT;
  reg [31:0] _zz_42;
  wire `ShiftCtrlEnum_binary_sequancial_type memory_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_43;
  wire [31:0] _zz_44;
  wire `ShiftCtrlEnum_binary_sequancial_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_45;
  wire  _zz_46;
  wire [31:0] _zz_47;
  wire [31:0] _zz_48;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_49;
  wire `Src2CtrlEnum_binary_sequancial_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_50;
  wire [31:0] _zz_51;
  wire `Src1CtrlEnum_binary_sequancial_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_52;
  wire [31:0] _zz_53;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_binary_sequancial_type execute_ALU_CTRL;
  wire `AluCtrlEnum_binary_sequancial_type _zz_54;
  wire [31:0] _zz_55;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_56;
  wire [31:0] _zz_57;
  wire  _zz_58;
  reg  _zz_59;
  wire [31:0] _zz_60;
  wire [31:0] _zz_61;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  decode_LEGAL_INSTRUCTION;
  wire  decode_INSTRUCTION_READY;
  wire  _zz_62;
  wire  _zz_63;
  wire  _zz_64;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_65;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_66;
  wire  _zz_67;
  wire  _zz_68;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_69;
  wire  _zz_70;
  wire `AluCtrlEnum_binary_sequancial_type _zz_71;
  wire  _zz_72;
  wire  _zz_73;
  wire  _zz_74;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_75;
  wire  _zz_76;
  wire  _zz_77;
  wire  _zz_78;
  wire  _zz_79;
  wire  _zz_80;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_81;
  wire  _zz_82;
  wire  _zz_83;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_84;
  wire  _zz_85;
  wire  _zz_86;
  reg [31:0] _zz_87;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire  writeBack_MEMORY_WR;
  wire  writeBack_MEMORY_ENABLE;
  wire  memory_MEMORY_ENABLE;
  wire [1:0] _zz_88;
  wire  execute_MEMORY_MANAGMENT;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire  execute_MEMORY_WR;
  wire  execute_MEMORY_ENABLE;
  wire [31:0] execute_INSTRUCTION;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_issueDetected;
  reg  _zz_89;
  wire [31:0] _zz_90;
  wire `BranchCtrlEnum_binary_sequancial_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_91;
  reg [31:0] _zz_92;
  reg [31:0] _zz_93;
  wire [31:0] _zz_94;
  wire  _zz_95;
  wire [31:0] _zz_96;
  wire [31:0] _zz_97;
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
  reg  _zz_98;
  reg  _zz_99;
  reg  _zz_100;
  wire  _zz_101;
  wire [31:0] _zz_102;
  wire  _zz_103;
  wire  _zz_104;
  wire [31:0] _zz_105;
  reg  _zz_106;
  wire [31:0] _zz_107;
  wire  _zz_108;
  wire  _zz_109;
  wire [31:0] _zz_110;
  wire  _zz_111;
  wire  _zz_112;
  wire  writeBack_exception_agregat_valid;
  reg [3:0] writeBack_exception_agregat_payload_code;
  wire [31:0] writeBack_exception_agregat_payload_badAddr;
  wire  decodeExceptionPort_valid;
  wire [3:0] decodeExceptionPort_payload_code;
  wire [31:0] decodeExceptionPort_payload_badAddr;
  wire  _zz_113;
  wire [31:0] _zz_114;
  wire  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  reg  _zz_115;
  reg [31:0] _zz_116;
  reg  _zz_117;
  reg [3:0] _zz_118;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] _zz_119;
  wire  _zz_120;
  reg  _zz_121;
  reg  _zz_122;
  reg  _zz_123;
  reg  _zz_124;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_125;
  wire [3:0] _zz_126;
  wire  _zz_127;
  wire  _zz_128;
  wire  _zz_129;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_130;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_131;
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
  wire  _zz_132;
  reg  _zz_133;
  reg [31:0] _zz_134;
  wire  _zz_135;
  wire  _zz_136;
  wire  _zz_137;
  reg  _zz_138;
  reg [31:0] _zz_139;
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
  wire  _zz_140;
  reg [18:0] _zz_141;
  wire  _zz_142;
  reg [10:0] _zz_143;
  wire  _zz_144;
  reg [18:0] _zz_145;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  _zz_146;
  wire  IBusCachedPlugin_iBusRspOutputHalt;
  wire  _zz_147;
  reg  IBusCachedPlugin_redoFetch;
  wire  _zz_148;
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
  reg [31:0] _zz_149;
  reg [31:0] writeBack_DBusCachedPlugin_rspShifted;
  wire  _zz_150;
  reg [31:0] _zz_151;
  wire  _zz_152;
  reg [31:0] _zz_153;
  reg [31:0] writeBack_DBusCachedPlugin_rspFormated;
  wire [31:0] _zz_154;
  wire  _zz_155;
  wire  _zz_156;
  wire  _zz_157;
  wire  _zz_158;
  wire  _zz_159;
  wire  _zz_160;
  wire  _zz_161;
  wire  _zz_162;
  wire  _zz_163;
  wire  _zz_164;
  wire `AluBitwiseCtrlEnum_binary_sequancial_type _zz_165;
  wire `EnvCtrlEnum_binary_sequancial_type _zz_166;
  wire `BranchCtrlEnum_binary_sequancial_type _zz_167;
  wire `AluCtrlEnum_binary_sequancial_type _zz_168;
  wire `Src2CtrlEnum_binary_sequancial_type _zz_169;
  wire `ShiftCtrlEnum_binary_sequancial_type _zz_170;
  wire `Src1CtrlEnum_binary_sequancial_type _zz_171;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire  _zz_172;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  wire  _zz_173;
  reg  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg  _zz_174;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_175;
  reg [31:0] _zz_176;
  wire  _zz_177;
  reg [19:0] _zz_178;
  wire  _zz_179;
  reg [19:0] _zz_180;
  reg [31:0] _zz_181;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  wire [4:0] execute_FullBarrelShifterPlugin_amplitude;
  reg [31:0] _zz_182;
  wire [31:0] execute_FullBarrelShifterPlugin_reversed;
  reg [31:0] _zz_183;
  reg  _zz_184;
  reg  _zz_185;
  reg  _zz_186;
  reg [4:0] _zz_187;
  reg [31:0] _zz_188;
  wire  _zz_189;
  wire  _zz_190;
  wire  _zz_191;
  wire  _zz_192;
  wire  _zz_193;
  wire  _zz_194;
  wire  _zz_195;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_196;
  reg  _zz_197;
  reg  _zz_198;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_199;
  reg [19:0] _zz_200;
  wire  _zz_201;
  reg [18:0] _zz_202;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg [1:0] CsrPlugin_misa_base;
  reg [25:0] CsrPlugin_misa_extensions;
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
  reg [31:0] CsrPlugin_mscratch;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mbadaddr;
  reg [63:0] CsrPlugin_mcycle = 64'b0010110000010101101111111001000110011011111000000111010000011000;
  reg [63:0] CsrPlugin_minstret = 64'b1011100010001110010111000010110010111110000100010011011100010111;
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
  wire [1:0] _zz_203;
  wire  _zz_204;
  wire [0:0] _zz_205;
  wire  execute_exception_agregat_valid;
  wire [3:0] execute_exception_agregat_payload_code;
  wire [31:0] execute_exception_agregat_payload_badAddr;
  wire [1:0] _zz_206;
  wire  _zz_207;
  wire [0:0] _zz_208;
  wire  CsrPlugin_interruptRequest;
  wire  CsrPlugin_interrupt;
  wire  CsrPlugin_exception;
  reg  CsrPlugin_writeBackWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  _zz_209;
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
  wire [31:0] _zz_210;
  wire [32:0] _zz_211;
  wire [32:0] _zz_212;
  wire [31:0] _zz_213;
  wire  _zz_214;
  wire  _zz_215;
  reg [32:0] _zz_216;
  reg [31:0] _zz_217;
  reg [31:0] _zz_218;
  wire [31:0] _zz_219;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipActive;
  reg  _zz_220;
  wire  DebugPlugin_isPipBusy;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_221;
  reg  _zz_222;
  reg [33:0] execute_to_memory_MUL_LH;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg `BranchCtrlEnum_binary_sequancial_type decode_to_execute_BRANCH_CTRL;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg [33:0] execute_to_memory_MUL_HL;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_MEMORY_WR;
  reg  execute_to_memory_MEMORY_WR;
  reg  memory_to_writeBack_MEMORY_WR;
  reg `AluCtrlEnum_binary_sequancial_type decode_to_execute_ALU_CTRL;
  reg  decode_to_execute_MEMORY_MANAGMENT;
  reg `Src1CtrlEnum_binary_sequancial_type decode_to_execute_SRC1_CTRL;
  reg [31:0] decode_to_execute_RS2;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg  decode_to_execute_IS_CSR;
  reg `AluBitwiseCtrlEnum_binary_sequancial_type decode_to_execute_ALU_BITWISE_CTRL;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg  decode_to_execute_IS_EBREAK;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg `EnvCtrlEnum_binary_sequancial_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_binary_sequancial_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_binary_sequancial_type memory_to_writeBack_ENV_CTRL;
  reg `ShiftCtrlEnum_binary_sequancial_type decode_to_execute_SHIFT_CTRL;
  reg `ShiftCtrlEnum_binary_sequancial_type execute_to_memory_SHIFT_CTRL;
  reg [31:0] decode_to_execute_RS1;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [31:0] execute_to_memory_SHIFT_RIGHT;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg [31:0] execute_to_memory_MUL_LL;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BRANCH_DO;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg `Src2CtrlEnum_binary_sequancial_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg [2:0] _zz_223;
  reg [31:0] _zz_224;
  reg [2:0] _zz_225;
  reg  _zz_226;
  reg [31:0] _zz_227;
  reg [2:0] _zz_228;
  wire  _zz_229;
  wire  _zz_230;
  wire  _zz_231;
  wire  _zz_232;
  wire  _zz_233;
  reg  _zz_234;
  reg [31:0] _zz_235;
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign debug_bus_cmd_ready = _zz_263;
  assign iBusWishbone_CYC = _zz_264;
  assign dBusWishbone_WE = _zz_265;
  assign _zz_308 = (! memory_DivPlugin_div_done);
  assign _zz_309 = (DebugPlugin_stepIt && _zz_100);
  assign _zz_310 = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_311 = debug_bus_cmd_payload_address[2 : 2];
  assign _zz_312 = (iBus_cmd_valid || (_zz_225 != (3'b000)));
  assign _zz_313 = (memory_arbitration_isValid || writeBack_arbitration_isValid);
  assign _zz_314 = (! memory_arbitration_isStuck);
  assign _zz_315 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_316 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET));
  assign _zz_317 = (CsrPlugin_exception || CsrPlugin_interruptJump);
  assign _zz_318 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_319 = execute_INSTRUCTION[13];
  assign _zz_320 = execute_INSTRUCTION[13 : 12];
  assign _zz_321 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_322 = (_zz_125 - (4'b0001));
  assign _zz_323 = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_324 = {29'd0, _zz_323};
  assign _zz_325 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_326 = {{_zz_141,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_327 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_328 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_329 = (writeBack_MEMORY_WR ? (3'b111) : (3'b101));
  assign _zz_330 = (writeBack_MEMORY_WR ? (3'b110) : (3'b100));
  assign _zz_331 = _zz_154[0 : 0];
  assign _zz_332 = _zz_154[3 : 3];
  assign _zz_333 = _zz_154[4 : 4];
  assign _zz_334 = _zz_154[8 : 8];
  assign _zz_335 = _zz_154[9 : 9];
  assign _zz_336 = _zz_154[10 : 10];
  assign _zz_337 = _zz_154[11 : 11];
  assign _zz_338 = _zz_154[12 : 12];
  assign _zz_339 = _zz_154[15 : 15];
  assign _zz_340 = _zz_154[16 : 16];
  assign _zz_341 = _zz_154[17 : 17];
  assign _zz_342 = _zz_154[20 : 20];
  assign _zz_343 = _zz_154[23 : 23];
  assign _zz_344 = _zz_154[24 : 24];
  assign _zz_345 = _zz_154[29 : 29];
  assign _zz_346 = _zz_154[30 : 30];
  assign _zz_347 = _zz_154[31 : 31];
  assign _zz_348 = execute_SRC_LESS;
  assign _zz_349 = (3'b100);
  assign _zz_350 = execute_INSTRUCTION[31 : 20];
  assign _zz_351 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_352 = ($signed(_zz_353) + $signed(_zz_357));
  assign _zz_353 = ($signed(_zz_354) + $signed(_zz_355));
  assign _zz_354 = execute_SRC1;
  assign _zz_355 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_356 = (execute_SRC_USE_SUB_LESS ? _zz_358 : _zz_359);
  assign _zz_357 = {{30{_zz_356[1]}}, _zz_356};
  assign _zz_358 = (2'b01);
  assign _zz_359 = (2'b00);
  assign _zz_360 = ($signed(_zz_362) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_361 = _zz_360[31 : 0];
  assign _zz_362 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_363 = execute_INSTRUCTION[31 : 20];
  assign _zz_364 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_365 = (3'b100);
  assign _zz_366 = {29'd0, _zz_365};
  assign _zz_367 = (_zz_203 & (~ _zz_368));
  assign _zz_368 = (_zz_203 - (2'b01));
  assign _zz_369 = (_zz_206 & (~ _zz_370));
  assign _zz_370 = (_zz_206 - (2'b01));
  assign _zz_371 = ((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) ? (3'b011) : (3'b111));
  assign _zz_372 = {1'd0, _zz_371};
  assign _zz_373 = execute_INSTRUCTION[19 : 15];
  assign _zz_374 = {27'd0, _zz_373};
  assign _zz_375 = ($signed(_zz_376) + $signed(_zz_381));
  assign _zz_376 = ($signed(_zz_377) + $signed(_zz_379));
  assign _zz_377 = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_378 = {1'b0,memory_MUL_LL};
  assign _zz_379 = {{19{_zz_378[32]}}, _zz_378};
  assign _zz_380 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_381 = {{2{_zz_380[49]}}, _zz_380};
  assign _zz_382 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_383 = {{2{_zz_382[49]}}, _zz_382};
  assign _zz_384 = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_385 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_386 = writeBack_MUL_LOW[31 : 0];
  assign _zz_387 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_388 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_389 = {5'd0, _zz_388};
  assign _zz_390 = {1'd0, memory_DivPlugin_rs2};
  assign _zz_391 = {_zz_210,(! _zz_212[32])};
  assign _zz_392 = _zz_212[31:0];
  assign _zz_393 = _zz_211[31:0];
  assign _zz_394 = _zz_395;
  assign _zz_395 = _zz_396;
  assign _zz_396 = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_213) : _zz_213)} + _zz_398);
  assign _zz_397 = memory_DivPlugin_div_needRevert;
  assign _zz_398 = {32'd0, _zz_397};
  assign _zz_399 = _zz_215;
  assign _zz_400 = {32'd0, _zz_399};
  assign _zz_401 = _zz_214;
  assign _zz_402 = {31'd0, _zz_401};
  assign _zz_403 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_404 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_405 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_406 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_407 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_408 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_409 = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_410 = (iBus_cmd_payload_address >>> 5);
  assign _zz_411 = {_zz_129,_zz_128};
  assign _zz_412 = decode_INSTRUCTION[31];
  assign _zz_413 = decode_INSTRUCTION[19 : 12];
  assign _zz_414 = decode_INSTRUCTION[20];
  assign _zz_415 = decode_INSTRUCTION[31];
  assign _zz_416 = decode_INSTRUCTION[7];
  assign _zz_417 = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_418 = (32'b00000000000000000000000000000000);
  assign _zz_419 = ((decode_INSTRUCTION & _zz_431) == (32'b00000000000000000000000000000000));
  assign _zz_420 = _zz_157;
  assign _zz_421 = {_zz_432,_zz_433};
  assign _zz_422 = ((decode_INSTRUCTION & _zz_434) == (32'b00000000000000000001000001010000));
  assign _zz_423 = ((decode_INSTRUCTION & _zz_435) == (32'b00000000000000000010000001010000));
  assign _zz_424 = (_zz_436 == _zz_437);
  assign _zz_425 = (_zz_438 == _zz_439);
  assign _zz_426 = {_zz_160,_zz_161};
  assign _zz_427 = (2'b00);
  assign _zz_428 = (_zz_440 != (1'b0));
  assign _zz_429 = (_zz_441 != _zz_442);
  assign _zz_430 = {_zz_443,{_zz_444,_zz_445}};
  assign _zz_431 = (32'b00000000000000000000000000011000);
  assign _zz_432 = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_433 = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_434 = (32'b00000000000000000001000001010000);
  assign _zz_435 = (32'b00000000000000000010000001010000);
  assign _zz_436 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_437 = (32'b00000000000000000010000000000000);
  assign _zz_438 = (decode_INSTRUCTION & (32'b00000000000000000101000000000000));
  assign _zz_439 = (32'b00000000000000000001000000000000);
  assign _zz_440 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001100)) == (32'b00000000000000000000000000000100));
  assign _zz_441 = {(_zz_446 == _zz_447),(_zz_448 == _zz_449)};
  assign _zz_442 = (2'b00);
  assign _zz_443 = ({_zz_450,{_zz_451,_zz_452}} != (3'b000));
  assign _zz_444 = (_zz_162 != (1'b0));
  assign _zz_445 = {(_zz_453 != _zz_454),{_zz_455,{_zz_456,_zz_457}}};
  assign _zz_446 = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_447 = (32'b00000000000000000101000000010000);
  assign _zz_448 = (decode_INSTRUCTION & (32'b00000010000000000111000001100100));
  assign _zz_449 = (32'b00000000000000000101000000100000);
  assign _zz_450 = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_451 = ((decode_INSTRUCTION & _zz_458) == (32'b00000000000000000001000000010000));
  assign _zz_452 = ((decode_INSTRUCTION & _zz_459) == (32'b00000000000000000001000000010000));
  assign _zz_453 = ((decode_INSTRUCTION & _zz_460) == (32'b00000000000000000000000000001000));
  assign _zz_454 = (1'b0);
  assign _zz_455 = ({_zz_164,{_zz_461,_zz_462}} != (4'b0000));
  assign _zz_456 = ({_zz_463,_zz_464} != (4'b0000));
  assign _zz_457 = {(_zz_465 != _zz_466),{_zz_467,{_zz_468,_zz_469}}};
  assign _zz_458 = (32'b00000000000000000111000000110100);
  assign _zz_459 = (32'b00000010000000000111000001010100);
  assign _zz_460 = (32'b00000000000000000001000001001000);
  assign _zz_461 = _zz_160;
  assign _zz_462 = {(_zz_470 == _zz_471),(_zz_472 == _zz_473)};
  assign _zz_463 = _zz_164;
  assign _zz_464 = {_zz_160,{_zz_159,_zz_158}};
  assign _zz_465 = {_zz_163,{_zz_156,{_zz_474,_zz_475}}};
  assign _zz_466 = (6'b000000);
  assign _zz_467 = ({_zz_476,_zz_477} != (2'b00));
  assign _zz_468 = (_zz_478 != (1'b0));
  assign _zz_469 = {(_zz_479 != _zz_480),{_zz_481,{_zz_482,_zz_483}}};
  assign _zz_470 = (decode_INSTRUCTION & (32'b00000000000000000000000000001100));
  assign _zz_471 = (32'b00000000000000000000000000000100);
  assign _zz_472 = (decode_INSTRUCTION & (32'b00000000000000000000000001110000));
  assign _zz_473 = (32'b00000000000000000000000000100000);
  assign _zz_474 = (_zz_484 == _zz_485);
  assign _zz_475 = {_zz_486,{_zz_487,_zz_488}};
  assign _zz_476 = ((decode_INSTRUCTION & _zz_489) == (32'b00000000000000000000000000100100));
  assign _zz_477 = ((decode_INSTRUCTION & _zz_490) == (32'b00000000000000000100000000010000));
  assign _zz_478 = ((decode_INSTRUCTION & _zz_491) == (32'b00000000000000000010000000010000));
  assign _zz_479 = {_zz_163,{_zz_492,_zz_493}};
  assign _zz_480 = (5'b00000);
  assign _zz_481 = (_zz_494 != (1'b0));
  assign _zz_482 = (_zz_495 != _zz_496);
  assign _zz_483 = {_zz_497,{_zz_498,_zz_499}};
  assign _zz_484 = (decode_INSTRUCTION & (32'b00000000000000000010000000110000));
  assign _zz_485 = (32'b00000000000000000010000000010000);
  assign _zz_486 = ((decode_INSTRUCTION & (32'b00000010000000000010000000100000)) == (32'b00000000000000000010000000100000));
  assign _zz_487 = ((decode_INSTRUCTION & _zz_500) == (32'b00000000000000000000000000100000));
  assign _zz_488 = ((decode_INSTRUCTION & _zz_501) == (32'b00000000000000000000000000010000));
  assign _zz_489 = (32'b00000000000000000000000001100100);
  assign _zz_490 = (32'b00000000000000000100000000010100);
  assign _zz_491 = (32'b00000000000000000110000000010100);
  assign _zz_492 = _zz_156;
  assign _zz_493 = {(_zz_502 == _zz_503),{_zz_504,_zz_505}};
  assign _zz_494 = ((decode_INSTRUCTION & (32'b00000010000000000100000001110100)) == (32'b00000010000000000000000000110000));
  assign _zz_495 = _zz_162;
  assign _zz_496 = (1'b0);
  assign _zz_497 = ({_zz_160,_zz_161} != (2'b00));
  assign _zz_498 = (_zz_506 != (1'b0));
  assign _zz_499 = {(_zz_507 != _zz_508),{_zz_509,{_zz_510,_zz_511}}};
  assign _zz_500 = (32'b00000010000000000001000000100000);
  assign _zz_501 = (32'b00000000000000000001000000110000);
  assign _zz_502 = (decode_INSTRUCTION & (32'b00000000000000000100000000100000));
  assign _zz_503 = (32'b00000000000000000100000000100000);
  assign _zz_504 = ((decode_INSTRUCTION & (32'b00000000000000000000000000110000)) == (32'b00000000000000000000000000010000));
  assign _zz_505 = ((decode_INSTRUCTION & (32'b00000010000000000000000000100000)) == (32'b00000000000000000000000000100000));
  assign _zz_506 = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000001000000));
  assign _zz_507 = {_zz_160,{_zz_512,{_zz_513,_zz_514}}};
  assign _zz_508 = (6'b000000);
  assign _zz_509 = ({_zz_515,{_zz_516,_zz_517}} != (3'b000));
  assign _zz_510 = (_zz_518 != (1'b0));
  assign _zz_511 = {(_zz_519 != _zz_520),{_zz_521,{_zz_522,_zz_523}}};
  assign _zz_512 = ((decode_INSTRUCTION & _zz_524) == (32'b00000000000000000001000000010000));
  assign _zz_513 = (_zz_525 == _zz_526);
  assign _zz_514 = {_zz_527,{_zz_528,_zz_529}};
  assign _zz_515 = ((decode_INSTRUCTION & _zz_530) == (32'b00000000000000000001000000001000));
  assign _zz_516 = (_zz_531 == _zz_532);
  assign _zz_517 = _zz_155;
  assign _zz_518 = ((decode_INSTRUCTION & _zz_533) == (32'b00000000000100000000000001010000));
  assign _zz_519 = (_zz_534 == _zz_535);
  assign _zz_520 = (1'b0);
  assign _zz_521 = (_zz_536 != (1'b0));
  assign _zz_522 = (_zz_537 != _zz_538);
  assign _zz_523 = {_zz_539,{_zz_540,_zz_541}};
  assign _zz_524 = (32'b00000000000000000001000000010000);
  assign _zz_525 = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_526 = (32'b00000000000000000010000000010000);
  assign _zz_527 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000000010000));
  assign _zz_528 = _zz_159;
  assign _zz_529 = _zz_158;
  assign _zz_530 = (32'b00000000000000000001000001001000);
  assign _zz_531 = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_532 = (32'b00000000000000000000000000100000);
  assign _zz_533 = (32'b00010000000100000011000001010000);
  assign _zz_534 = (decode_INSTRUCTION & (32'b00000000000000000000000000001000));
  assign _zz_535 = (32'b00000000000000000000000000001000);
  assign _zz_536 = ((decode_INSTRUCTION & (32'b00000010000000000100000001100100)) == (32'b00000010000000000100000000100000));
  assign _zz_537 = ((decode_INSTRUCTION & _zz_542) == (32'b00000000000000000000000001010000));
  assign _zz_538 = (1'b0);
  assign _zz_539 = ((_zz_543 == _zz_544) != (1'b0));
  assign _zz_540 = (_zz_545 != (1'b0));
  assign _zz_541 = {(_zz_546 != _zz_547),{_zz_548,{_zz_549,_zz_550}}};
  assign _zz_542 = (32'b00100000000100000011000001010000);
  assign _zz_543 = (decode_INSTRUCTION & (32'b00010000000000000011000001010000));
  assign _zz_544 = (32'b00010000000000000000000001010000);
  assign _zz_545 = ((decode_INSTRUCTION & (32'b00110000000000000011000001010000)) == (32'b00010000000000000000000001010000));
  assign _zz_546 = {_zz_157,((decode_INSTRUCTION & _zz_551) == (32'b00000000000000000000000000000000))};
  assign _zz_547 = (2'b00);
  assign _zz_548 = (((decode_INSTRUCTION & _zz_552) == (32'b00000000000000000000000000100000)) != (1'b0));
  assign _zz_549 = ({_zz_553,_zz_156} != (2'b00));
  assign _zz_550 = {({_zz_554,_zz_555} != (2'b00)),({_zz_556,_zz_557} != (3'b000))};
  assign _zz_551 = (32'b00000000000000000000000001011000);
  assign _zz_552 = (32'b00000000000000000000000000100000);
  assign _zz_553 = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_554 = _zz_156;
  assign _zz_555 = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_556 = ((decode_INSTRUCTION & (32'b01000000000000000000000000110000)) == (32'b01000000000000000000000000110000));
  assign _zz_557 = {((decode_INSTRUCTION & (32'b00000000000000000010000000010100)) == (32'b00000000000000000010000000010000)),_zz_155};
  assign _zz_558 = (32'b00000000000000000010000001111111);
  assign _zz_559 = (decode_INSTRUCTION & (32'b00000000001000000000000001111111));
  assign _zz_560 = (32'b00000000000000000000000001101111);
  assign _zz_561 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000010000000010011));
  assign _zz_562 = ((decode_INSTRUCTION & (32'b00000000000000000010000001111111)) == (32'b00000000000000000000000000000011));
  assign _zz_563 = {((decode_INSTRUCTION & (32'b00000000000000000110000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000101000001011111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & _zz_564) == (32'b00000000000000000100000001100011)),{(_zz_565 == _zz_566),{_zz_567,{_zz_568,_zz_569}}}}}};
  assign _zz_564 = (32'b00000000000000000100000101111111);
  assign _zz_565 = (decode_INSTRUCTION & (32'b00000000000000000010000101111111));
  assign _zz_566 = (32'b00000000000000000000000001100011);
  assign _zz_567 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000100000000001111));
  assign _zz_568 = ((decode_INSTRUCTION & (32'b00000000000000000111000001111111)) == (32'b00000000000000000000000001100111));
  assign _zz_569 = {((decode_INSTRUCTION & (32'b11111100000000000000000001111111)) == (32'b00000000000000000000000000110011)),{((decode_INSTRUCTION & (32'b00000001111100000111000001111111)) == (32'b00000000000000000101000000001111)),{((decode_INSTRUCTION & _zz_570) == (32'b00000000000000000101000000010011)),{(_zz_571 == _zz_572),{_zz_573,{_zz_574,_zz_575}}}}}};
  assign _zz_570 = (32'b10111100000000000111000001111111);
  assign _zz_571 = (decode_INSTRUCTION & (32'b11111100000000000011000001111111));
  assign _zz_572 = (32'b00000000000000000001000000010011);
  assign _zz_573 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000101000000110011));
  assign _zz_574 = ((decode_INSTRUCTION & (32'b10111110000000000111000001111111)) == (32'b00000000000000000000000000110011));
  assign _zz_575 = {((decode_INSTRUCTION & (32'b11111111111011111111111111111111)) == (32'b00000000000000000000000001110011)),{((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00010000010100000000000001110011)),((decode_INSTRUCTION & (32'b11111111111111111111111111111111)) == (32'b00110000001000000000000001110011))}};
  always @ (posedge clk) begin
    if(_zz_59) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_172) begin
      _zz_261 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_173) begin
      _zz_262 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_236),
    .io_flush_cmd_ready(_zz_271),
    .io_flush_rsp(_zz_272),
    .io_cpu_prefetch_isValid(IBusCachedPlugin_fetchPc_output_valid),
    .io_cpu_prefetch_haltIt(_zz_273),
    .io_cpu_prefetch_pc(IBusCachedPlugin_fetchPc_output_payload),
    .io_cpu_fetch_isValid(IBusCachedPlugin_iBusRsp_inputPipeline_0_valid),
    .io_cpu_fetch_isStuck(_zz_237),
    .io_cpu_fetch_isRemoved(_zz_238),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_inputPipeline_0_payload),
    .io_cpu_fetch_data(_zz_274),
    .io_cpu_fetch_mmuBus_cmd_isValid(_zz_276),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(_zz_277),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(_zz_278),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_107),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_239),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_240),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_241),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_242),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_243),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_108),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_109),
    .io_cpu_fetch_mmuBus_end(_zz_279),
    .io_cpu_fetch_physicalAddress(_zz_275),
    .io_cpu_decode_isValid(IBusCachedPlugin_cacheRspArbitration_valid),
    .io_cpu_decode_isStuck(_zz_244),
    .io_cpu_decode_pc(IBusCachedPlugin_cacheRspArbitration_payload),
    .io_cpu_decode_physicalAddress(_zz_285),
    .io_cpu_decode_data(_zz_283),
    .io_cpu_decode_cacheMiss(_zz_284),
    .io_cpu_decode_error(_zz_280),
    .io_cpu_decode_mmuMiss(_zz_281),
    .io_cpu_decode_illegalAccess(_zz_282),
    .io_cpu_decode_isUser(_zz_245),
    .io_cpu_fill_valid(IBusCachedPlugin_redoFetch),
    .io_cpu_fill_payload(_zz_285),
    .io_mem_cmd_valid(_zz_286),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(_zz_287),
    .io_mem_cmd_payload_size(_zz_288),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  DataCache dataCache_1 ( 
    .io_cpu_execute_isValid(_zz_246),
    .io_cpu_execute_isStuck(execute_arbitration_isStuck),
    .io_cpu_execute_args_kind(_zz_247),
    .io_cpu_execute_args_wr(execute_MEMORY_WR),
    .io_cpu_execute_args_address(_zz_248),
    .io_cpu_execute_args_data(_zz_149),
    .io_cpu_execute_args_size(execute_DBusCachedPlugin_size),
    .io_cpu_execute_args_forceUncachedAccess(_zz_249),
    .io_cpu_execute_args_clean(_zz_250),
    .io_cpu_execute_args_invalidate(_zz_251),
    .io_cpu_execute_args_way(_zz_252),
    .io_cpu_memory_isValid(_zz_253),
    .io_cpu_memory_isStuck(memory_arbitration_isStuck),
    .io_cpu_memory_isRemoved(memory_arbitration_removeIt),
    .io_cpu_memory_haltIt(_zz_289),
    .io_cpu_memory_mmuBus_cmd_isValid(_zz_290),
    .io_cpu_memory_mmuBus_cmd_virtualAddress(_zz_291),
    .io_cpu_memory_mmuBus_cmd_bypassTranslation(_zz_292),
    .io_cpu_memory_mmuBus_rsp_physicalAddress(_zz_110),
    .io_cpu_memory_mmuBus_rsp_isIoAccess(_zz_254),
    .io_cpu_memory_mmuBus_rsp_allowRead(_zz_255),
    .io_cpu_memory_mmuBus_rsp_allowWrite(_zz_256),
    .io_cpu_memory_mmuBus_rsp_allowExecute(_zz_257),
    .io_cpu_memory_mmuBus_rsp_allowUser(_zz_258),
    .io_cpu_memory_mmuBus_rsp_miss(_zz_111),
    .io_cpu_memory_mmuBus_rsp_hit(_zz_112),
    .io_cpu_memory_mmuBus_end(_zz_293),
    .io_cpu_writeBack_isValid(_zz_259),
    .io_cpu_writeBack_isStuck(writeBack_arbitration_isStuck),
    .io_cpu_writeBack_isUser(_zz_260),
    .io_cpu_writeBack_haltIt(_zz_294),
    .io_cpu_writeBack_data(_zz_295),
    .io_cpu_writeBack_mmuMiss(_zz_296),
    .io_cpu_writeBack_illegalAccess(_zz_297),
    .io_cpu_writeBack_unalignedAccess(_zz_298),
    .io_cpu_writeBack_accessError(_zz_299),
    .io_cpu_writeBack_badAddr(_zz_300),
    .io_mem_cmd_valid(_zz_301),
    .io_mem_cmd_ready(dBus_cmd_ready),
    .io_mem_cmd_payload_wr(_zz_302),
    .io_mem_cmd_payload_address(_zz_303),
    .io_mem_cmd_payload_data(_zz_304),
    .io_mem_cmd_payload_mask(_zz_305),
    .io_mem_cmd_payload_length(_zz_306),
    .io_mem_cmd_payload_last(_zz_307),
    .io_mem_rsp_valid(dBus_rsp_valid),
    .io_mem_rsp_payload_data(dBus_rsp_payload_data),
    .io_mem_rsp_payload_error(dBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_411)
      2'b00 : begin
        _zz_266 = _zz_116;
      end
      2'b01 : begin
        _zz_266 = _zz_114;
      end
      2'b10 : begin
        _zz_266 = _zz_105;
      end
      default : begin
        _zz_266 = _zz_102;
      end
    endcase
  end

  always @(*) begin
    case(_zz_205)
      1'b0 : begin
        _zz_267 = (_zz_281 ? (4'b1110) : (4'b0001));
        _zz_268 = IBusCachedPlugin_cacheRspArbitration_payload;
      end
      default : begin
        _zz_267 = decodeExceptionPort_payload_code;
        _zz_268 = decodeExceptionPort_payload_badAddr;
      end
    endcase
  end

  always @(*) begin
    case(_zz_208)
      1'b0 : begin
        _zz_269 = _zz_118;
        _zz_270 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
      end
      default : begin
        _zz_269 = (4'b0010);
        _zz_270 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
      end
    endcase
  end

  assign decode_IS_DIV = _zz_80;
  assign decode_SRC2_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_29;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_40;
  assign execute_BRANCH_DO = _zz_38;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_72;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_70;
  assign execute_MUL_LL = _zz_32;
  assign decode_SRC_USE_SUB_LESS = _zz_85;
  assign execute_SHIFT_RIGHT = _zz_44;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_88;
  assign decode_CSR_READ_OPCODE = _zz_33;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_68;
  assign _zz_4 = _zz_5;
  assign decode_SHIFT_CTRL = _zz_6;
  assign _zz_7 = _zz_8;
  assign memory_ENV_CTRL = _zz_9;
  assign _zz_10 = _zz_11;
  assign _zz_12 = _zz_13;
  assign decode_ENV_CTRL = _zz_14;
  assign _zz_15 = _zz_16;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_94;
  assign decode_CSR_WRITE_OPCODE = _zz_34;
  assign decode_IS_EBREAK = _zz_78;
  assign decode_IS_RS1_SIGNED = _zz_74;
  assign execute_BRANCH_CALC = _zz_37;
  assign memory_PC = execute_to_memory_PC;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_73;
  assign decode_ALU_BITWISE_CTRL = _zz_17;
  assign _zz_18 = _zz_19;
  assign memory_MUL_LOW = _zz_28;
  assign decode_SRC1_CTRL = _zz_20;
  assign _zz_21 = _zz_22;
  assign decode_MEMORY_MANAGMENT = _zz_79;
  assign decode_ALU_CTRL = _zz_23;
  assign _zz_24 = _zz_25;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_83;
  assign decode_MEMORY_ENABLE = _zz_82;
  assign execute_MUL_HL = _zz_30;
  assign decode_IS_RS2_SIGNED = _zz_67;
  assign decode_SRC_LESS_UNSIGNED = _zz_64;
  assign _zz_26 = _zz_27;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_55;
  assign execute_MUL_LH = _zz_31;
  assign execute_IS_EBREAK = decode_to_execute_IS_EBREAK;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign decode_IS_CSR = _zz_63;
  assign execute_ENV_CTRL = _zz_35;
  assign writeBack_ENV_CTRL = _zz_36;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_39;
  assign decode_RS2_USE = _zz_77;
  assign decode_RS1_USE = _zz_62;
  always @ (*) begin
    _zz_41 = execute_REGFILE_WRITE_DATA;
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_41 = execute_CsrPlugin_readData;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    decode_RS2 = _zz_60;
    decode_RS1 = _zz_61;
    if(_zz_186)begin
      if((_zz_187 == decode_INSTRUCTION[19 : 15]))begin
        decode_RS1 = _zz_188;
      end
      if((_zz_187 == decode_INSTRUCTION[24 : 20]))begin
        decode_RS2 = _zz_188;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if(_zz_189)begin
        if(_zz_190)begin
          decode_RS1 = _zz_87;
        end
        if(_zz_191)begin
          decode_RS2 = _zz_87;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if(memory_BYPASSABLE_MEMORY_STAGE)begin
        if(_zz_192)begin
          decode_RS1 = _zz_42;
        end
        if(_zz_193)begin
          decode_RS2 = _zz_42;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if(execute_BYPASSABLE_EXECUTE_STAGE)begin
        if(_zz_194)begin
          decode_RS1 = _zz_41;
        end
        if(_zz_195)begin
          decode_RS2 = _zz_41;
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @ (*) begin
    _zz_42 = memory_REGFILE_WRITE_DATA;
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_haltItself = 1'b0;
    memory_arbitration_haltItself = 1'b0;
    memory_arbitration_flushAll = 1'b0;
    _zz_98 = 1'b0;
    _zz_99 = 1'b0;
    _zz_115 = 1'b0;
    _zz_116 = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    _zz_236 = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_236 = 1'b1;
      decode_arbitration_flushAll = 1'b1;
      if((! _zz_271))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_289)begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(((_zz_290 && (! _zz_112)) && (! _zz_111)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequancial_SLL_1 : begin
        _zz_42 = _zz_183;
      end
      `ShiftCtrlEnum_binary_sequancial_SRL_1, `ShiftCtrlEnum_binary_sequancial_SRA_1 : begin
        _zz_42 = memory_SHIFT_RIGHT;
      end
      default : begin
      end
    endcase
    if(_zz_317)begin
      _zz_115 = 1'b1;
      _zz_116 = CsrPlugin_mtvec;
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_316)begin
      if(_zz_313)begin
        execute_arbitration_haltItself = 1'b1;
      end else begin
        _zz_115 = 1'b1;
        _zz_116 = CsrPlugin_mepc;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_WFI)))begin
      if((! CsrPlugin_interrupt))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_readDataRegValid)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_315)begin
      if(_zz_308)begin
        memory_arbitration_haltItself = 1'b1;
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
      _zz_42 = memory_DivPlugin_div_result;
    end
    if(execute_IS_EBREAK)begin
      if(execute_arbitration_isValid)begin
        _zz_99 = 1'b1;
        _zz_98 = 1'b1;
        decode_arbitration_flushAll = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      _zz_98 = 1'b1;
    end
    if(_zz_309)begin
      _zz_98 = 1'b1;
    end
  end

  assign memory_SHIFT_CTRL = _zz_43;
  assign execute_SHIFT_CTRL = _zz_45;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_49 = execute_PC;
  assign execute_SRC2_CTRL = _zz_50;
  assign execute_SRC1_CTRL = _zz_52;
  assign execute_SRC_ADD_SUB = _zz_48;
  assign execute_SRC_LESS = _zz_46;
  assign execute_ALU_CTRL = _zz_54;
  assign execute_SRC2 = _zz_51;
  assign execute_SRC1 = _zz_53;
  assign execute_ALU_BITWISE_CTRL = _zz_56;
  assign _zz_57 = writeBack_INSTRUCTION;
  assign _zz_58 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_59 = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_59 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_90;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_76;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = _zz_86;
  assign decode_INSTRUCTION_READY = _zz_95;
  always @ (*) begin
    _zz_87 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_87 = writeBack_DBusCachedPlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_321)
        2'b00 : begin
          _zz_87 = _zz_386;
        end
        2'b01, 2'b10, 2'b11 : begin
          _zz_87 = _zz_387;
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
  assign execute_SRC_ADD = _zz_47;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_issueDetected = _zz_89;
    _zz_106 = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && ((_zz_280 || _zz_281) || _zz_282)) && (! _zz_89)))begin
      IBusCachedPlugin_issueDetected = 1'b1;
      _zz_106 = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @ (*) begin
    _zz_89 = _zz_147;
    IBusCachedPlugin_redoFetch = 1'b0;
    if(((IBusCachedPlugin_cacheRspArbitration_valid && _zz_284) && (! _zz_147)))begin
      _zz_89 = 1'b1;
      IBusCachedPlugin_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_91;
  always @ (*) begin
    _zz_92 = memory_FORMAL_PC_NEXT;
    if(_zz_113)begin
      _zz_92 = _zz_114;
    end
  end

  always @ (*) begin
    _zz_93 = decode_FORMAL_PC_NEXT;
    if(_zz_101)begin
      _zz_93 = _zz_102;
    end
    if(_zz_104)begin
      _zz_93 = _zz_105;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_97;
  always @ (*) begin
    decode_INSTRUCTION = _zz_96;
    if((_zz_223 != (3'b000)))begin
      decode_INSTRUCTION = _zz_224;
    end
  end

  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_output_valid && (! IBusCachedPlugin_injector_decodeRemoved));
    if((decode_arbitration_isValid && (_zz_184 || _zz_185)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(((decode_arbitration_isValid && decode_IS_CSR) && (execute_arbitration_isValid || memory_arbitration_isValid)))begin
      decode_arbitration_haltItself = 1'b1;
    end
    _zz_124 = 1'b0;
    case(_zz_223)
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
        _zz_124 = 1'b1;
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
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_exception_agregat_valid)begin
      execute_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(_zz_113)begin
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
    if(_zz_294)begin
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
    _zz_100 = 1'b0;
    if((IBusCachedPlugin_iBusRsp_inputPipeline_0_valid || IBusCachedPlugin_cacheRspArbitration_valid))begin
      _zz_100 = 1'b1;
    end
  end

  always @ (*) begin
    _zz_117 = 1'b0;
    _zz_118 = (4'bxxxx);
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_ECALL)))begin
      _zz_117 = 1'b1;
      _zz_118 = (4'b1011);
    end
  end

  always @ (*) begin
    _zz_121 = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      _zz_121 = 1'b0;
    end
  end

  always @ (*) begin
    _zz_122 = 1'b1;
    if(DebugPlugin_haltIt)begin
      _zz_122 = 1'b0;
    end
  end

  assign IBusCachedPlugin_jump_pcLoad_valid = (((_zz_101 || _zz_104) || _zz_113) || _zz_115);
  assign _zz_125 = {_zz_101,{_zz_104,{_zz_113,_zz_115}}};
  assign _zz_126 = (_zz_125 & (~ _zz_322));
  assign _zz_127 = _zz_126[3];
  assign _zz_128 = (_zz_126[1] || _zz_127);
  assign _zz_129 = (_zz_126[2] || _zz_127);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_266;
  assign _zz_130 = (! _zz_98);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_130);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_130);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_324);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_310)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_131;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b0;
    if(((_zz_276 && (! _zz_109)) && (! _zz_108)))begin
      IBusCachedPlugin_iBusRsp_inputPipelineHalt_0 = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_input_ready = ((1'b0 && (! _zz_132)) || IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_132 = _zz_133;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_valid = _zz_132;
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_payload = _zz_134;
  assign _zz_135 = (! IBusCachedPlugin_iBusRsp_inputPipelineHalt_0);
  assign IBusCachedPlugin_iBusRsp_inputPipeline_0_ready = (_zz_136 && _zz_135);
  assign _zz_136 = ((1'b0 && (! _zz_137)) || IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_137 = _zz_138;
  assign IBusCachedPlugin_cacheRspArbitration_valid = _zz_137;
  assign IBusCachedPlugin_cacheRspArbitration_payload = _zz_139;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_output_ready = (! decode_arbitration_isStuck);
  assign _zz_97 = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign _zz_96 = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  assign _zz_95 = 1'b1;
  assign _zz_94 = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_140 = _zz_325[11];
  always @ (*) begin
    _zz_141[18] = _zz_140;
    _zz_141[17] = _zz_140;
    _zz_141[16] = _zz_140;
    _zz_141[15] = _zz_140;
    _zz_141[14] = _zz_140;
    _zz_141[13] = _zz_140;
    _zz_141[12] = _zz_140;
    _zz_141[11] = _zz_140;
    _zz_141[10] = _zz_140;
    _zz_141[9] = _zz_140;
    _zz_141[8] = _zz_140;
    _zz_141[7] = _zz_140;
    _zz_141[6] = _zz_140;
    _zz_141[5] = _zz_140;
    _zz_141[4] = _zz_140;
    _zz_141[3] = _zz_140;
    _zz_141[2] = _zz_140;
    _zz_141[1] = _zz_140;
    _zz_141[0] = _zz_140;
  end

  assign _zz_103 = ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_B) && _zz_326[31]));
  assign _zz_101 = (_zz_103 && decode_arbitration_isFiring);
  assign _zz_142 = _zz_327[19];
  always @ (*) begin
    _zz_143[10] = _zz_142;
    _zz_143[9] = _zz_142;
    _zz_143[8] = _zz_142;
    _zz_143[7] = _zz_142;
    _zz_143[6] = _zz_142;
    _zz_143[5] = _zz_142;
    _zz_143[4] = _zz_142;
    _zz_143[3] = _zz_142;
    _zz_143[2] = _zz_142;
    _zz_143[1] = _zz_142;
    _zz_143[0] = _zz_142;
  end

  assign _zz_144 = _zz_328[11];
  always @ (*) begin
    _zz_145[18] = _zz_144;
    _zz_145[17] = _zz_144;
    _zz_145[16] = _zz_144;
    _zz_145[15] = _zz_144;
    _zz_145[14] = _zz_144;
    _zz_145[13] = _zz_144;
    _zz_145[12] = _zz_144;
    _zz_145[11] = _zz_144;
    _zz_145[10] = _zz_144;
    _zz_145[9] = _zz_144;
    _zz_145[8] = _zz_144;
    _zz_145[7] = _zz_144;
    _zz_145[6] = _zz_144;
    _zz_145[5] = _zz_144;
    _zz_145[4] = _zz_144;
    _zz_145[3] = _zz_144;
    _zz_145[2] = _zz_144;
    _zz_145[1] = _zz_144;
    _zz_145[0] = _zz_144;
  end

  assign _zz_102 = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JAL) ? {{_zz_143,{{{_zz_412,_zz_413},_zz_414},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_145,{{{_zz_415,_zz_416},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = _zz_286;
  always @ (*) begin
    iBus_cmd_payload_address = _zz_287;
    iBus_cmd_payload_address = _zz_287;
  end

  assign iBus_cmd_payload_size = _zz_288;
  assign _zz_146 = (! _zz_273);
  assign IBusCachedPlugin_fetchPc_output_ready = (IBusCachedPlugin_iBusRsp_input_ready && _zz_146);
  assign IBusCachedPlugin_iBusRsp_input_valid = (IBusCachedPlugin_fetchPc_output_valid && _zz_146);
  assign IBusCachedPlugin_iBusRsp_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign _zz_238 = (IBusCachedPlugin_jump_pcLoad_valid || _zz_99);
  assign IBusCachedPlugin_iBusRspOutputHalt = 1'b0;
  assign _zz_239 = _zz_107[31];
  assign _zz_240 = 1'b1;
  assign _zz_241 = 1'b1;
  assign _zz_242 = 1'b1;
  assign _zz_243 = 1'b1;
  assign _zz_237 = (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready);
  assign _zz_244 = (! IBusCachedPlugin_cacheRspArbitration_ready);
  assign _zz_245 = (_zz_119 == (2'b00));
  assign _zz_90 = (decode_arbitration_isStuck ? decode_INSTRUCTION : _zz_274);
  assign _zz_147 = 1'b0;
  assign _zz_104 = IBusCachedPlugin_redoFetch;
  assign _zz_105 = IBusCachedPlugin_cacheRspArbitration_payload;
  assign _zz_148 = (! (IBusCachedPlugin_issueDetected || IBusCachedPlugin_iBusRspOutputHalt));
  assign IBusCachedPlugin_cacheRspArbitration_ready = (IBusCachedPlugin_iBusRsp_output_ready && _zz_148);
  assign IBusCachedPlugin_iBusRsp_output_valid = (IBusCachedPlugin_cacheRspArbitration_valid && _zz_148);
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = _zz_283;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_cacheRspArbitration_payload;
  assign dBus_cmd_valid = _zz_301;
  assign dBus_cmd_payload_wr = _zz_302;
  assign dBus_cmd_payload_address = _zz_303;
  assign dBus_cmd_payload_data = _zz_304;
  assign dBus_cmd_payload_mask = _zz_305;
  assign dBus_cmd_payload_length = _zz_306;
  assign dBus_cmd_payload_last = _zz_307;
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign _zz_246 = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign _zz_248 = execute_SRC_ADD;
  always @ (*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_149 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_149 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_149 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign _zz_249 = 1'b0;
  assign _zz_247 = (execute_MEMORY_MANAGMENT ? `DataCacheCpuCmdKind_binary_sequancial_MANAGMENT : `DataCacheCpuCmdKind_binary_sequancial_MEMORY);
  assign _zz_250 = execute_INSTRUCTION[28];
  assign _zz_251 = execute_INSTRUCTION[29];
  assign _zz_252 = execute_INSTRUCTION[30];
  assign _zz_88 = _zz_248[1 : 0];
  assign _zz_253 = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign _zz_254 = _zz_110[31];
  assign _zz_255 = 1'b1;
  assign _zz_256 = 1'b1;
  assign _zz_257 = 1'b1;
  assign _zz_258 = 1'b1;
  assign _zz_259 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_260 = (_zz_119 == (2'b00));
  assign writeBack_exception_agregat_valid = (((_zz_296 || _zz_299) || _zz_297) || _zz_298);
  assign writeBack_exception_agregat_payload_badAddr = _zz_300;
  always @ (*) begin
    writeBack_exception_agregat_payload_code = (4'bxxxx);
    if((_zz_297 || _zz_299))begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_329};
    end
    if(_zz_298)begin
      writeBack_exception_agregat_payload_code = {1'd0, _zz_330};
    end
    if(_zz_296)begin
      writeBack_exception_agregat_payload_code = (4'b1101);
    end
  end

  always @ (*) begin
    writeBack_DBusCachedPlugin_rspShifted = _zz_295;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_295[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusCachedPlugin_rspShifted[15 : 0] = _zz_295[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_295[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_150 = (writeBack_DBusCachedPlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_151[31] = _zz_150;
    _zz_151[30] = _zz_150;
    _zz_151[29] = _zz_150;
    _zz_151[28] = _zz_150;
    _zz_151[27] = _zz_150;
    _zz_151[26] = _zz_150;
    _zz_151[25] = _zz_150;
    _zz_151[24] = _zz_150;
    _zz_151[23] = _zz_150;
    _zz_151[22] = _zz_150;
    _zz_151[21] = _zz_150;
    _zz_151[20] = _zz_150;
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
    _zz_151[7 : 0] = writeBack_DBusCachedPlugin_rspShifted[7 : 0];
  end

  assign _zz_152 = (writeBack_DBusCachedPlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_153[31] = _zz_152;
    _zz_153[30] = _zz_152;
    _zz_153[29] = _zz_152;
    _zz_153[28] = _zz_152;
    _zz_153[27] = _zz_152;
    _zz_153[26] = _zz_152;
    _zz_153[25] = _zz_152;
    _zz_153[24] = _zz_152;
    _zz_153[23] = _zz_152;
    _zz_153[22] = _zz_152;
    _zz_153[21] = _zz_152;
    _zz_153[20] = _zz_152;
    _zz_153[19] = _zz_152;
    _zz_153[18] = _zz_152;
    _zz_153[17] = _zz_152;
    _zz_153[16] = _zz_152;
    _zz_153[15 : 0] = writeBack_DBusCachedPlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_318)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_151;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_153;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspShifted;
      end
    endcase
  end

  assign _zz_107 = _zz_277;
  assign _zz_108 = 1'b0;
  assign _zz_109 = 1'b1;
  assign _zz_110 = _zz_291;
  assign _zz_111 = 1'b0;
  assign _zz_112 = 1'b1;
  assign _zz_155 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010100)) == (32'b00000000000000000000000001000000));
  assign _zz_156 = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_157 = ((decode_INSTRUCTION & (32'b00000000000000000001000001010000)) == (32'b00000000000000000001000000000000));
  assign _zz_158 = ((decode_INSTRUCTION & (32'b00000000000000000000000000101000)) == (32'b00000000000000000000000000000000));
  assign _zz_159 = ((decode_INSTRUCTION & (32'b00000000000000000100000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_160 = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_161 = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_162 = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_163 = ((decode_INSTRUCTION & (32'b00000000000000000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_164 = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001010000));
  assign _zz_154 = {({(_zz_417 == _zz_418),{_zz_419,{_zz_420,_zz_421}}} != (5'b00000)),{({_zz_422,_zz_423} != (2'b00)),{({_zz_424,_zz_425} != (2'b00)),{(_zz_426 != _zz_427),{_zz_428,{_zz_429,_zz_430}}}}}};
  assign _zz_86 = ({((decode_INSTRUCTION & (32'b00000000000000000000000001011111)) == (32'b00000000000000000000000000010111)),{((decode_INSTRUCTION & (32'b00000000000000000001000001101111)) == (32'b00000000000000000000000000000011)),{((decode_INSTRUCTION & (32'b00000000000000000001000001111111)) == (32'b00000000000000000001000001110011)),{((decode_INSTRUCTION & _zz_558) == (32'b00000000000000000010000001110011)),{(_zz_559 == _zz_560),{_zz_561,{_zz_562,_zz_563}}}}}}} != (22'b0000000000000000000000));
  assign _zz_85 = _zz_331[0];
  assign _zz_165 = _zz_154[2 : 1];
  assign _zz_84 = _zz_165;
  assign _zz_83 = _zz_332[0];
  assign _zz_82 = _zz_333[0];
  assign _zz_166 = _zz_154[7 : 5];
  assign _zz_81 = _zz_166;
  assign _zz_80 = _zz_334[0];
  assign _zz_79 = _zz_335[0];
  assign _zz_78 = _zz_336[0];
  assign _zz_77 = _zz_337[0];
  assign _zz_76 = _zz_338[0];
  assign _zz_167 = _zz_154[14 : 13];
  assign _zz_75 = _zz_167;
  assign _zz_74 = _zz_339[0];
  assign _zz_73 = _zz_340[0];
  assign _zz_72 = _zz_341[0];
  assign _zz_168 = _zz_154[19 : 18];
  assign _zz_71 = _zz_168;
  assign _zz_70 = _zz_342[0];
  assign _zz_169 = _zz_154[22 : 21];
  assign _zz_69 = _zz_169;
  assign _zz_68 = _zz_343[0];
  assign _zz_67 = _zz_344[0];
  assign _zz_170 = _zz_154[26 : 25];
  assign _zz_66 = _zz_170;
  assign _zz_171 = _zz_154[28 : 27];
  assign _zz_65 = _zz_171;
  assign _zz_64 = _zz_345[0];
  assign _zz_63 = _zz_346[0];
  assign _zz_62 = _zz_347[0];
  assign decodeExceptionPort_valid = ((decode_arbitration_isValid && decode_INSTRUCTION_READY) && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = (4'b0010);
  assign decodeExceptionPort_payload_badAddr = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign _zz_172 = 1'b1;
  assign decode_RegFilePlugin_rs1Data = _zz_261;
  assign _zz_173 = 1'b1;
  assign decode_RegFilePlugin_rs2Data = _zz_262;
  assign _zz_61 = decode_RegFilePlugin_rs1Data;
  assign _zz_60 = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    writeBack_RegFilePlugin_regFileWrite_valid = (_zz_58 && writeBack_arbitration_isFiring);
    if(_zz_174)begin
      writeBack_RegFilePlugin_regFileWrite_valid = 1'b1;
    end
  end

  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_57[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_87;
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
        _zz_175 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequancial_SLT_SLTU : begin
        _zz_175 = {31'd0, _zz_348};
      end
      default : begin
        _zz_175 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_55 = _zz_175;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequancial_RS : begin
        _zz_176 = execute_RS1;
      end
      `Src1CtrlEnum_binary_sequancial_PC_INCREMENT : begin
        _zz_176 = {29'd0, _zz_349};
      end
      default : begin
        _zz_176 = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
    endcase
  end

  assign _zz_53 = _zz_176;
  assign _zz_177 = _zz_350[11];
  always @ (*) begin
    _zz_178[19] = _zz_177;
    _zz_178[18] = _zz_177;
    _zz_178[17] = _zz_177;
    _zz_178[16] = _zz_177;
    _zz_178[15] = _zz_177;
    _zz_178[14] = _zz_177;
    _zz_178[13] = _zz_177;
    _zz_178[12] = _zz_177;
    _zz_178[11] = _zz_177;
    _zz_178[10] = _zz_177;
    _zz_178[9] = _zz_177;
    _zz_178[8] = _zz_177;
    _zz_178[7] = _zz_177;
    _zz_178[6] = _zz_177;
    _zz_178[5] = _zz_177;
    _zz_178[4] = _zz_177;
    _zz_178[3] = _zz_177;
    _zz_178[2] = _zz_177;
    _zz_178[1] = _zz_177;
    _zz_178[0] = _zz_177;
  end

  assign _zz_179 = _zz_351[11];
  always @ (*) begin
    _zz_180[19] = _zz_179;
    _zz_180[18] = _zz_179;
    _zz_180[17] = _zz_179;
    _zz_180[16] = _zz_179;
    _zz_180[15] = _zz_179;
    _zz_180[14] = _zz_179;
    _zz_180[13] = _zz_179;
    _zz_180[12] = _zz_179;
    _zz_180[11] = _zz_179;
    _zz_180[10] = _zz_179;
    _zz_180[9] = _zz_179;
    _zz_180[8] = _zz_179;
    _zz_180[7] = _zz_179;
    _zz_180[6] = _zz_179;
    _zz_180[5] = _zz_179;
    _zz_180[4] = _zz_179;
    _zz_180[3] = _zz_179;
    _zz_180[2] = _zz_179;
    _zz_180[1] = _zz_179;
    _zz_180[0] = _zz_179;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequancial_RS : begin
        _zz_181 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequancial_IMI : begin
        _zz_181 = {_zz_178,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequancial_IMS : begin
        _zz_181 = {_zz_180,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_181 = _zz_49;
      end
    endcase
  end

  assign _zz_51 = _zz_181;
  assign execute_SrcPlugin_addSub = _zz_352;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_48 = execute_SrcPlugin_addSub;
  assign _zz_47 = execute_SrcPlugin_addSub;
  assign _zz_46 = execute_SrcPlugin_less;
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @ (*) begin
    _zz_182[0] = execute_SRC1[31];
    _zz_182[1] = execute_SRC1[30];
    _zz_182[2] = execute_SRC1[29];
    _zz_182[3] = execute_SRC1[28];
    _zz_182[4] = execute_SRC1[27];
    _zz_182[5] = execute_SRC1[26];
    _zz_182[6] = execute_SRC1[25];
    _zz_182[7] = execute_SRC1[24];
    _zz_182[8] = execute_SRC1[23];
    _zz_182[9] = execute_SRC1[22];
    _zz_182[10] = execute_SRC1[21];
    _zz_182[11] = execute_SRC1[20];
    _zz_182[12] = execute_SRC1[19];
    _zz_182[13] = execute_SRC1[18];
    _zz_182[14] = execute_SRC1[17];
    _zz_182[15] = execute_SRC1[16];
    _zz_182[16] = execute_SRC1[15];
    _zz_182[17] = execute_SRC1[14];
    _zz_182[18] = execute_SRC1[13];
    _zz_182[19] = execute_SRC1[12];
    _zz_182[20] = execute_SRC1[11];
    _zz_182[21] = execute_SRC1[10];
    _zz_182[22] = execute_SRC1[9];
    _zz_182[23] = execute_SRC1[8];
    _zz_182[24] = execute_SRC1[7];
    _zz_182[25] = execute_SRC1[6];
    _zz_182[26] = execute_SRC1[5];
    _zz_182[27] = execute_SRC1[4];
    _zz_182[28] = execute_SRC1[3];
    _zz_182[29] = execute_SRC1[2];
    _zz_182[30] = execute_SRC1[1];
    _zz_182[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequancial_SLL_1) ? _zz_182 : execute_SRC1);
  assign _zz_44 = _zz_361;
  always @ (*) begin
    _zz_183[0] = memory_SHIFT_RIGHT[31];
    _zz_183[1] = memory_SHIFT_RIGHT[30];
    _zz_183[2] = memory_SHIFT_RIGHT[29];
    _zz_183[3] = memory_SHIFT_RIGHT[28];
    _zz_183[4] = memory_SHIFT_RIGHT[27];
    _zz_183[5] = memory_SHIFT_RIGHT[26];
    _zz_183[6] = memory_SHIFT_RIGHT[25];
    _zz_183[7] = memory_SHIFT_RIGHT[24];
    _zz_183[8] = memory_SHIFT_RIGHT[23];
    _zz_183[9] = memory_SHIFT_RIGHT[22];
    _zz_183[10] = memory_SHIFT_RIGHT[21];
    _zz_183[11] = memory_SHIFT_RIGHT[20];
    _zz_183[12] = memory_SHIFT_RIGHT[19];
    _zz_183[13] = memory_SHIFT_RIGHT[18];
    _zz_183[14] = memory_SHIFT_RIGHT[17];
    _zz_183[15] = memory_SHIFT_RIGHT[16];
    _zz_183[16] = memory_SHIFT_RIGHT[15];
    _zz_183[17] = memory_SHIFT_RIGHT[14];
    _zz_183[18] = memory_SHIFT_RIGHT[13];
    _zz_183[19] = memory_SHIFT_RIGHT[12];
    _zz_183[20] = memory_SHIFT_RIGHT[11];
    _zz_183[21] = memory_SHIFT_RIGHT[10];
    _zz_183[22] = memory_SHIFT_RIGHT[9];
    _zz_183[23] = memory_SHIFT_RIGHT[8];
    _zz_183[24] = memory_SHIFT_RIGHT[7];
    _zz_183[25] = memory_SHIFT_RIGHT[6];
    _zz_183[26] = memory_SHIFT_RIGHT[5];
    _zz_183[27] = memory_SHIFT_RIGHT[4];
    _zz_183[28] = memory_SHIFT_RIGHT[3];
    _zz_183[29] = memory_SHIFT_RIGHT[2];
    _zz_183[30] = memory_SHIFT_RIGHT[1];
    _zz_183[31] = memory_SHIFT_RIGHT[0];
  end

  always @ (*) begin
    _zz_184 = 1'b0;
    _zz_185 = 1'b0;
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! _zz_189)))begin
        if(_zz_190)begin
          _zz_184 = 1'b1;
        end
        if(_zz_191)begin
          _zz_185 = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if(_zz_192)begin
          _zz_184 = 1'b1;
        end
        if(_zz_193)begin
          _zz_185 = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_REGFILE_WRITE_VALID))begin
      if((1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE)))begin
        if(_zz_194)begin
          _zz_184 = 1'b1;
        end
        if(_zz_195)begin
          _zz_185 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_184 = 1'b0;
    end
    if((! decode_RS2_USE))begin
      _zz_185 = 1'b0;
    end
  end

  assign _zz_189 = 1'b1;
  assign _zz_190 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_191 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_192 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_193 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_194 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign _zz_195 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign _zz_40 = _zz_103;
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_196 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_196 == (3'b000))) begin
        _zz_197 = execute_BranchPlugin_eq;
    end else if((_zz_196 == (3'b001))) begin
        _zz_197 = (! execute_BranchPlugin_eq);
    end else if((((_zz_196 & (3'b101)) == (3'b101)))) begin
        _zz_197 = (! execute_SRC_LESS);
    end else begin
        _zz_197 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_INC : begin
        _zz_198 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequancial_JAL : begin
        _zz_198 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        _zz_198 = 1'b1;
      end
      default : begin
        _zz_198 = _zz_197;
      end
    endcase
  end

  assign _zz_38 = (execute_PREDICTION_HAD_BRANCHED2 != _zz_198);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequancial_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_200,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = (execute_PREDICTION_HAD_BRANCHED2 ? _zz_366 : {{_zz_202,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
      end
    endcase
  end

  assign _zz_199 = _zz_363[11];
  always @ (*) begin
    _zz_200[19] = _zz_199;
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

  assign _zz_201 = _zz_364[11];
  always @ (*) begin
    _zz_202[18] = _zz_201;
    _zz_202[17] = _zz_201;
    _zz_202[16] = _zz_201;
    _zz_202[15] = _zz_201;
    _zz_202[14] = _zz_201;
    _zz_202[13] = _zz_201;
    _zz_202[12] = _zz_201;
    _zz_202[11] = _zz_201;
    _zz_202[10] = _zz_201;
    _zz_202[9] = _zz_201;
    _zz_202[8] = _zz_201;
    _zz_202[7] = _zz_201;
    _zz_202[6] = _zz_201;
    _zz_202[5] = _zz_201;
    _zz_202[4] = _zz_201;
    _zz_202[3] = _zz_201;
    _zz_202[2] = _zz_201;
    _zz_202[1] = _zz_201;
    _zz_202[0] = _zz_201;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_37 = {execute_BranchPlugin_branchAdder[31 : 1],((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequancial_JALR) ? 1'b0 : execute_BranchPlugin_branchAdder[0])};
  assign _zz_113 = (memory_BRANCH_DO && memory_arbitration_isFiring);
  assign _zz_114 = memory_BRANCH_CALC;
  assign memory_exception_agregat_valid = (memory_arbitration_isValid && (memory_BRANCH_DO && (memory_BRANCH_CALC[1 : 0] != (2'b00))));
  assign memory_exception_agregat_payload_code = (4'b0000);
  assign memory_exception_agregat_payload_badAddr = memory_BRANCH_CALC;
  assign decode_exception_agregat_valid = (_zz_106 || decodeExceptionPort_valid);
  assign _zz_203 = {decodeExceptionPort_valid,_zz_106};
  assign _zz_204 = _zz_367[1];
  assign _zz_205 = _zz_204;
  assign decode_exception_agregat_payload_code = _zz_267;
  assign decode_exception_agregat_payload_badAddr = _zz_268;
  assign execute_exception_agregat_valid = (_zz_117 || _zz_120);
  assign _zz_206 = {_zz_120,_zz_117};
  assign _zz_207 = _zz_369[1];
  assign _zz_208 = _zz_207;
  assign execute_exception_agregat_payload_code = _zz_269;
  assign execute_exception_agregat_payload_badAddr = _zz_270;
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
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  assign CsrPlugin_interruptRequest = ((((CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE) || (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE)) || (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE)) && CsrPlugin_mstatus_MIE);
  assign CsrPlugin_interrupt = (CsrPlugin_interruptRequest && _zz_121);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && _zz_122);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ((execute_arbitration_isValid || memory_arbitration_isValid) || writeBack_arbitration_isValid)) && IBusCachedPlugin_injector_nextPcCalc_valids_4);
    if(((CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptCode = ((CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE) ? (4'b1011) : _zz_372);
  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  assign contextSwitching = _zz_115;
  assign _zz_34 = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_33 = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = (execute_arbitration_isValid && execute_IS_CSR);
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_217;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b111100010001 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[3 : 0] = (4'b1011);
      end
      12'b111100010100 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b101100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b101110000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[63 : 32];
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b001100000101 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtvec;
      end
      12'b110011000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[12 : 0] = (13'b1000000000000);
        execute_CsrPlugin_readData[25 : 20] = (6'b100000);
      end
      12'b101100000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_minstret[31 : 0];
      end
      12'b111100010011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[5 : 0] = (6'b100001);
      end
      12'b001101000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mbadaddr;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_219;
      end
      12'b110000000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b001100000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 30] = CsrPlugin_misa_base;
        execute_CsrPlugin_readData[25 : 0] = CsrPlugin_misa_extensions;
      end
      12'b001101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mscratch;
      end
      12'b111100010010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[4 : 0] = (5'b10110);
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b101110000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_minstret[63 : 32];
      end
      12'b001101000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      default : begin
      end
    endcase
    if((_zz_119 < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
  end

  assign _zz_120 = (execute_CsrPlugin_illegalAccess || ((execute_arbitration_isValid && (_zz_119 == (2'b00))) && ((execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_EBREAK) || (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_MRET))));
  assign execute_CsrPlugin_writeSrc = (execute_INSTRUCTION[14] ? _zz_374 : execute_SRC1);
  always @ (*) begin
    case(_zz_319)
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
  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_320)
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
  assign _zz_32 = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_31 = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_30 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_29 = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_28 = ($signed(_zz_375) + $signed(_zz_383));
  assign writeBack_MulPlugin_result = ($signed(_zz_384) + $signed(_zz_385));
  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_314)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_done = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_done && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_389);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_210 = memory_DivPlugin_rs1[31 : 0];
  assign _zz_211 = {memory_DivPlugin_accumulator[31 : 0],_zz_210[31]};
  assign _zz_212 = (_zz_211 - _zz_390);
  assign _zz_213 = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_214 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_215 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_216[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_216[31 : 0] = execute_RS1;
  end

  assign _zz_219 = (_zz_217 & _zz_218);
  assign externalInterrupt = (_zz_219 != (32'b00000000000000000000000000000000));
  assign DebugPlugin_isPipBusy = (DebugPlugin_isPipActive || _zz_220);
  always @ (*) begin
    _zz_263 = 1'b1;
    _zz_123 = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_311)
        1'b0 : begin
        end
        default : begin
          if(debug_bus_cmd_payload_wr)begin
            _zz_123 = 1'b1;
            _zz_263 = _zz_124;
          end
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_221))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign debug_resetOut = _zz_222;
  assign _zz_27 = decode_BRANCH_CTRL;
  assign _zz_91 = _zz_75;
  assign _zz_39 = decode_to_execute_BRANCH_CTRL;
  assign _zz_25 = decode_ALU_CTRL;
  assign _zz_23 = _zz_71;
  assign _zz_54 = decode_to_execute_ALU_CTRL;
  assign _zz_22 = decode_SRC1_CTRL;
  assign _zz_20 = _zz_65;
  assign _zz_52 = decode_to_execute_SRC1_CTRL;
  assign _zz_19 = decode_ALU_BITWISE_CTRL;
  assign _zz_17 = _zz_84;
  assign _zz_56 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_16 = decode_ENV_CTRL;
  assign _zz_13 = execute_ENV_CTRL;
  assign _zz_11 = memory_ENV_CTRL;
  assign _zz_14 = _zz_81;
  assign _zz_35 = decode_to_execute_ENV_CTRL;
  assign _zz_9 = execute_to_memory_ENV_CTRL;
  assign _zz_36 = memory_to_writeBack_ENV_CTRL;
  assign _zz_8 = decode_SHIFT_CTRL;
  assign _zz_5 = execute_SHIFT_CTRL;
  assign _zz_6 = _zz_66;
  assign _zz_45 = decode_to_execute_SHIFT_CTRL;
  assign _zz_43 = execute_to_memory_SHIFT_CTRL;
  assign _zz_3 = decode_SRC2_CTRL;
  assign _zz_1 = _zz_69;
  assign _zz_50 = decode_to_execute_SRC2_CTRL;
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
  assign iBusWishbone_ADR = {_zz_410,_zz_225};
  assign iBusWishbone_CTI = ((_zz_225 == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    _zz_264 = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_312)begin
      _zz_264 = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_226;
  assign iBus_rsp_payload_data = _zz_227;
  assign iBus_rsp_payload_error = 1'b0;
  assign _zz_233 = (dBus_cmd_payload_length != (3'b000));
  assign _zz_229 = dBus_cmd_valid;
  assign _zz_231 = dBus_cmd_payload_wr;
  assign _zz_232 = (_zz_228 == dBus_cmd_payload_length);
  assign dBus_cmd_ready = (_zz_230 && (_zz_231 || _zz_232));
  assign dBusWishbone_ADR = ((_zz_233 ? {{dBus_cmd_payload_address[31 : 5],_zz_228},(2'b00)} : {dBus_cmd_payload_address[31 : 2],(2'b00)}) >>> 2);
  assign dBusWishbone_CTI = (_zz_233 ? (_zz_232 ? (3'b111) : (3'b010)) : (3'b000));
  assign dBusWishbone_BTE = (2'b00);
  assign dBusWishbone_SEL = (_zz_231 ? dBus_cmd_payload_mask : (4'b1111));
  assign _zz_265 = _zz_231;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_payload_data;
  assign _zz_230 = (_zz_229 && dBusWishbone_ACK);
  assign dBusWishbone_CYC = _zz_229;
  assign dBusWishbone_STB = _zz_229;
  assign dBus_rsp_valid = _zz_234;
  assign dBus_rsp_payload_data = _zz_235;
  assign dBus_rsp_payload_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      _zz_119 <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_131 <= 1'b0;
      _zz_133 <= 1'b0;
      _zz_138 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      _zz_174 <= 1'b1;
      _zz_186 <= 1'b0;
      CsrPlugin_misa_base <= (2'b01);
      CsrPlugin_misa_extensions <= (26'b00000000000000000001000010);
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
      CsrPlugin_writeBackWasWfi <= 1'b0;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      _zz_217 <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_223 <= (3'b000);
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
      _zz_225 <= (3'b000);
      _zz_226 <= 1'b0;
      _zz_228 <= (3'b000);
      _zz_234 <= 1'b0;
    end else begin
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_310)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_131 <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        _zz_133 <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_input_ready)begin
        _zz_133 <= IBusCachedPlugin_iBusRsp_input_valid;
      end
      if(_zz_136)begin
        _zz_138 <= (IBusCachedPlugin_iBusRsp_inputPipeline_0_valid && _zz_135);
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        _zz_138 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_inputPipeline_0_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_cacheRspArbitration_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_99))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      _zz_174 <= 1'b0;
      _zz_186 <= (_zz_58 && writeBack_arbitration_isFiring);
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
      CsrPlugin_writeBackWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == `EnvCtrlEnum_binary_sequancial_WFI));
      if(_zz_317)begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
        CsrPlugin_mstatus_MIE <= 1'b0;
        CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
        CsrPlugin_mstatus_MPP <= _zz_119;
      end
      if(_zz_316)begin
        if(! _zz_313) begin
          CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
          _zz_119 <= CsrPlugin_mstatus_MPP;
        end
      end
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_42;
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
      case(_zz_223)
        3'b000 : begin
          if(_zz_123)begin
            _zz_223 <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_223 <= (3'b010);
        end
        3'b010 : begin
          _zz_223 <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_223 <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_223 <= (3'b000);
        end
        default : begin
        end
      endcase
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_217 <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_403[0];
            CsrPlugin_mstatus_MIE <= _zz_404[0];
          end
        end
        12'b111100010001 : begin
        end
        12'b111100010100 : begin
        end
        12'b001101000001 : begin
        end
        12'b101100000000 : begin
        end
        12'b101110000000 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_405[0];
          end
        end
        12'b001100000101 : begin
        end
        12'b110011000000 : begin
        end
        12'b101100000010 : begin
        end
        12'b111100010011 : begin
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b110000000000 : begin
        end
        12'b001100000001 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_misa_base <= execute_CsrPlugin_writeData[31 : 30];
            CsrPlugin_misa_extensions <= execute_CsrPlugin_writeData[25 : 0];
          end
        end
        12'b001101000000 : begin
        end
        12'b111100010010 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_406[0];
            CsrPlugin_mie_MTIE <= _zz_407[0];
            CsrPlugin_mie_MSIE <= _zz_408[0];
          end
        end
        12'b101110000010 : begin
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_312)begin
        if(iBusWishbone_ACK)begin
          _zz_225 <= (_zz_225 + (3'b001));
        end
      end
      _zz_226 <= (_zz_264 && iBusWishbone_ACK);
      if((_zz_229 && _zz_230))begin
        _zz_228 <= (_zz_228 + (3'b001));
        if(_zz_232)begin
          _zz_228 <= (3'b000);
        end
      end
      _zz_234 <= ((_zz_229 && (! _zz_265)) && dBusWishbone_ACK);
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_input_ready)begin
      _zz_134 <= IBusCachedPlugin_iBusRsp_input_payload;
    end
    if(_zz_136)begin
      _zz_139 <= IBusCachedPlugin_iBusRsp_inputPipeline_0_payload;
    end
    _zz_187 <= _zz_57[11 : 7];
    _zz_188 <= _zz_87;
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
    if(execute_exception_agregat_valid)begin
      if((! ((1'b0 || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory) || CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack)))begin
        CsrPlugin_exceptionPortCtrl_exceptionContext_code <= execute_exception_agregat_payload_code;
        CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= execute_exception_agregat_payload_badAddr;
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
    if(_zz_317)begin
      CsrPlugin_mepc <= writeBack_PC;
      CsrPlugin_mcause_interrupt <= CsrPlugin_interruptJump;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_interruptCode;
    end
    _zz_209 <= CsrPlugin_exception;
    if(_zz_209)begin
      CsrPlugin_mbadaddr <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
      CsrPlugin_mcause_exceptionCode <= CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
    if(execute_arbitration_isValid)begin
      execute_CsrPlugin_readDataRegValid <= 1'b1;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_readDataRegValid <= 1'b0;
    end
    if(_zz_315)begin
      if(_zz_308)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_391[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_212[32]) ? _zz_392 : _zz_393);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_394[31:0];
        end
      end
    end
    if(_zz_314)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_215 ? (~ _zz_216) : _zz_216) + _zz_400);
      memory_DivPlugin_rs2 <= ((_zz_214 ? (~ execute_RS2) : execute_RS2) + _zz_402);
      memory_DivPlugin_div_needRevert <= (_zz_215 ^ (_zz_214 && (! execute_INSTRUCTION[13])));
    end
    _zz_218 <= externalInterruptArray;
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_41;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_26;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
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
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_24;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_21;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_18;
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
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_49;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_EBREAK <= decode_IS_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_93;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_92;
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
      decode_to_execute_ENV_CTRL <= _zz_15;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_12;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_10;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_7;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_CTRL <= _zz_4;
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
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
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
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b111100010001 : begin
      end
      12'b111100010100 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b101100000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcycle[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b101110000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcycle[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000100 : begin
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b110011000000 : begin
      end
      12'b101100000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_minstret[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111100010011 : begin
      end
      12'b001101000011 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mbadaddr <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111111000000 : begin
      end
      12'b110000000000 : begin
      end
      12'b001100000001 : begin
      end
      12'b001101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111100010010 : begin
      end
      12'b001100000100 : begin
      end
      12'b101110000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_minstret[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcause_interrupt <= _zz_409[0];
          CsrPlugin_mcause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
        end
      end
      default : begin
      end
    endcase
    _zz_227 <= iBusWishbone_DAT_MISO;
    _zz_235 <= dBusWishbone_DAT_MISO;
  end

  always @ (posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(_zz_263)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipActive <= (((decode_arbitration_isValid || execute_arbitration_isValid) || memory_arbitration_isValid) || writeBack_arbitration_isValid);
    _zz_220 <= DebugPlugin_isPipActive;
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_87;
    end
    _zz_221 <= debug_bus_cmd_payload_address[2];
    _zz_222 <= DebugPlugin_resetIt;
  end

  always @ (posedge clk) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if(debug_bus_cmd_valid)begin
        case(_zz_311)
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
      if(_zz_309)begin
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
    _zz_224 <= debug_bus_cmd_payload_data;
  end

endmodule

