#include <iostream>

int test_prime(int n) {                                                // n = number that we want to check is prime or not
    int no_remainder = 0;                                              // Variable to keep track of how many numbers divide perfectly into n
    int k = 1;                                                         // Variable to see if any number leading up to n divide perfectly into it
    
    while(k != n+1) {                                                    // As we count up to n...
        if (n % k == 0) {                                              // Check if the number leading up to n divides perfectly into it
            no_remainder++;                                            // Increase no_remainder if so
        }
        k++;                                                           // Move to the next number
    }

    if (no_remainder == 2) {                                           // If there is two times when no_remainder is ticked, that means only 1 and n itself divide perfectly into n, therefore maing it prime
        return 1;                                                      // Return true...
    }

    return 0;                                                          // Else, return false bc more than 1 and n divide perfectly into n making it non-prime...
}

int main() {
    int n = 0;                                                         // Number of prime numbers
    int i = 0;                                                         // Index                                          // Boolean value to check if something is prime or not
    int possible_prime_number = 2;                                     // Variable to hold a number that we will test to be prime or not
 
    std::cout << "How many primes?" << std::endl;                      // Prompt user
    std::cin >> n;                                                     // User enters number of prime numbers they want
                                                  
    while (i != n) {                                                   // Keep looping until we have moved through the whole range n
        if (test_prime(possible_prime_number) == 1) {                  // If possible_prime_number is a prime number... 
            std::cout << possible_prime_number << std::endl;           // Output said prime number
            i++;                                                       // We found a prime, so increment i through range n
        }                               
        possible_prime_number++;                                       // Move to the next possible prime number
    }


    return 0;
}