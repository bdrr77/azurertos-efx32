**Azure RTOS implemetation for Silicon Labs EFx32 devices**

This repository is an implementation of Microsoft's Azure RTOS on top of Silicon Labs (W)MCUs

*Original work can be found on the [Azure RTOS Github](https://github.com/azure-rtos)*

---

## Generate build configuration using CMake

In order to build the project, you will need Cmake.

1. In a shell type **mkdir build** 
2. Then cd into the build folder **cd build**
3. Call cmake utility, passing your EFx32 series no and Part number **cmake -DEFX32_SERIES=1 -DSL_TARGET_PART=EFM32GG11B -GNinja ..**
4. Finally build using cmake **cmake --build .**

---

## CMake Architecture

Top level CMakeLists.txt is responsible for managing build configurations and target
**Build Configurations**
Default build configuration is Debug

However one can be specified using *-DCMAKE_BUILD_TYPE=*
Supported Build Configurations are :
* Debug
* Release
* RelWithDebInfo
* MinSizeRel

**Target Management**
When no *SL_TARGET_PART* is defined it tries to build the app for the host subsystem
Otherwise, it will look for what is needed in the Gecko SDK Suite for the specified Target through sub cmake files located in cmake/

cmake include flow for MCU targets is as follows:

1. CMakeLists includes *gecko_sdk_suite.cmake*
2. *gecko_sdk_suite.cmake* looks for a valid Gecko SDK Suite folder using *SL_GECKO_SDK_SUITE_VERSION* (defaults to 2.7)
3. *gecko_sdk_suite.cmake* looks for a valid Target specific source folder in the SDK 
    This is located in gecko_sdk_suite/v2.x/platform/Device/SiliconLabs/
4. *gecko_sdk_suite.cmake* then includes toolchain specific option set in *toolchain.cmake*
    *toolchain.cmake* is responsible for setting CMake bin utils and defining the *SL_TOOLCHAIN* for proper Gecko SDK build
    It defaults to GCC, but can be user defined to IAR or KEIL depending on support from Sources folder
5. Finally, *gecko_sdk_suite.cmake* automatically detects the series family of the device to include specific build and link flags (Cortex M4, CortexM33 etc...)

CMakeLists.txt
|
├── _gecko_sdk_suite.cmake
│   ├── toolchain.cmake
│   └── seriesx.cmake
|



