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

# Utility rule file for appRPGtown_qmltyperegistration.

# Include any custom commands dependencies for this target.
include CMakeFiles/appRPGtown_qmltyperegistration.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appRPGtown_qmltyperegistration.dir/progress.make

CMakeFiles/appRPGtown_qmltyperegistration: apprpgtown_qmltyperegistrations.cpp
CMakeFiles/appRPGtown_qmltyperegistration: RPGtown/appRPGtown.qmltypes

apprpgtown_qmltyperegistrations.cpp: qmltypes/appRPGtown_foreign_types.txt
apprpgtown_qmltyperegistrations.cpp: meta_types/qt6apprpgtown_debug_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/qmltyperegistrar
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6core_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qml_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6network_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6quick_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6gui_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qmlmeta_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qmlmodels_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qmlworkerscript_relwithdebinfo_metatypes.json
apprpgtown_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6opengl_relwithdebinfo_metatypes.json
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic QML type registration for target appRPGtown"
	/usr/lib/qt6/qmltyperegistrar --generate-qmltypes=/root/RPGtown/build/C_C_2025_06_17-Debug/RPGtown/appRPGtown.qmltypes --import-name=RPGtown --major-version=1 --minor-version=0 @/root/RPGtown/build/C_C_2025_06_17-Debug/qmltypes/appRPGtown_foreign_types.txt -o /root/RPGtown/build/C_C_2025_06_17-Debug/apprpgtown_qmltyperegistrations.cpp /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/qt6apprpgtown_debug_metatypes.json
	/usr/bin/cmake -E make_directory /root/RPGtown/build/C_C_2025_06_17-Debug/.qt/qmltypes
	/usr/bin/cmake -E touch /root/RPGtown/build/C_C_2025_06_17-Debug/.qt/qmltypes/appRPGtown.qmltypes

RPGtown/appRPGtown.qmltypes: apprpgtown_qmltyperegistrations.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate RPGtown/appRPGtown.qmltypes

meta_types/qt6apprpgtown_debug_metatypes.json: meta_types/qt6apprpgtown_debug_metatypes.json.gen
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating meta_types/qt6apprpgtown_debug_metatypes.json"
	/usr/bin/cmake -E true

meta_types/qt6apprpgtown_debug_metatypes.json.gen: /usr/lib/qt6/moc
meta_types/qt6apprpgtown_debug_metatypes.json.gen: meta_types/appRPGtown_json_file_list.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Running moc --collect-json for target appRPGtown"
	/usr/lib/qt6/moc -o /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/qt6apprpgtown_debug_metatypes.json.gen --collect-json @/root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/appRPGtown_json_file_list.txt
	/usr/bin/cmake -E copy_if_different /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/qt6apprpgtown_debug_metatypes.json.gen /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/qt6apprpgtown_debug_metatypes.json

meta_types/appRPGtown_json_file_list.txt: /usr/lib/qt6/cmake_automoc_parser
meta_types/appRPGtown_json_file_list.txt: appRPGtown_autogen/timestamp
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Running AUTOMOC file extraction for target appRPGtown"
	/usr/lib/qt6/cmake_automoc_parser --cmake-autogen-cache-file /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_autogen.dir/ParseCache.txt --cmake-autogen-info-file /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_autogen.dir/AutogenInfo.json --output-file-path /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/appRPGtown_json_file_list.txt --timestamp-file-path /root/RPGtown/build/C_C_2025_06_17-Debug/meta_types/appRPGtown_json_file_list.txt.timestamp --cmake-autogen-include-dir-path /root/RPGtown/build/C_C_2025_06_17-Debug/appRPGtown_autogen/include

appRPGtown_autogen/timestamp: /usr/lib/qt6/moc
appRPGtown_autogen/timestamp: CMakeFiles/appRPGtown_qmltyperegistration.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Automatic MOC and UIC for target appRPGtown"
	/usr/bin/cmake -E cmake_autogen /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_autogen.dir/AutogenInfo.json Debug
	/usr/bin/cmake -E touch /root/RPGtown/build/C_C_2025_06_17-Debug/appRPGtown_autogen/timestamp

CMakeFiles/appRPGtown_qmltyperegistration.dir/codegen:
.PHONY : CMakeFiles/appRPGtown_qmltyperegistration.dir/codegen

appRPGtown_qmltyperegistration: CMakeFiles/appRPGtown_qmltyperegistration
appRPGtown_qmltyperegistration: RPGtown/appRPGtown.qmltypes
appRPGtown_qmltyperegistration: appRPGtown_autogen/timestamp
appRPGtown_qmltyperegistration: apprpgtown_qmltyperegistrations.cpp
appRPGtown_qmltyperegistration: meta_types/appRPGtown_json_file_list.txt
appRPGtown_qmltyperegistration: meta_types/qt6apprpgtown_debug_metatypes.json
appRPGtown_qmltyperegistration: meta_types/qt6apprpgtown_debug_metatypes.json.gen
appRPGtown_qmltyperegistration: CMakeFiles/appRPGtown_qmltyperegistration.dir/build.make
.PHONY : appRPGtown_qmltyperegistration

# Rule to build all files generated by this target.
CMakeFiles/appRPGtown_qmltyperegistration.dir/build: appRPGtown_qmltyperegistration
.PHONY : CMakeFiles/appRPGtown_qmltyperegistration.dir/build

CMakeFiles/appRPGtown_qmltyperegistration.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appRPGtown_qmltyperegistration.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appRPGtown_qmltyperegistration.dir/clean

CMakeFiles/appRPGtown_qmltyperegistration.dir/depend:
	cd /root/RPGtown/build/C_C_2025_06_17-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /root/RPGtown /root/RPGtown /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug /root/RPGtown/build/C_C_2025_06_17-Debug/CMakeFiles/appRPGtown_qmltyperegistration.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appRPGtown_qmltyperegistration.dir/depend

