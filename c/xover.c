#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

const unsigned ITERATIONS = 100000;
const unsigned LENGTH	 =  32768;

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

		// two point crossover
		for (unsigned i = 0; i < ITERATIONS; ++i)
		{
			unsigned t1 = rand() & (length - 1), 
			         t2 = rand() & (length - 1);
			unsigned b = MIN(t1, t2), 
					 e = MAX(t1, t2);
			while (b != e)
			{
				char tmp = bits1[b];
				bits1[b] = bits2[b];
				bits2[b] = tmp;
				++b;
			}
		}
		
		clock_gettime(CLOCK_REALTIME, &stop);

		printf("C-char[], %u, %f\n", length, (stop.tv_sec - start.tv_sec) + (stop.tv_nsec - start.tv_nsec) / 1e9);
	}

	return 0;
}
