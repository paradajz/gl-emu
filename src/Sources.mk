GEN_DIR := gen

vpath modules/%.cpp ../
vpath modules/%.c ../
vpath gen/%.cpp ../
vpath gen/%.c ../
vpath gen/%.s ../

INCLUDE_DIRS :=  \
-I"../$(GEN_DIR)/Inc" \
-I"../$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Inc" \
-I"../$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy" \
-I"../$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Core/Inc" \
-I"../$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc" \
-I"../$(GEN_DIR)/Drivers/CMSIS/Device/ST/STM32F4xx/Include" \
-I"../$(GEN_DIR)/Drivers/CMSIS/Include" \
-I"./" \
-I"../tests" \
-I"../tests/unity" \
-I"../modules"

LINKER_SCRIPT := ../$(GEN_DIR)/STM32F407VGTx_FLASH.ld

SOURCES := $(shell find ./ -name "*.cpp")

SOURCES += \
$(GEN_DIR)/Src/main.c \
$(GEN_DIR)/Src/system_stm32f4xx.c \
$(GEN_DIR)/startup_stm32f407xx.s \
$(GEN_DIR)/Src/usbd_conf.c \
$(GEN_DIR)/Src/usbd_desc.c \
$(GEN_DIR)/Src/usbd_cdc_if.c \
$(GEN_DIR)/Src/usb_device.c \
$(GEN_DIR)/Src/stm32f4xx_it.c \
$(GEN_DIR)/Src/stm32f4xx_hal_msp.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd_ex.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c \
$(GEN_DIR)/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c \
$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c \
$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c \
$(GEN_DIR)/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/usbd_cdc.c \
modules/unity/src/unity.c

#make sure all objects are located in build directory
OBJECTS := $(addprefix $(BUILD_DIR)/,$(SOURCES))
#also make sure objects have .o extension
OBJECTS := $(OBJECTS:.c=.o)
OBJECTS := $(OBJECTS:.cpp=.o)
OBJECTS := $(OBJECTS:.s=.o)
OBJECTS := $(OBJECTS:.asm=.o)

#include generated dependency files to allow incremental build when only headers change
-include $(OBJECTS:%.o=%.d)

#include generated dependency files to allow incremental build when only headers change
-include $(OBJECTS:%.o=%.d)