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
  dCacheSize : Int = 4096,
  mulDiv : Boolean = true,
  singleCycleMulDiv : Boolean = true,
  bypass : Boolean = true,
  externalInterruptArray : Boolean = true,
  prediction : BranchPrediction = STATIC,
  outputFile : String = "VexRiscv",
  csrPluginConfig : String = "small"
)

object GenCoreDefault{
  val predictionMap = Map(
    "none" -> NONE,
    "static" -> STATIC,
    "dynamic" -> DYNAMIC,
    "dynamic_target" -> DYNAMIC_TARGET
  )

  def main(args: Array[String]) {

    // Allow arguments to be passed ex:
    // sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize=1024"
    val parser = new scopt.OptionParser[ArgConfig]("VexRiscvGen") {
      //  ex :-d    or   --debug
      opt[Unit]('d', "debug")    action { (_, c) => c.copy(debug = true)   } text("Enable debug")
      // ex : -iCacheSize=XXX
      opt[Int]("iCacheSize")     action { (v, c) => c.copy(iCacheSize = v) } text("Set instruction cache size, 0 mean no cache")
      // ex : -dCacheSize=XXX
      opt[Int]("dCacheSize")     action { (v, c) => c.copy(dCacheSize = v) } text("Set data cache size, 0 mean no cache")
      opt[Boolean]("mulDiv")    action { (v, c) => c.copy(mulDiv = v)   } text("set RV32IM")
      opt[Boolean]("singleCycleMulDiv")    action { (v, c) => c.copy(singleCycleMulDiv = v)   } text("If true, MUL/DIV/Shifts are single-cycle")
      opt[Boolean]("bypass")    action { (v, c) => c.copy(bypass = v)   } text("set pipeline interlock/bypass")
      opt[Boolean]("externalInterruptArray")    action { (v, c) => c.copy(externalInterruptArray = v)   } text("switch between regular CSR and array like one")
      opt[String]("prediction")    action { (v, c) => c.copy(prediction = predictionMap(v))   } text("switch between regular CSR and array like one")
      opt[String]("outputFile")    action { (v, c) => c.copy(outputFile = v) } text("output file name")
      opt[String]("csrPluginConfig")  action { (v, c) => c.copy(csrPluginConfig = v) } text("switch between 'small' and 'all' version of control and status registers configuration")
    }
    val argConfig = parser.parse(args, ArgConfig()).get

    SpinalConfig.copy(netlistFileName = argConfig.outputFile + ".v").generateVerilog {
      // Generate CPU plugin list
      val plugins = ArrayBuffer[Plugin[VexRiscv]]()

      plugins ++= List(
        if(argConfig.iCacheSize <= 0){
          new IBusSimplePlugin(
            resetVector = null,
            prediction = argConfig.prediction
          )
        }else {
          new IBusCachedPlugin(
            resetVector = null,
            relaxedPcCalculation = false,
            prediction = argConfig.prediction,
            config = InstructionCacheConfig(
              cacheSize = argConfig.iCacheSize,
              bytePerLine = 32,
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
          )
        },

        if(argConfig.dCacheSize <= 0){
          new DBusSimplePlugin(
            catchAddressMisaligned = false,
            catchAccessFault = false
          )
        }else {
          new DBusCachedPlugin(
            config = new DataCacheConfig(
              cacheSize = argConfig.dCacheSize,
              bytePerLine = 32,
              wayCount = 1,
              addressWidth = 32,
              cpuDataWidth = 32,
              memDataWidth = 32,
              catchAccessError = true,
              catchIllegal = true,
              catchUnaligned = true,
              catchMemoryTranslationMiss = true
            ),
            memoryTranslatorPortConfig = null,
            csrInfo = true
          )
        },

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
        if(argConfig.singleCycleMulDiv) {
          new FullBarrelShifterPlugin
        }else {
          new LightShifterPlugin
        },
        new HazardSimplePlugin(
          bypassExecute           = argConfig.bypass,
          bypassMemory            = argConfig.bypass,
          bypassWriteBack         = argConfig.bypass,
          bypassWriteBackBuffer   = argConfig.bypass,
          pessimisticUseSrc       = false,
          pessimisticWriteRegFile = false,
          pessimisticAddressMatch = false
        ),
        new BranchPlugin(
          earlyBranch = false,
          catchAddressMisaligned = true
        ),
        new CsrPlugin(
          if(argConfig.csrPluginConfig == "all") {
            CsrPluginConfig.all(mtvecInit = null)
          }else {
            CsrPluginConfig.small(mtvecInit = null).copy(mtvecAccess = WRITE_ONLY)
          }
        ),
        new YamlPlugin(argConfig.outputFile.concat(".yaml"))
      )

      if(argConfig.mulDiv) {
        if(argConfig.singleCycleMulDiv) {
          plugins ++= List(
            new MulPlugin,
            new DivPlugin
          )
        }else {
          plugins ++= List(
            new MulDivIterativePlugin(
              genMul = true,
              genDiv = true,
              mulUnrollFactor = 1,
              divUnrollFactor = 1
            )
          )
        }
      }

      if(argConfig.externalInterruptArray) plugins ++= List(
        new ExternalInterruptArrayPlugin(
          maskCsrId = 0xBC0,
          pendingsCsrId = 0xFC0
        )
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
          case plugin: IBusSimplePlugin => {
            plugin.iBus.asDirectionLess() //Unset IO properties of iBus
            master(plugin.iBus.toWishbone()).setName("iBusWishbone")
          }
          case plugin: IBusCachedPlugin => {
            plugin.iBus.asDirectionLess()
            master(plugin.iBus.toWishbone()).setName("iBusWishbone")
          }
          case plugin: DBusSimplePlugin => {
            plugin.dBus.asDirectionLess()
            master(plugin.dBus.toWishbone()).setName("dBusWishbone")
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
