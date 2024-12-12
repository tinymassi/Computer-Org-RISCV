#include <iostream>

int main() {
    int input = 0;
    int max = 0;
    int sum = 0;
    int i = 0;
    int run_loop = 0;

    while (run_loop == 0) {
        std::cin >> input;
        sum += input;
        if (i == 0) {
            max = input;
        }
        
        if (max < input) {
            max = input;
        }

        if (input == 0) {
            run_loop++;
        }

        i++;
    }

    if (i > 1) {
        std::cout << "Max: " << max << std::endl;
        std::cout << "Sum: " << sum << std::endl;
    } else {
        std::cout << "no input" << std::endl;
    }

    return 0;
}