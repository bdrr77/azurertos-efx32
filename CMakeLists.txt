
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
###### toolchain settings        #####
#######################################
if(NOT DEFINED EFX32_SERIES)
  message(STATUS "EFX32_SERIES not defined, trying to compile with host defaults")
else()
  if(EFX32_SERIES LESS_EQUAL 2)
    message(STATUS "Compiling for EFx32 Series : ${EFX32_SERIES}")
    include(${CMAKE_CURRENT_LIST_DIR}/cmake/series1.cmake)
  else()
    message(STATUS "EFX32_SERIES not defined, trying to compile with host defaults")
  endif()
endif()

#######################################
##### Prints Build Configuration  #####
#######################################

if(CMAKE_CXX_COMPILER_LOADED)
  message(STATUS "C++ compiler is: ${CMAKE_CXX_COMPILER}")
  message(STATUS "C++ compiler version is: ${CMAKE_CXX_COMPILER_VERSION}")
  
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
  #message(STATUS "C compiler version is: ${CMAKE_C_COMPILER_VERSION}")
  
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
  #message(STATUS "ASM compiler version is: ${CMAKE_ASM_COMPILER_VERSION}")
  
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

add_executable(main main.c)
