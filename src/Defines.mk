DEFINES := \
USE_HAL_DRIVER \
STM32F407xx \
__STM32__ \
UNITY_INCLUDE_CONFIG_H

ifeq ($(DEBUG), 1)
    DEFINES += DEBUG
endif