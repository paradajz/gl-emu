#ifndef UNITY_CONFIG_H
#define UNITY_CONFIG_H

#include "comm/Comm.h"

#define UNITY_EXCLUDE_FLOAT_H
#define UNITY_EXCLUDE_DOUBLE_H
#define UNITY_EXCLUDE_FLOAT_PRINT_H

#ifdef __STM32__
#define UNITY_OUTPUT_CHAR(a)        consoleOutSingleChar(a)
#define UNITY_PRINT_EOL() do \
{ \
    UNITY_OUTPUT_CHAR('\r'); \
    UNITY_OUTPUT_CHAR('\n'); \
} while(0)

#define UNITY_OUTPUT_FLUSH()
#define UNITY_OUTPUT_START()
#define UNITY_OUTPUT_COMPLETE()
#endif

#endif
