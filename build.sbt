
lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.github.spinalhdl",
      scalaVersion := "2.11.12",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "VexRiscvOnWishbone"
  ).dependsOn(vexRiscv)

lazy val vexRiscv = RootProject(file("ext/VexRiscv"))
fork := true
