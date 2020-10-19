

###############################################
# Azure Third party code
###############################################

############ Threadx #############
#TODO make Cortex and GNU Dynamic
set(THREADX_ARCH "cortex_m4")
set(THREADX_TOOLCHAIN "gnu")
set(THREADX_PROJECT_NAME "threadx")
set(THREADX_PROJECT_PATH "${CMAKE_CURRENT_LIST_DIR}/${THREADX_PROJECT_NAME}")

if(NOT DEFINED THREADX_ARCH)
    message(FATAL_ERROR "Error: THREADX_ARCH not defined")
endif()
if(NOT DEFINED THREADX_TOOLCHAIN)
    message(FATAL_ERROR "Error: THREADX_TOOLCHAIN not defined")
endif()

# A place for generated/copied include files (no need to change)
set(CUSTOM_INC_DIR ${CMAKE_CURRENT_BINARY_DIR}/custom_inc)

# Pick up the port specific variables and apply them
add_subdirectory(${THREADX_PROJECT_PATH}/ports/${THREADX_ARCH}/${THREADX_TOOLCHAIN})
# Pick up the common stuff
add_subdirectory(${THREADX_PROJECT_PATH}/common)

############ Netxduo #############
set(NETXDUO_PROJECT_NAME "netxduo")
set(NETXDUO_PROJECT_PATH "${CMAKE_CURRENT_LIST_DIR}/${NETXDUO_PROJECT_NAME}")

# Pick up the port specific variables and apply them
add_subdirectory(${NETXDUO_PROJECT_PATH}/ports/${THREADX_ARCH}/${THREADX_TOOLCHAIN})
# Pick up the common stuff
add_subdirectory(${NETXDUO_PROJECT_PATH}/common)
# Pick up the apps directory containing the protocol and app-layer components
add_subdirectory(${NETXDUO_PROJECT_PATH}/addons)
# Network security and crypto components
add_subdirectory(${NETXDUO_PROJECT_PATH}/crypto_libraries)
add_subdirectory(${NETXDUO_PROJECT_PATH}/nx_secure)

###############################################
# Gecko SDK & Application Code
###############################################

set(PROJECT_ROOT_DIR ${CMAKE_CURRENT_LIST_DIR})

# Minimal compiling sources
target_sources(${PROJECT_NAME}
    PRIVATE

    #Startup and System
    ${SL_TARGET_PART_SOURCE_PATH}/Source/system_${SL_TARGET_PART_LOWER_CASE}.c
    ${SL_TARGET_PART_SOURCE_PATH}/Source/${SL_TOOLCHAIN}/startup_${SL_TARGET_PART_LOWER_CASE}.S

    #Emlib
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_cmu.c
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_emu.c
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_gpio.c
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_core.c
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_usart.c

    #Retargeting printf
    ${SL_GECKO_SDK_SUITE_PATH}/hardware/kit/common/drivers/retargetio.c
    ${SL_GECKO_SDK_SUITE_PATH}/hardware/kit/common/drivers/retargetserial.c

    #Threadx
    ${PROJECT_ROOT_DIR}/threadx_port/tx_initialize_low_level.S
    
    #Netxduo
    ${PROJECT_ROOT_DIR}/netxduo_port/nx_driver_efm32gg11b_low_level.s
    ${PROJECT_ROOT_DIR}/netxduo_port/nx_driver_efm32gg11b.c
)

# Minimal Include Paths
target_include_directories(${PROJECT_NAME} 
    PUBLIC 

    #Startup and System
    ${SL_TARGET_PART_SOURCE_PATH}/Include

    #Emlib
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/inc

    #CMSIS
    ${SL_GECKO_SDK_SUITE_PATH}/platform/CMSIS/Include

    #Retargeting printf
    ${SL_GECKO_SDK_SUITE_PATH}/hardware/kit/common/drivers/
    ${SL_GECKO_SDK_SUITE_PATH}/hardware/kit/common/bsp/
    ${SL_GECKO_SDK_SUITE_PATH}/hardware/kit/SLSTK3701A_EFM32GG11/config

    #Threadx
    ${THREADX_PROJECT_PATH}/common/inc

    #Netxduo
    ${NETXDUO_PROJECT_PATH}/common/inc
    ${PROJECT_ROOT_DIR}/netxduo_port
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        -D${SL_TARGET_PART_NO_UPPER_CASE}=1
        -DRETARGET_VCOM=1
        #-DNX_DRIVER_SOURCE=1
)

###############################################
# Post Build
###############################################
# Print executable size
add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${SIZE} ${PROJECT_NAME} -A)

# Create hex & bin file
add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${OBJCOPY} -O ihex ${PROJECT_NAME} ${PROJECT_NAME}.hex
        COMMAND ${OBJCOPY} -O binary ${PROJECT_NAME} ${PROJECT_NAME}.bin)

