
#######################################
#      Toolchain specific Cmake       #
#######################################

#######################################
#      Defines default toolchain      #
#######################################
if(NOT DEFINED SL_TOOLCHAIN)
  set(SL_TOOLCHAIN "GCC")
  message(STATUS "SL_TOOLCHAIN set to Default : ${SL_TOOLCHAIN}")
endif()

#Checks that Device Part Number has a source folder in the SDK
if(NOT EXISTS "${SL_TARGET_PART_SOURCE_PATH}/Source/${SL_TOOLCHAIN}")
  message(FATAL_ERROR "Toolchain:${SL_TOOLCHAIN}. Not supported by Gecko SDK Suite")
endif()

#######################################
#    Sets per toolchain CMAKE vars    #
#######################################
if(SL_TOOLCHAIN MATCHES GCC)
# which compilers to use
set(CMAKE_C_COMPILER    arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER  arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER  arm-none-eabi-gcc)
set(AR                  arm-none-eabi-ar)
set(OBJCOPY             arm-none-eabi-objcopy)
set(OBJDUMP             arm-none-eabi-objdump)
set(SIZE                arm-none-eabi-size)
elseif(SL_TOOLCHAIN MATCHES IAR)
#TODO check we are on Windows
message(FATAL_ERROR "Toolchain Only supported on Windows: ${SL_TOOLCHAIN}")
else()
message(FATAL_ERROR "Unsupported Toolchain SL_TOOLCHAIN: ${SL_TOOLCHAIN}")
endif()


#######################################
#   Extra options to enable           #
#   dedicated linker flags only       #
#######################################
#Had to reconfigure LINKER so it does not take C or CXX flags into account (as we use -c to compile only there)
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_C_COMPILER>  <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER>  <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
