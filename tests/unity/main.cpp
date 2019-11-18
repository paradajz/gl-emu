#include "unity/src/unity.h"
#include "unity/Helpers.h"

__attribute__((weak)) void setUp(void)
{
}

__attribute__((weak)) void tearDown(void)
{
}

#ifdef __STM32__
extern "C" void appMain(void)
#else
int main()
#endif
{
    TESTS_START();
    TESTS_EXECUTE();
    TESTS_END();
}