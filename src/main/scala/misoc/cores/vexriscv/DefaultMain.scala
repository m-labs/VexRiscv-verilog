package misoc.cores.vexriscv

import spinal.core._
import spinal.lib._
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.plugin._
import vexriscv.{VexRiscv, VexRiscvConfig, plugin}






object DefaultMain{
  def main(args: Array[String]) {
    val report = SpinalVerilog{

      //CPU configuration
      val cpuConfig = VexRiscvConfig(
        plugins = List(
          new PcManagerSimplePlugin(0x00000000l, false),
          new IBusCachedPlugin(
            config = InstructionCacheConfig(
              cacheSize = 4096,
              bytePerLine =32,
              wayCount = 1,
              addressWidth = 32,
              cpuDataWidth = 32,
              memDataWidth = 32,
              catchIllegalAccess = true,
              catchAccessFault = true,
              catchMemoryTranslationMiss = true,
              asyncTagMemory = false,
              twoCycleRam = true
            )
          ),
          new DBusCachedPlugin(
            config = new DataCacheConfig(
              cacheSize         = 4096,
              bytePerLine       = 32,
              wayCount          = 1,
              addressWidth      = 32,
              cpuDataWidth      = 32,
              memDataWidth      = 32,
              catchAccessError  = true,
              catchIllegal      = true,
              catchUnaligned    = true,
              catchMemoryTranslationMiss = true
            ),
            memoryTranslatorPortConfig = null,
            csrInfo = true
          ),
          new StaticMemoryTranslatorPlugin(
            ioRange      = _.msb
          ),
          new DecoderSimplePlugin(
            catchIllegalInstruction = true
          ),
          new RegFilePlugin(
            regFileReadyKind = plugin.SYNC,
            zeroBoot = false
          ),
          new IntAluPlugin,
          new SrcPlugin(
            separatedAddSub = false,
            executeInsertion = true
          ),
          new FullBarrielShifterPlugin,
          new MulPlugin,
          new DivPlugin,
          new HazardSimplePlugin(
            bypassExecute           = true,
            bypassMemory            = true,
            bypassWriteBack         = true,
            bypassWriteBackBuffer   = true,
            pessimisticUseSrc       = false,
            pessimisticWriteRegFile = false,
            pessimisticAddressMatch = false
          ),
          //          new DebugPlugin(ClockDomain.current.clone(reset = Bool().setName("debugReset"))),
          new BranchPlugin(
            earlyBranch = false,
            catchAddressMisaligned = true,
            prediction = STATIC
          ),
          new CsrPlugin(
            config = CsrPluginConfig.small(mtvecInit = 0x00000020l)
          ),
          new ExternalInterruptArrayPlugin(),
          new YamlPlugin("cpu0.yaml")
        )
      )

      //CPU instanciation
      val cpu = new VexRiscv(cpuConfig)

      //CPU modifications to be an Wishbone one
      cpu.rework {
        for (plugin <- cpuConfig.plugins) plugin match {

          case plugin: IBusCachedPlugin => {
            plugin.iBus.asDirectionLess() //Unset IO properties of iBus
            master(plugin.iBus.toWishbone()).setName("iBusWishbone")
          }
          case plugin: DBusCachedPlugin => {
            plugin.dBus.asDirectionLess()
            master(plugin.dBus.toWishbone()).setName("dBusWishbone")
          }
          case _ =>
        }
      }
      cpu
    }
  }
}