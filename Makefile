SRC := ${shell find . -type f -name \*.scala}

all: VexRiscv.v VexRiscv_Debug.v VexRiscv_Lite.v VexRiscv_LiteDebug.v VexRiscv_Min.v VexRiscv_MinDebug.v VexRiscv_Full.v VexRiscv_FullDebug.v VexRiscv_Linux.v VexRiscv_LinuxDebug.v VexRiscv_IMA.v

VexRiscv.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault"

VexRiscv_Debug.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault -d --outputFile VexRiscv_Debug"

VexRiscv_Lite.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv_Lite"

VexRiscv_LiteDebug.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault -d --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv_LiteDebug"

VexRiscv_Min.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv_Min"

VexRiscv_MinDebug.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault -d --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv_MinDebug"

VexRiscv_Full.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --csrPluginConfig all --outputFile VexRiscv_Full"

VexRiscv_FullDebug.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --csrPluginConfig all -d --outputFile VexRiscv_FullDebug"

VexRiscv_Linux.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --csrPluginConfig linux-minimal --outputFile VexRiscv_Linux"

VexRiscv_LinuxDebug.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --csrPluginConfig linux-minimal -d --outputFile VexRiscv_LinuxDebug"

VexRiscv_IMA.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --atomics true --prediction dynamic_target --dCacheSize 8192 --iCacheSize 8192 --earlyBranch true --pmpRegions 4 --pmpGranularity 4096 --csrPluginConfig secure --outputFile VexRiscv_IMA --privateNamespace true"

VexRiscv_IMA_wide.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --atomics true --prediction dynamic_target --dCacheSize 8192 --iCacheSize 8192 --earlyBranch true --widenedBus true --pmpRegions 4 --pmpGranularity 4096 --csrPluginConfig secure --outputFile VexRiscv_IMA_wide --privateNamespace true"

VexRiscv_G.v: $(SRC)
	sbt compile "runMain vexriscv.GenCoreDefault --atomics true --prediction dynamic_target --dCacheSize 8192 --iCacheSize 8192 --earlyBranch true --fpu true --withDouble true --pmpRegions 4 --pmpGranularity 4096 --csrPluginConfig secure --outputFile VexRiscv_G --privateNamespace true"
