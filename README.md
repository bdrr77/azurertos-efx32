**Azure RTOS implemetation for Silicon Labs EFx32 devices**

This repository is an implementation of Microsoft's Azure RTOS on top of Silicon Labs (W)MCUs

*Original work can be found on the [Azure RTOS Github](https://github.com/azure-rtos)*

---

## Generate build configuration using CMake

In order to build the project, you will need Cmake.

1. In a shell type **mkdir build** 
2. Then cd into the build folder **cd build**
3. Call cmake utility, passing your EFx32 series no and Part number **cmake -DEFX32_SERIES=1 -DTARGET_PART_NO=EFM32GG11B -GNinja ..**
4. Finally build using cmake **cmake --build .**
