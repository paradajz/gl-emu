
BUILD_DIR := ./build
TARGETNAME := gl-emu
TARGET := $(BUILD_DIR)/$(TARGETNAME)

include Defines.mk
include Sources.mk

#specify compilers
C_COMPILER := arm-none-eabi-gcc
CPP_COMPILER := arm-none-eabi-g++
ASM_COMPILER := arm-none-eabi-gcc -x assembler-with-cpp

#size tool
SZT := arm-none-eabi-size

#clang tooling
CLANG_FORMAT := clang-format-9

#debugging flags
ifeq ($(DEBUG), 1)
    COMMON_FLAGS := -g -gdwarf-2
    LDFLAGS := -g -gdwarf-2
    OPT := -Og
else
    COMMON_FLAGS :=
    LDFLAGS :=
    OPT := -O2
endif

CPU := cortex-m4
FPU := fpv4-sp-d16
FLOAT-ABI = hard

#common compiler flags (c/c++)
COMMON_FLAGS += \
-mcpu=$(CPU) \
-mthumb \
-mfpu=$(FPU) \
-mfloat-abi=$(FLOAT-ABI) \
-Wall \
-fdata-sections \
-ffunction-sections \
-fmessage-length=0

C_FLAGS := \
-std=c11

CPP_FLAGS := \
-std=c++11 \
-fno-rtti \
-fno-exceptions \
-fpermissive

#linker flags
LDFLAGS := -T "$(LINKER_SCRIPT)"

LDFLAGS += \
-mcpu=$(CPU) \
-mthumb \
-mfpu=$(FPU) \
-mfloat-abi=$(FLOAT-ABI) \
-specs=nano.specs \
-specs=nosys.specs \
-Wl,--gc-sections \
-Wl,-Map="$(TARGET).map",--cref

.DEFAULT_GOAL := $(TARGET).elf

#default serial port for black magic probe
PORT := ttyACM0

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(@D)
	@$(C_COMPILER) $(COMMON_FLAGS) $(C_FLAGS) $(addprefix -D,$(DEFINES)) $(OPT) $(INCLUDE_FILES) $(INCLUDE_DIRS) -MD -MP -MF "$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -c "$<" -o "$@"
	@echo Finished building: $<

$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	@$(CPP_COMPILER) $(COMMON_FLAGS) $(CPP_FLAGS) $(addprefix -D,$(DEFINES)) $(OPT) $(INCLUDE_FILES) $(INCLUDE_DIRS) -MD -MP -MF "$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -c "$<" -o "$@"
	@echo Finished building: $<

$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(@D)
	@$(ASM_COMPILER) $(COMMON_FLAGS) $(C_FLAGS) $(addprefix -D,$(DEFINES)) $(OPT) $(INCLUDE_DIRS) -MD -MP -MF "$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -c "$<" -o "$@"
	@echo Finished building: $<

format:
	@echo Checking code formatting...
	@find . -regex '.*\.\(cpp\|hpp\|h\|cc\|cxx\)' \
	-exec $(CLANG_FORMAT) -i {} \;

$(TARGET).elf: $(OBJECTS)
	@echo Building...
	@#link
	@$(CPP_COMPILER) $(LDFLAGS) -o $(TARGET).elf $(OBJECTS)
	@echo Finished building target: $@
	@arm-none-eabi-objcopy -O ihex $(TARGET).elf $(TARGET).hex
	@arm-none-eabi-objcopy -O binary $(TARGET).elf $(TARGET).bin
	@$(SZT) "$(TARGET).elf"

flash:
	arm-none-eabi-gdb -nx --batch \
	-ex 'target extended-remote /dev/$(PORT)' \
	-ex 'monitor swdp_scan' \
	-ex 'attach 1' \
	-ex 'load' \
	-ex 'compare-sections' \
	-ex 'kill' \
	$(TARGET).elf

clean:
	@echo Cleaning up.
	@rm -rf $(BUILD_DIR)/

#debugging
print-%:
	@echo '$*=$($*)'