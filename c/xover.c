#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH     =  32768;

int main()
{
    for (unsigned length = 16; length <= LENGTH; length <<= 1)
    {
        struct timespec start, stop;
        char bits1[length], bits2[length];

        for (unsigned i = 0; i < length; i++ )
        {
            bits1[i] = rand() & 1;
            bits2[i] = rand() & 1;
        }

        clock_gettime(CLOCK_REALTIME, &start);

        for (unsigned i = 0; i < ITERATIONS; ++i)
            for (unsigned j = 0; j < length; ++j)
                if (rand() & 1)
                {
                    char tmp = bits1[j];
                    bits1[j] = bits2[j];
                    bits2[j] = tmp;
                }

        clock_gettime(CLOCK_REALTIME, &stop);

        printf("C-char[], %u, %f\n", length, (stop.tv_sec - start.tv_sec) + (stop.tv_nsec - start.tv_nsec) / 1e9);
    }

    return 0;
}
