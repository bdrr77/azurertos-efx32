#######################################
#      Series 2 Project Config        #
#######################################

#######################################
###### Cortex Arch of the target  #####
#######################################
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m33)


#######################################
###### C Compiler flags Config  #######
#######################################
set(CMAKE_C_STANDARD            99)
set(CMAKE_C_EXTENSIONS          OFF)
set(CMAKE_C_STANDARD_REQUIRED   ON)

set(CMAKE_C_FLAGS                   "-mthumb -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -fmessage-length=0 -fdata-sections -ffunction-sections -Wall -Wextra")

set(CMAKE_C_FLAGS_DEBUG             "-g3 -gdwarf-2 -O0 -mno-sched-prolog -fno-builtin")
set(CMAKE_C_FLAGS_RELEASE           "-O2")
set(CMAKE_C_FLAGS_RELWITHDEBINFO    "-O2 -g")
set(CMAKE_C_FLAGS_MINSIZEREL        "-Os")

#######################################
##### C++ Compiler flags Config  ######
#######################################
#TODO

#######################################
##### ASM Compiler flags Config  ######
#######################################
set(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -c -x assembler-with-cpp")

set(CMAKE_ASM_FLAGS_DEBUG " -g3 -gdwarf-2")
set(CMAKE_ASM_FLAGS_RELEASE "")
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "-g")
set(CMAKE_ASM_FLAGS_MINSIZEREL "")

#######################################
######## Linker flags Config  #########
#######################################
set(CMAKE_C_LINK_FLAGS "-mcpu=cortex-m33 -mthumb -T ${SL_TARGET_PART_SOURCE_PATH}/Source/${SL_TOOLCHAIN}/${SL_TARGET_PART_LOWER_CASE}.ld -Xlinker --gc-sections -Xlinker -Map=${CMAKE_PROJECT_NAME}.map -mfpu=fpv5-sp-d16 -mfloat-abi=hard --specs=nano.specs -Wl,--start-group -lgcc -lc -lm -lnosys -Wl,--end-group")
#TODO CXX linker flags CMAKE_CXX_LINK_FLAGS
