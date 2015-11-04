#include <bitset>
#include <chrono>
#include <functional>
#include <iostream>
#include <random>

const unsigned ITERATIONS = 100000;
const unsigned LENGTH     =  32768;

int main()
{
    std::random_device rd;
    std::default_random_engine engine(rd());
    std::uniform_int_distribution<unsigned> distribution(0, LENGTH - 1);
    auto generator = std::bind(distribution, engine);

    for (unsigned length = 16; length <= LENGTH; length <<= 1)
    {
        std::bitset<LENGTH> bits;

        auto start = std::chrono::high_resolution_clock::now();

        for (unsigned i = 0; i < ITERATIONS; ++i)
            bits[generator()].flip();

        auto stop = std::chrono::high_resolution_clock::now();

        std::cout << "std::bitset, " << length << ", "
                  << std::chrono::duration_cast<std::chrono::nanoseconds>(stop - start).count() << std::endl;
    }
}
