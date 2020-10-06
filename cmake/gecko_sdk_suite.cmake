#######################################
#      Silicon Labs MCU Support       #
#######################################


#######################################
#      Gecko SDK Suite Location       #
#######################################
#Defines Gecko SDK Location
if(NOT DEFINED SL_GECKO_SDK_SUITE_VERSION)
  set(SL_GECKO_SDK_SUITE_VERSION "2.7")
  message(STATUS "SL_GECKO_SDK_SUITE_VERSION Version set to Default : ${SL_GECKO_SDK_SUITE_VERSION}")
endif()
set(SL_GECKO_SDK_SUITE_PATH "${CMAKE_CURRENT_LIST_DIR}/../gecko_sdk_suite/v${SL_GECKO_SDK_SUITE_VERSION}")

#Checks that SDK is present
if(NOT EXISTS "${SL_GECKO_SDK_SUITE_PATH}")
  message(FATAL_ERROR "Gecko SDK Suite not found: ${SL_GECKO_SDK_SUITE_PATH} does not exist")
endif()

#######################################
#    Part Number Specific Sources     #
#######################################


#######################################
#    Detect Series from Part Number   #
# Defines paths names for part number #
#######################################

set(SL_TARGET_PART_SERIES 99)
string(SUBSTRING ${SL_TARGET_PART_NO} 7 1 SL_TARGET_PART_SERIES)
string(SUBSTRING ${SL_TARGET_PART_NO} 8 1 SL_TARGET_PART_VARIANT)

if(SL_TARGET_PART_VARIANT MATCHES "[1-9]")
  if(${SL_TARGET_PART_SERIES} EQUAL "2")
    string(SUBSTRING ${SL_TARGET_PART_NO} 0 9 SL_TARGET_PART)
  else()
    string(SUBSTRING ${SL_TARGET_PART_NO} 0 10 SL_TARGET_PART)
  endif()
elseif(${SL_TARGET_PART_VARIANT} MATCHES "[A-Z]")
  string(SUBSTRING ${SL_TARGET_PART_NO} 0 9 SL_TARGET_PART)
endif()

string(TOLOWER ${SL_TARGET_PART} SL_TARGET_PART_LOWER_CASE)
string(TOUPPER ${SL_TARGET_PART} SL_TARGET_PART_UPPER_CASE)
string(TOUPPER ${SL_TARGET_PART_NO} SL_TARGET_PART_NO_UPPER_CASE)

#Checks that Device Part Number has a source folder in the SDK
if(NOT EXISTS "${SL_GECKO_SDK_SUITE_PATH}/platform/Device/SiliconLabs/${SL_TARGET_PART_UPPER_CASE}")
  message(FATAL_ERROR "Device Specific Sources not found for SL_TARGET_PART: ${SL_TARGET_PART_UPPER_CASE}")
else()
  set(SL_TARGET_PART_SOURCE_PATH "${SL_GECKO_SDK_SUITE_PATH}/platform/Device/SiliconLabs/${SL_TARGET_PART_UPPER_CASE}")
  message(STATUS "Target Sources found: ${SL_TARGET_PART_SOURCE_PATH}")
endif()

#######################################
#       Toolchain Related Setup       #
#######################################
include(${CMAKE_CURRENT_LIST_DIR}/toolchain.cmake)

#######################################
#  Part Series Specific Build Options #
#######################################

if(NOT SL_TARGET_PART_SERIES)
  set(SL_TARGET_PART_SERIES 0)
endif()
if(SL_TARGET_PART_SERIES LESS_EQUAL 2)
  message(STATUS "Target Series Found: ${SL_TARGET_PART_SERIES}")
  include(${CMAKE_CURRENT_LIST_DIR}/series${SL_TARGET_PART_SERIES}.cmake)
else()
  message(FATAL_ERROR "Error: EFX32_SERIES not defined (${SL_TARGET_PART_SERIES})")
endif()
