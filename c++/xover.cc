#include <algorithm>
#include <chrono>
#include <tr2/dynamic_bitset>
#include <iostream>
#include <random>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH	 =  32768;

char r = 0; // avoid code elision

int main()
{
	std::minstd_rand engine;

	for (unsigned length = 16; length <= LENGTH; length <<= 1)
	{
		std::tr2::dynamic_bitset<> bits1(length), bits2(length);

		for (unsigned i = 0; i < length; ++i)
		{
			bits1[i] = engine() & 1;
			bits2[i] = engine() & 1;
		}

		auto start = std::chrono::high_resolution_clock::now();

		// two point crossover
		for (unsigned i = 0; i < ITERATIONS; ++i)
		{
			auto mm = std::minmax(engine() & (length - 1), 
			                      engine() & (length - 1));
			unsigned b = mm.first, 
					 e = mm.second;
			while (b != e)
			{
				bool tmp = bits1[b];
				bits1[b] = bits2[b];
				bits2[b] = tmp;
				++b;
			}

			r += bits1.count() + bits2.count(); // avoid code elision
		}

		auto stop = std::chrono::high_resolution_clock::now();

		std::chrono::duration<double> t = stop - start;
		std::cout << "std::tr2::dynamic_bitset, " << length << ", " << t.count() << std::endl;
	}
	
	return r; // avoid code elision
}
