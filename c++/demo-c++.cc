#include <bitset>
#include <chrono>
#include <functional>
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
        auto start = std::chrono::high_resolution_clock::now();

        for (unsigned i = 0; i < ITERATIONS; ++i)
            bits[engine() & (length - 1)].flip();

        auto stop = std::chrono::high_resolution_clock::now();

        std::cout << "std::bitset, " << length << ", " << std::chrono::duration_cast<std::chrono::nanoseconds>(stop - start).count() << std::endl;
    }

    return bits[0]; // avoid code elision
}
