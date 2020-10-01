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
set(CMAKE_C_LINK_FLAGS "-mcpu=cortex-m4 -mthumb -T ${SL_TARGET_PART_SOURCE_PATH}/Source/${SL_TOOLCHAIN}/${SL_TARGET_PART_LOWER_CASE}.ld -Xlinker --gc-sections -Xlinker -Map=${CMAKE_PROJECT_NAME}.map -mfpu=fpv4-sp-d16 -mfloat-abi=softfp --specs=nano.specs -Wl,--start-group -lgcc -lc -lnosys -Wl,--end-group")
#TODO CXX linker flags CMAKE_CXX_LINK_FLAGS
