# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appRPGtown_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appRPGtown_autogen.dir\\ParseCache.txt"
  "appRPGtown_autogen"
  )
endif()
