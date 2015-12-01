#include <chrono>
#include <tr2/dynamic_bitset>
#include <iostream>
#include <random>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH     =  32768;

int main()
{
    std::mt19937 engine;

    for (unsigned length = 16; length <= LENGTH; length <<= 1)
    {
        std::tr2::dynamic_bitset<> bits1(length), bits2(length);

        for (unsigned i = 0; i < length; ++i)
        {
            bits1[i] = engine() & 1;
            bits2[i] = engine() & 1;
        }

        auto start = std::chrono::high_resolution_clock::now();

        for (unsigned i = 0; i < ITERATIONS; ++i)
            for (unsigned j = 0; j < length; ++j)
                if (engine() & 1)
                {
                    auto tmp = bits1[j];
                    bits1[j] = bits2[j];
                    bits2[j] = tmp;
                }

        auto stop = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> t = stop - start;
        std::cout << "std::tr2::dynamic_bitset, " << length << ", " << t.count() << std::endl;
    }
}
