#pragma once

#include <inttypes.h>

class Offset
{
    public:
    Offset(size_t offset)
        : _offset(offset)
    {}

    Offset()
        : _offset(0xABCDEF)
    {}

    const size_t offset()
    {
        return _offset;
    }

    size_t address(size_t start)
    {
        return start + _offset;
    }

    private:
    const size_t _offset;
};