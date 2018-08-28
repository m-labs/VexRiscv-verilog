all: VexRiscv.v VexRiscv-Debug.v VexRiscv-Lite.v VexRiscv-LiteDebug.v VexRiscv-Min.v VexRiscv-MinDebug.v

VexRiscv.v:
	sbt compile "run-main vexriscv.GenCoreDefault"

VexRiscv-Debug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --outputFile VexRiscv-Debug"

VexRiscv-Lite.v:
	sbt compile "run-main vexriscv.GenCoreDefault --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv-Lite"

VexRiscv-LiteDebug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize 2048 --dCacheSize 0 --mulDiv true --singleCycleMulDiv false --outputFile VexRiscv-LiteDebug"

VexRiscv-Min.v:
	sbt compile "run-main vexriscv.GenCoreDefault --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv-Min"

VexRiscv-MinDebug.v:
	sbt compile "run-main vexriscv.GenCoreDefault -d --iCacheSize 0 --dCacheSize 0 --mulDiv false --singleCycleMulDiv false --bypass false --prediction none --outputFile VexRiscv-MinDebug"
