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

	   

		clock_gettime(CLOCK_REALTIME, &start);

	for (unsigned i = 0; i < ITERATIONS; ++i) {
	  for (unsigned i = 0; i < length; i++ )
		bits[i] = rand() & 1;
	  for (unsigned j = 0; j < length; ++j)
		result += bits[j];
	}

		clock_gettime(CLOCK_REALTIME, &stop);

		printf("C-char[], %u, %f\n", length, (stop.tv_sec - start.tv_sec) + (stop.tv_nsec - start.tv_nsec) / 1e9);
	}

	return result;
}
