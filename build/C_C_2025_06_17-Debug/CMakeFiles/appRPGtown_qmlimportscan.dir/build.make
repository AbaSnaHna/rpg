# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.31

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /root/RPGtown

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /root/RPGtown/build/C_C_2025_06_17-Debug

# Utility rule file for appRPGtown_qmlimportscan.

# Include any custom commands dependencies for this target.
include CMakeFiles/appRPGtown_qmlimportscan.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appRPGtown_qmlimportscan.dir/progress.make

CMakeFiles/appRPGtown_qmlimportscan: .qt/qml_imports/appRPGtown_build.cmake

.qt/qml_imports/appRPGtown_build.cmake: /usr/lib/qt6/qmlimportscanner
.qt/qml_imports/appRPGtown_build.cmake: .qt/rcc/qmake_RPGtown.qrc
.qt/qml_imports/appRPGtown_build.cmake: .qt/rcc/appRPGtown_raw_qml_0.qrc
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/Main.qml
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/TownScreen.qml
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/WeaponShop.qml
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/Player.qml
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/PlayerData.qml
.qt/qml_imports/appRPGtown_build.cmake: /root/RPGtown/battleScene.qml
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running qmlimportscanner for appRPGtown"
	cd /root/RPGtown && /usr/lib/qt6/qmlimportscanner @/root/RPGtown/build/C_C_2025_06_17-Debug/.qt/qml_imports/appRPGtown_build.rsp

CMakeFiles/appRPGtown_qmlimportscan.dir/codegen:
.PHONY : CMakeFiles/appRPGtown_qmlimportscan.dir/codegen

appRPGtown_qmlimportscan: .qt/qml_imports/appRPGtown_build.cmake
appRPGtown_qmlimportscan: CMakeFiles/appRPGtown_qmlimportscan
appRPGtown_qmlimportscan: CMakeFiles/appRPGtown_qmlimportscan.dir/build.make
.PHONY : appRPGtown_qmlimportscan

# Rule to build all files generated by this target.
CMakeFiles/appRPGtown_qmlimportscan.dir/build: appRPGtown_qmlimportscan
.PHONY : CMakeFiles/appRPGtown_qmlimportscan.dir/build

CMakeFiles/appRPGtown_qmlimportscan.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appRPGtown_qmlimportscan.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appRPGtown_qmlimportscan.dir/clean

CMakeFiles/appRPGtown_qmlimportscan.dir/depend:
	cd /root/RPGtown/build/C_C_2025_06_17-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /root/RPGtown /root/RPGtown /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_qmlimportscan.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appRPGtown_qmlimportscan.dir/depend

