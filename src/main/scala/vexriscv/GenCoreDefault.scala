package vexriscv

import spinal.core._
import spinal.lib._
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.plugin.CsrAccess.WRITE_ONLY
import vexriscv.plugin._

import scala.collection.mutable.ArrayBuffer

object SpinalConfig extends spinal.core.SpinalConfig(
  defaultConfigForClockDomains = ClockDomainConfig(
    resetKind = spinal.core.SYNC
  )
)

case class ArgConfig(
  debug : Boolean = false,
  iCacheSize : Int = 4096,
  dCacheSize : Int = 4096
)

object GenCoreDefault{
  def main(args: Array[String]) {
    SpinalConfig.generateVerilog {

      // Allow arguments to be passed ex:
      // sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize=1024"
      val parser = new scopt.OptionParser[ArgConfig]("VexRiscvGen") {
        //  ex :-d    or   --debug
        opt[Unit]('d', "debug")    action { (_, c) => c.copy(debug = true)   } text("Enable debug")
        // ex : -iCacheSize=XXX
        opt[Int]("iCacheSize")     action { (v, c) => c.copy(iCacheSize = v) } text("Set instruction cache size")
        // ex : -dCacheSize=XXX
        opt[Int]("dCacheSize")     action { (v, c) => c.copy(dCacheSize = v) } text("Set data cache size")
      }
      val argConfig = parser.parse(args, ArgConfig()).get

      // Generate CPU plugin list
      val plugins = ArrayBuffer[Plugin[VexRiscv]]()
      plugins ++= List(
        new IBusCachedPlugin(
          resetVector = null,
          relaxedPcCalculation = false,
          prediction = STATIC,
          config = InstructionCacheConfig(
            cacheSize = argConfig.iCacheSize,
            bytePerLine =32,
            wayCount = 1,
            addressWidth = 32,
            cpuDataWidth = 32,
            memDataWidth = 32,
            catchIllegalAccess = true,
            catchAccessFault = true,
            catchMemoryTranslationMiss = true,
            asyncTagMemory = false,
            twoCycleRam = true,
            twoCycleCache = true
          )
        ),
        new DBusCachedPlugin(
          config = new DataCacheConfig(
            cacheSize         = argConfig.dCacheSize,
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
        new FullBarrelShifterPlugin,
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
        new BranchPlugin(
          earlyBranch = false,
          catchAddressMisaligned = true
        ),
        new CsrPlugin(
          config = CsrPluginConfig.small(mtvecInit = null).copy(mtvecAccess = WRITE_ONLY)
        ),
        new ExternalInterruptArrayPlugin(
          maskCsrId = 0xBC0,
          pendingsCsrId = 0xFC0
        ),
        new YamlPlugin("cpu0.yaml")
      )

      // Add in the Debug plugin, if requested
      if(argConfig.debug) {
        plugins += new DebugPlugin(ClockDomain.current.clone(reset = Bool().setName("debugReset")))
      }

      // CPU configuration
      val cpuConfig = VexRiscvConfig(plugins.toList)

      // CPU instantiation
      val cpu = new VexRiscv(cpuConfig)

      // CPU modifications to be an Wishbone one
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
