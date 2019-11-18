#include "Comm.h"
#include "usbd_cdc_if.h"

#define OUT_BUFFER_SIZE 1024

namespace
{
    char     outBuffer[OUT_BUFFER_SIZE];
    uint32_t bufferCounter;

    bool isBufferFull()
    {
        return (bufferCounter >= OUT_BUFFER_SIZE);
    }
}    // namespace

void consoleOutString(const char* text)
{
    for (size_t i = 0; i < strlen(text); i++)
        consoleOutSingleChar(text[i]);
}

void consoleOutSingleChar(char singleChar)
{
    outBuffer[bufferCounter++] = singleChar;

    if (isBufferFull())
        consoleFlush();
}

void consoleFlush()
{
    if (bufferCounter)
    {
        if (CDC_Transmit_FS((uint8_t*)outBuffer, bufferCounter) == USBD_OK)
            bufferCounter = 0;
    }
}