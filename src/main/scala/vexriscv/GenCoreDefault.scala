package vexriscv

import spinal.core._
import spinal.core.internals.{ExpressionContainer, PhaseAllocateNames, PhaseContext}
import spinal.lib._
import spinal.lib.sim.Phase
import vexriscv.ip.{DataCacheConfig, InstructionCacheConfig}
import vexriscv.plugin.CsrAccess.WRITE_ONLY
import vexriscv.plugin._

import scala.collection.mutable.ArrayBuffer

object SpinalConfig extends spinal.core.SpinalConfig(
  defaultConfigForClockDomains = ClockDomainConfig(
    resetKind = spinal.core.SYNC
  )
){
  //Insert a compilation phase which will add a  (* ram_style = "block" *) on all synchronous rams.
  phasesInserters += {(array) => array.insert(array.indexWhere(_.isInstanceOf[PhaseAllocateNames]) + 1, new ForceRamBlockPhase)}
}

case class ArgConfig(
  debug : Boolean = false,
  iCacheSize : Int = 4096,
  dCacheSize : Int = 4096,
  mulDiv : Boolean = true,
  singleCycleMulDiv : Boolean = true,
  bypass : Boolean = true,
  externalInterruptArray : Boolean = true,
  resetVector : BigInt = null,
  machineTrapVector : BigInt = null,
  prediction : BranchPrediction = STATIC,
  outputFile : String = "VexRiscv",
  csrPluginConfig : String = "small",
  dBusCachedRelaxedMemoryTranslationRegister : Boolean = false,
  dBusCachedEarlyWaysHits : Boolean = true
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
      opt[Boolean]("dBusCachedRelaxedMemoryTranslationRegister")    action { (v, c) => c.copy(dBusCachedRelaxedMemoryTranslationRegister = v)   } text("If set, it give the d$ it's own address register between the execute/memory stage.")
      opt[Boolean]("dBusCachedEarlyWaysHits")    action { (v, c) => c.copy(dBusCachedEarlyWaysHits = v)   } text("If set, the d$ way hit calculation is done in the memory stage, else in the writeback stage.")
      opt[String]("resetVector")    action { (v, c) => c.copy(resetVector = BigInt(if(v.startsWith("0x")) v.tail.tail else v, 16))   } text("Specify the CPU reset vector in hexadecimal. If not specified, an 32 bits input is added to the CPU to set durring instanciation")
      opt[String]("machineTrapVector")    action { (v, c) => c.copy(machineTrapVector = BigInt(if(v.startsWith("0x")) v.tail.tail else v, 16))   } text("Specify the CPU machine trap vector in hexadecimal. If not specified, it take a unknown value when the design boot")
      opt[String]("prediction")    action { (v, c) => c.copy(prediction = predictionMap(v))   } text("switch between regular CSR and array like one")
      opt[String]("outputFile")    action { (v, c) => c.copy(outputFile = v) } text("output file name")
      opt[String]("csrPluginConfig")  action { (v, c) => c.copy(csrPluginConfig = v) } text("switch between 'small', 'all', 'linux' and 'linux-minimal' version of control and status registers configuration")
    }
    val argConfig = parser.parse(args, ArgConfig()).get
    val linux = argConfig.csrPluginConfig.startsWith("linux")

    SpinalConfig.copy(netlistFileName = argConfig.outputFile + ".v").generateVerilog {
      // Generate CPU plugin list
      val plugins = ArrayBuffer[Plugin[VexRiscv]]()

      plugins ++= List(
        if(argConfig.iCacheSize <= 0){
          new IBusSimplePlugin(
            resetVector = argConfig.resetVector,
            prediction = argConfig.prediction,
            cmdForkOnSecondStage = false,
            cmdForkPersistence = false, //Not required as the wishbone bridge ensure it
            memoryTranslatorPortConfig = if(linux) MmuPortConfig(portTlbSize = 4)
          )
        }else {
          new IBusCachedPlugin(
            resetVector = argConfig.resetVector,
            relaxedPcCalculation = false,
            prediction = argConfig.prediction,
            memoryTranslatorPortConfig = if(linux) MmuPortConfig(portTlbSize = 4),
            config = InstructionCacheConfig(
              cacheSize = argConfig.iCacheSize,
              bytePerLine = 32,
              wayCount = 1,
              addressWidth = 32,
              cpuDataWidth = 32,
              memDataWidth = 32,
              catchIllegalAccess = true,
              catchAccessFault = true,
              asyncTagMemory = false,
              twoCycleRam = false,
              twoCycleCache = true
            )
          )
        },

        if(argConfig.dCacheSize <= 0){
          new DBusSimplePlugin(
            catchAddressMisaligned = true,
            catchAccessFault = true,
            withLrSc = linux,
            memoryTranslatorPortConfig = if(linux) MmuPortConfig(portTlbSize = 4)
          )
        }else {
          new DBusCachedPlugin(
            dBusCmdMasterPipe = true,
            dBusCmdSlavePipe = true,
            dBusRspSlavePipe = false,
            relaxedMemoryTranslationRegister = argConfig.dBusCachedRelaxedMemoryTranslationRegister,
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
              withLrSc = linux,
              withAmo = linux,
              earlyWaysHits = argConfig.dBusCachedEarlyWaysHits
            ),
            memoryTranslatorPortConfig = if(linux) MmuPortConfig(portTlbSize = 4),
            csrInfo = true
          )
        },
        if(linux) new MmuPlugin(
          ioRange = (x => x(31 downto 28) === 0xB || x(31 downto 28) === 0xE || x(31 downto 28) === 0xF)
        )  else new StaticMemoryTranslatorPlugin(
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
          argConfig.csrPluginConfig match {
            case "small" => CsrPluginConfig.small(mtvecInit = argConfig.machineTrapVector).copy(mtvecAccess = WRITE_ONLY)
            case "all" => CsrPluginConfig.all(mtvecInit = argConfig.machineTrapVector)
            case "linux" => CsrPluginConfig.linuxFull(mtVecInit = argConfig.machineTrapVector).copy(ebreakGen = false)
            case "linux-minimal" => CsrPluginConfig.linuxMinimal(mtVecInit = argConfig.machineTrapVector).copy(ebreakGen = false)
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
          machineMaskCsrId = 0xBC0,
          machinePendingsCsrId = 0xFC0,
          supervisorMaskCsrId = 0x9C0,
          supervisorPendingsCsrId = 0xDC0
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

      // CPU modifications to be an Wishbone
      cpu.rework {
        for (plugin <- cpuConfig.plugins) plugin match {
          case plugin: IBusSimplePlugin => {
            plugin.iBus.setAsDirectionLess() //Unset IO properties of iBus
            master(plugin.iBus.toWishbone()).setName("iBusWishbone")
          }
          case plugin: IBusCachedPlugin => {
            plugin.iBus.setAsDirectionLess()
            master(plugin.iBus.toWishbone()).setName("iBusWishbone")
          }
          case plugin: DBusSimplePlugin => {
            plugin.dBus.setAsDirectionLess()
            master(plugin.dBus.toWishbone()).setName("dBusWishbone")
          }
          case plugin: DBusCachedPlugin => {
            plugin.dBus.setAsDirectionLess()
            master(plugin.dBus.toWishbone()).setName("dBusWishbone")
          }
          case _ =>
        }
      }

      cpu
    }
  }
}


class ForceRamBlockPhase() extends spinal.core.internals.Phase{
  override def impl(pc: PhaseContext): Unit = {
    pc.walkBaseNodes{
      case mem: Mem[_] => {
        var asyncRead = false
        mem.dlcForeach[MemPortStatement]{
          case _ : MemReadAsync => asyncRead = true
          case _ =>
        }
        if(!asyncRead) mem.addAttribute("ram_style", "block")
      }
      case _ =>
    }
  }
  override def hasNetlistImpact: Boolean = false
}