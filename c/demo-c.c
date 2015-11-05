#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH     =  32768;

int main()
{
    char bits[LENGTH];

    for (unsigned length = 16; length <= LENGTH; length <<= 1)
    {
        struct timespec start, stop;

        clock_gettime(CLOCK_REALTIME, &start);

        for (unsigned i = 0; i < ITERATIONS; ++i)
            bits[rand() & (length - 1)] ^= 1;

        clock_gettime(CLOCK_REALTIME, &stop);

        printf("char[], %u, %llu\n", length, (stop.tv_sec - start.tv_sec) * 1000000000ull + (stop.tv_nsec - start.tv_nsec));
    }

    return bits[0]; // avoid code elision
}
