#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH	 =  65536;

int main()
{
	unsigned result = 0;

	for (unsigned length = 16; length <= LENGTH; length <<= 1)
	{
		struct timespec start, stop;
		char bits[length];

		for (unsigned i = 0; i < length; i++ )
			bits[i] = rand() & 1;


		clock_gettime(CLOCK_REALTIME, &start);

		for (unsigned i = 0; i < ITERATIONS; ++i) 
			for (unsigned j = 0; j < length; ++j)
				result += bits[j];

		clock_gettime(CLOCK_REALTIME, &stop);

		printf("C-char[], %u, %ld\n", length, (stop.tv_sec - start.tv_sec) * 1000000000 + (stop.tv_nsec - start.tv_nsec));
	}

	return result;
}
