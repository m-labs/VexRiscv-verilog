
## General informations 
This repository contain a Wishbone VexRiscv configuration in : <br>
src/main/scala/misoc/cores/vexriscv DefaultMain.scala

- RV32IM
- 5 stage : F -> D -> E -> M  -> WB + fully bypassed
- single cycle ADD/SUB/Bitwise/Shift ALU
- i$ : 4 kB 1 way
- d$ : 4 kB 1 way + victim buffer
- Branch prediction => Static
- branch/jump done in the M stage
- memory load values are bypassed in the WB stage (late result) 
- 33 cycle division with bypassing in the M stage (late result)
- single cycle multiplication with bypassing in the WB stage (late result)
- Light subset of the RISC-V machine CSR with an 32 bits external interrupt extension


## Requirements

- Java 8
- SBT (Scala build tool, kind of make file but for scala)

On Debian => 

```sh
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk -y
sudo update-alternatives --config java
sudo update-alternatives --config javac

echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt -y
```

## Usages

##### Generate the verilog from default core configuration : 

```sh
sbt compile "run-main misoc.cores.vexriscv.DefaultMain"
```

Note : The first time you run it it will take time to download all dependancies (including Scala itself). You have time to drink a coffee.

##### Cleaning SBT :

```sh
sbt clean reload 
```

##### Updating the VexRiscv : 

The build.sbt file is the "makefile" of this scala project. In it you can update the following lines to change the VexRiscv version :

```scala
lazy val vexRiscv = RootProject(uri("VexRiscvGitRepositoryUrl[#commitHash]"))
```

If you want you can also use a local folder as a VexRiscv version : 

```scala
lazy val vexRiscv = RootProject(file("local/path/to/the/VexRiscv"))
```


