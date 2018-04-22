
lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.github.spinalhdl",
      scalaVersion := "2.11.6",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "VexRiscvMisoc"
  ).dependsOn(vexRiscv)

lazy val vexRiscv = RootProject(uri("git://github.com/SpinalHDL/VexRiscv.git#c7d852c49705870a8e2b69e35a390181d746ce91"))

addCompilerPlugin("org.scala-lang.plugins" % "scala-continuations-plugin_2.11.6" % "1.0.2")
scalacOptions += "-P:continuations:enable"
fork := true