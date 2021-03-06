
#######################################
###### Set minimum cmake version ######
#######################################
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

#######################################
###### Project name and language ######
#######################################
project(azurertos-efx32
    VERSION 0.0.1
    LANGUAGES C ASM
)

#######################################
##### Default Build Configuration: ####
##### Debug                        ####
#######################################
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
endif()
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

#######################################
###### Include Platform Specific ######
###### settings                  ######
#######################################
if(NOT DEFINED SL_TARGET_PART_NO)
  message(STATUS "No Silicon Labs target MCU defined, trying to compile with host defaults")
  message(STATUS "Hint: Run cmake defining -DSL_TARGET_PART_NO=EFM32GG11B820F2048GL192")
else()
  message(STATUS "Compiling for : ${SL_TARGET_PART_NO}")
  include(${CMAKE_CURRENT_LIST_DIR}/cmake/gecko_sdk_suite.cmake)
endif()

#######################################
##### Prints Build Configuration   ####
##### before Application settings  ####
#######################################
if(CMAKE_CXX_COMPILER_LOADED)
  message(STATUS "C++ compiler is: ${CMAKE_CXX_COMPILER}")

  message(STATUS "C++ flags, base configuration: ${CMAKE_CXX_FLAGS}")
  if(CMAKE_BUILD_TYPE MATCHES Debug)
    message(STATUS "C++ flags, Debug configuration: ${CMAKE_CXX_FLAGS_DEBUG}")
  elseif(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "C++ flags, Release configuration: ${CMAKE_CXX_FLAGS_RELEASE}")
  elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
    message(STATUS "C++ flags, Release configuration with Debug info: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
  elseif(CMAKE_BUILD_TYPE MATCHES MinSizeRel)
    message(STATUS "C++ flags, minimal Release configuration: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
  else()
    message(STATUS "Unknown build type, no CXX Flags.")
  endif()
endif()

if(CMAKE_C_COMPILER_LOADED)
  message(STATUS "C compiler is: ${CMAKE_C_COMPILER}")
  
  message(STATUS "C flags, base configuration: ${CMAKE_C_FLAGS}")
  if(CMAKE_BUILD_TYPE MATCHES Debug)
    message(STATUS "C flags, Debug configuration: ${CMAKE_C_FLAGS_DEBUG}")
  elseif(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "C flags, Release configuration: ${CMAKE_C_FLAGS_RELEASE}")
  elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
    message(STATUS "C flags, Release configuration with Debug info: ${CMAKE_C_FLAGS_RELWITHDEBINFO}")
  elseif(CMAKE_BUILD_TYPE MATCHES MinSizeRel)
    message(STATUS "C flags, minimal Release configuration: ${CMAKE_C_FLAGS_MINSIZEREL}")
  else()
    message(STATUS "Unknown build type, no C Flags")
  endif()
endif()

if(CMAKE_ASM_COMPILER_LOADED)
  message(STATUS "ASM compiler is: ${CMAKE_ASM_COMPILER}")
  
  message(STATUS "ASM flags, base configuration: ${CMAKE_ASM_FLAGS}")
  if(CMAKE_BUILD_TYPE MATCHES Debug)
    message(STATUS "ASM flags, Debug configuration: ${CMAKE_ASM_FLAGS_DEBUG}")
  elseif(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "ASM flags, Release configuration: ${CMAKE_ASM_FLAGS_RELEASE}")
  elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
    message(STATUS "ASM flags, Release configuration with Debug info: ${CMAKE_ASM_FLAGS_RELWITHDEBINFO}")
  elseif(CMAKE_BUILD_TYPE MATCHES MinSizeRel)
    message(STATUS "ASM flags, minimal Release configuration: ${CMAKE_ASM_FLAGS_MINSIZEREL}")
  else()
    message(STATUS "Unknown build type, no ASM Flags")
  endif()
endif()

if(DEFINED CMAKE_CXX_LINK_FLAGS)
  message(STATUS "C++ Linker Flags: ${CMAKE_CXX_LINK_FLAGS}")
endif()

if(DEFINED CMAKE_C_LINK_FLAGS)
  message(STATUS "C Linker Flags: ${CMAKE_C_LINK_FLAGS}")
endif()

#######################################
##### Include Application Specific ####
##### settings                     ####
#######################################

#Start from main
add_executable(${PROJECT_NAME} main.c)

if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/application.cmake)
  include(${CMAKE_CURRENT_LIST_DIR}/application.cmake)
  message(STATUS "Building complete application using: ${CMAKE_CURRENT_LIST_DIR}/application.cmake")
else()
  message(STATUS "Building application using main.c only")
endif()

