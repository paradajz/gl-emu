#include "unity/src/unity.h"
#include "unity/Helpers.h"
#include "demo/Demo.h"

namespace
{
    Offset offset;
}

TEST_CASE(demoTest)
{
    TEST_ASSERT(offset.address(0) == offset.offset());
}

TEST_CASE(demoTest2)
{
    TEST_ASSERT(offset.address(0xfedcbaabcdef) == offset.offset() + 0xfedcbaabcdef);
}