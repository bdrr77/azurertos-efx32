

###############################################
# Azure Third party code
###############################################

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

    #Threadx
    ${PROJECT_ROOT_DIR}/threadx_port/tx_initialize_low_level.S

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

    #Threadx
    ${THREADX_PROJECT_PATH}/common/inc

)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        -D${SL_TARGET_PART_NO_UPPER_CASE}=1
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

