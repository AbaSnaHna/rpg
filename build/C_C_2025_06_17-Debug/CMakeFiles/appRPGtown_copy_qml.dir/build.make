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

# Utility rule file for appRPGtown_copy_qml.

# Include any custom commands dependencies for this target.
include CMakeFiles/appRPGtown_copy_qml.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appRPGtown_copy_qml.dir/progress.make

CMakeFiles/appRPGtown_copy_qml: .qt/appRPGtown_qml.txt

.qt/appRPGtown_qml.txt: /usr/lib/cmake/Qt6Qml/Qt6QmlCopyFiles.cmake
.qt/appRPGtown_qml.txt: /root/RPGtown/Main.qml
.qt/appRPGtown_qml.txt: /root/RPGtown/TownScreen.qml
.qt/appRPGtown_qml.txt: /root/RPGtown/WeaponShop.qml
.qt/appRPGtown_qml.txt: /root/RPGtown/Player.qml
.qt/appRPGtown_qml.txt: /root/RPGtown/PlayerData.qml
.qt/appRPGtown_qml.txt: /root/RPGtown/battleScene.qml
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Copying appRPGtown qml sources into build dir"
	/usr/bin/cmake -DFILES_INFO_PATH=/root/RPGtown/build/C_C_2025_06_17-Debug/.qt/appRPGtown_qml.cmake -P /usr/lib/cmake/Qt6Qml/Qt6QmlCopyFiles.cmake

CMakeFiles/appRPGtown_copy_qml.dir/codegen:
.PHONY : CMakeFiles/appRPGtown_copy_qml.dir/codegen

appRPGtown_copy_qml: .qt/appRPGtown_qml.txt
appRPGtown_copy_qml: CMakeFiles/appRPGtown_copy_qml
appRPGtown_copy_qml: CMakeFiles/appRPGtown_copy_qml.dir/build.make
.PHONY : appRPGtown_copy_qml

# Rule to build all files generated by this target.
CMakeFiles/appRPGtown_copy_qml.dir/build: appRPGtown_copy_qml
.PHONY : CMakeFiles/appRPGtown_copy_qml.dir/build

CMakeFiles/appRPGtown_copy_qml.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appRPGtown_copy_qml.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appRPGtown_copy_qml.dir/clean

CMakeFiles/appRPGtown_copy_qml.dir/depend:
	cd /root/RPGtown/build/C_C_2025_06_17-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /root/RPGtown /root/RPGtown /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_copy_qml.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appRPGtown_copy_qml.dir/depend

