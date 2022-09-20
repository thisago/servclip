# Package

version       = "0.4.0"
author        = "Thiago Navarro"
description   = "Manage your clipboard remotely"
license       = "MIT"
srcDir        = "src"


bin = @["servclip"]
binDir = "build"

# Dependencies

requires "nim >= 1.5.1"
requires "jester"
requires "cliptomania"
requires "nimclipboard"
requires "bluesoftcosmos"

from std/strformat import fmt
from std/os import `/`

task buildRelease, "Builds the release version":
  echo "Compiling for the current platform"
  exec fmt"nimble -d:danger --opt:speed build"
  exec fmt"strip {binDir / bin[0]}"

task buildWinRelease, "Builds the release version for Windows":
  echo "Compiling x64 for windows"
  exec fmt"nimble -d:danger --opt:speed -d:mingw build"
  exec fmt"strip {binDir / bin[0]}.exe"
  withDir binDir:
    mvFile fmt"{bin[0]}.exe", fmt"{bin[0]}_x64.exe"

# task buildReleaseX86, "Builds the release version x86":
#   echo "Compiling x86 for the current platform"
#   exec fmt"nimble -d:danger --cpu:i386 --opt:speed build"
#   exec fmt"strip {binDir / bin[0]}"
#   withDir binDir:
#     mvFile bin[0], fmt"{bin[0]}_x86"

task buildWinReleaseX86, "Builds the release version x86 for Windows":
  echo "Compiling x86 for windows"
  exec fmt"nimble -d:danger --cpu:i386 --opt:speed -d:mingw build"
  exec fmt"strip {binDir / bin[0]}.exe"
  withDir binDir:
    mvFile fmt"{bin[0]}.exe", fmt"{bin[0]}_x86.exe"

task buildAllRelease, "Builds the release version for Windows and Linux":
  buildReleaseTask()
  buildWinReleaseTask()
  # buildReleaseX86Task()
  buildWinReleaseX86Task()
