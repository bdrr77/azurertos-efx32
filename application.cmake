
# Minimal compiling sources
target_sources(${PROJECT_NAME}
    PRIVATE
    
    #Startup and System
    ${SL_TARGET_PART_SOURCE_PATH}/Source/system_${SL_TARGET_PART_LOWER_CASE}.c
    ${SL_TARGET_PART_SOURCE_PATH}/Source/${SL_TOOLCHAIN}/startup_${SL_TARGET_PART_LOWER_CASE}.c

    #Emlib
    ${SL_GECKO_SDK_SUITE_PATH}/platform/emlib/src/em_cmu.c
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
)

set(SL_TARGET_PART_NO_UPPER_CASE, "")
string(TOUPPER ${SL_TARGET_PART_NO} SL_TARGET_PART_NO_UPPER_CASE)
#add_compile_definitions(${SL_TARGET_PART_NO_UPPER_CASE}=1)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        -D${SL_TARGET_PART_NO_UPPER_CASE}=1
)

# Print executable size
add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${SIZE} ${PROJECT_NAME})

# Create hex file
add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${OBJCOPY} -O ihex ${PROJECT_NAME} ${PROJECT_NAME}.hex
        COMMAND ${OBJCOPY} -O binary ${PROJECT_NAME} ${PROJECT_NAME}.bin)


#set_source_file_properties
#get_source_file_property