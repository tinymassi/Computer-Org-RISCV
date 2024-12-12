#include <iostream>

int GCD (int M, int N) {
    if (M == 0) {
       return N;
    }

    return GCD(N % M, M);
}

int main() {
    int integer_1{};
    int integer_2{};
    int greatest_common_divisor{};

    std::cout << "Euclids GCD Program" << std::endl;
    std::cout << "m ? ";
    std::cin >> integer_1;

    std::cout << "n ? ";
    std::cin >> integer_2;
    std::cout << std::endl;

    greatest_common_divisor = GCD(integer_1, integer_2);
    std::cout << "gcd(m, n) = " << greatest_common_divisor << std::endl;
}