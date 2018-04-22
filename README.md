
## General informations 
This repository contain a Wishbone VexRiscv configuration in : <br>
src/main/scala/misoc/cores/vexriscv DefaultMain.scala

## Requirements

- Java 8
- SBT

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


