#include <bitset>
#include <chrono>
#include <iostream>
#include <random>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH     =  32768;

int main()
{
    std::mt19937 engine;
    std::bitset<LENGTH> bits;

    for (unsigned length = 16; length <= LENGTH; length <<= 1)
    {
        for (unsigned i = 0; i < length; ++i)
            bits.set(i, engine() & 1);

        auto start = std::chrono::high_resolution_clock::now();

        for (unsigned i = 0; i < ITERATIONS; ++i)
            bits[engine() & (length - 1)].flip();

        auto stop = std::chrono::high_resolution_clock::now();

        std::chrono::duration<double> t = stop - start;
        std::cout << "std::bitset, " << length << ", " << t.count() << std::endl;
    }

    return bits[0]; // avoid code elision
}
