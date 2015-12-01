#include <chrono>
#include <tr2/dynamic_bitset>
#include <iostream>
#include <random>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH	 =  65536;

int main()
{
	std::mt19937 engine;

	for (unsigned length = 16; length <= LENGTH; length <<= 1)
	{
		std::tr2::dynamic_bitset<> bits(length);

		for (unsigned i = 0; i < length; ++i)
			bits[i] = engine() & 1;

		auto start = std::chrono::high_resolution_clock::now();

		for (unsigned i = 0; i < ITERATIONS; ++i)
			bits[engine() & (length - 1)].flip();

		auto stop = std::chrono::high_resolution_clock::now();

		std::chrono::duration<double> t = stop - start;
		std::cout << "std::tr2::dynamic_bitset<>, " << length << ", " << t.count() << std::endl;
	}
}
