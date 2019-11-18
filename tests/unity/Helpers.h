#pragma once

#include "comm/Comm.h"

#define TEST_START_STRING   "***Starting to run tests***"
#define TEST_START_END      "***Test run finished***"

#ifdef __STM32__
#define TESTS_START() do \
{ \
    consoleOutString(TEST_START_STRING); \
    UNITY_PRINT_EOL(); \
    UNITY_BEGIN(); \
} while(0)

#define TESTS_END() do \
{ \
    UNITY_END(); \
    consoleOutString(TEST_START_END); \
    consoleFlush(); \
} while(0)
#else
#define TESTS_START() do \
{ \
    printf(TEST_START_STRING); \
    printf("\n"); \
    UNITY_BEGIN(); \
} while(0)

#define TESTS_END() do \
{ \
    UNITY_END(); \
    printf(TEST_START_END); \
    printf("\n"); \
} while(0)

#endif

#define TEST_CASE(testName) \
void testName()
