# Package

version       = "0.2.0"
author        = "Luciano Lorenzo"
description   = "Manage your clipboard remotely"
license       = "MIT"
srcDir        = "src"


bin = @["servclip"]
binDir = "build"

# Dependencies

requires "nim >= 1.5.1"
requires "jester"
requires "nimclipboard"
requires "bluesoftcosmos"

task build_release, "Builds the release version":
  exec "nimble -d:release build"
task build_danger, "Builds the danger version":
  exec "nimble -d:danger build"
