all: VexRiscv.v VexRiscv_Debug.v VexRiscv_Lite.v VexRiscv_LiteDebug.v VexRiscv_Min.v VexRiscv_MinDebug.v

VexRiscv.v:
	sbt compile "run-main vexriscv.GenCoreDefault"

VexRiscv_Debug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --outputFile VexRiscv_Debug"

VexRiscv_Lite.v:
	sbt compile "run-main vexriscv.GenCoreDefault --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv_Lite"

VexRiscv_LiteDebug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv_LiteDebug"

VexRiscv_Min.v:
	sbt compile "run-main vexriscv.GenCoreDefault --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv_Min"

VexRiscv_MinDebug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv_MinDebug"
