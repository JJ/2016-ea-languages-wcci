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
      char bits[length+1];
      unsigned i;
      for ( i = 0; i < length; i++ ) {
	bits[i] =  (rand()%2 == 0)?'0':'1';
      }
      bits[length]=0;
	  
      clock_gettime(CLOCK_REALTIME, &start);
      
      for (unsigned i = 0; i < ITERATIONS; ++i) {
	int point_of_mutation = rand() % length;
	bits[point_of_mutation] = (bits[point_of_mutation] == '0')?'1':'0';
      }
      
      clock_gettime(CLOCK_REALTIME, &stop);
      
      printf("C-char[], %u, %f\n", length, (stop.tv_sec - start.tv_sec) + (stop.tv_nsec - start.tv_nsec)/1e9);
    }
    
    return 1; // avoid code elision
}
