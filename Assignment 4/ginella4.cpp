#include <iostream>


using namespace std;

long long pow(int two, int power) {
    long long power_of_2 = 1;
    for (int i = 0; i < power; i++) {
        power_of_2 = power_of_2 * 2;
    }
    
    return power_of_2;
}

int main() {
    long long integer = 0;
    int power = 0;
    string input;
    cout << "Input Binary Sequence:" << std::endl;
    cout << "00000000000000000000000000000000" << std::endl;

    std::cin >> input;

    for (int i = 31; i != -1; i--) {
        if (input[i] == '1') {
            integer = integer + pow(2, power);
        }
        power++;
    }

    std::cout << integer << std::endl;
}