#######################################
#      Series 1 Project Config        #
#######################################

#######################################
###### Cortex Arch of the target  #####
#######################################
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)


#######################################
###### C Compiler flags Config  #######
#######################################
set(CMAKE_C_STANDARD            99)
set(CMAKE_C_EXTENSIONS          OFF)
set(CMAKE_C_STANDARD_REQUIRED   ON)

set(CMAKE_C_FLAGS                   "-mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -c -fmessage-length=0 -fdata-sections -ffunction-sections -Wall")

set(CMAKE_C_FLAGS_DEBUG             "${CMAKE_C_FLAGS} -g3 -gdwarf-2 -O0 -mno-sched-prolog -fno-builtin")
set(CMAKE_C_FLAGS_RELEASE           "${CMAKE_C_FLAGS} -O2")
set(CMAKE_C_FLAGS_RELWITHDEBINFO    "${CMAKE_C_FLAGS} -O2 -g")
set(CMAKE_C_FLAGS_MINSIZEREL        "${CMAKE_C_FLAGS} -Os")

#######################################
##### C++ Compiler flags Config  ######
#######################################
#TODO

#######################################
##### ASM Compiler flags Config  ######
#######################################
set(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -c -x assembler-with-cpp")

set(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS} -g3 -gdwarf-2")
set(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS}")
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "${CMAKE_ASM_FLAGS} -g")
set(CMAKE_ASM_FLAGS_MINSIZEREL "${CMAKE_ASM_FLAGS}")

#######################################
######## Linker flags Config  #########
#######################################
if(NOT DEFINED TARGET_PART)
  message(FATAL_ERROR "Error: TARGET_PART not defined")
else()
  message(STATUS "Target Part: ${TARGET_PART}")
endif()

set(TARGET_PART_UPPER, "")
set(TARGET_PART_LOWER, "")

string(TOLOWER ${TARGET_PART} TARGET_PART_LOWER)
string(TOUPPER ${TARGET_PART} TARGET_PART_UPPER)

set(CMAKE_C_LINK_FLAGS "-mcpu=cortex-m4 -mthumb -T ../gecko_sdk_suite/v2.7/platform/Device/SiliconLabs/${TARGET_PART_UPPER}/Source/GCC/${TARGET_PART_LOWER}.ld -Xlinker --gc-sections -Xlinker -Map=linkerMapFile.map -mfpu=fpv4-sp-d16 -mfloat-abi=softfp --specs=nano.specs")
#TODO CXX linker flags CMAKE_CXX_LINK_FLAGS

#######################################
######### Toolchain Bin Utils #########
#######################################
include(${CMAKE_CURRENT_LIST_DIR}/toolchain.cmake)
