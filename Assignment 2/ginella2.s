# ginella2.s
# Massimo Ginella, massimoginella12@gmail.com
# Receives number value from user regarding how many prime numbers to display, then displays them line by line.


.text
main:
    addi s1, zero, 0                           # int n = 0
    addi s2, zero, 0                           # int i = 0
    addi s3, zero, 1                           # int temp = 1 (Just a register to hold '1')
    addi s4, zero, 2                           # int possible_prime_number = 2


    la a0, s_prompt                            # Load s_prompt address into a0 register
    sout a0                                    # std::cout << "How mant primes? (n >= 0);
    la a0, s_newline                           # Load s_newline address into a0
    sout a0                                    # std::cout << std::endl;
    din s1                                     # std::cin >> n;


    start_loop:
        beq s1, s2, end_loop                   # if i == n, end the loop
        addi a0, s4, 0                         # set argument register equal to possible_prime_number
        jal ra, test_prime                     # ra stores address of line in front of it (CALLER)
        
        bne a0, s3, equals_zero                # if (test_prime(possible_prime_number) == 1)
        dout s4                                # std::cout << possible_prime_number << std::endl;
        la a0, s_newline                       # Load s_newline address into a0
        sout a0                                # std::cout << std::endl;
        addi s2, s2, 1                         # i = i + 1 (i++)

        equals_zero:
        addi s4, s4, 1                         # possible_prime_number = possible_prime_number + 1 (possible_prime_number++)
        beq zero, zero, start_loop             # Keep loop going
    end_loop:


    halt                                       # END PROGRAM


# Arguments (a0 - a7)
# Return (a0)
test_prime:                                    # CALLEE (Must do operation, return result, and MUST NOT OVERWRITE any registers or memory caller was expecting to still have!)
    addi t0, zero, 0                           # int no_remainder = 0;
    addi t1, zero, 1                           # int k = 1;
    addi t2, a0, 1                             # temporary register to store n + 1...
    addi t3, zero, 0                           # temporary register to store n % k...
    

    start_func_loop:
        beq t1, t2, end_func_loop              # while(k != n+1)
        rem t3, a0, t1                         # t3 = n % k;

        bne t3, zero, yes_remainder            # if (n % k == 0)
        addi t0, t0, 1                         # no_remainder++;

        yes_remainder:
        addi t1, t1, 1                         # k++;
        beq zero, zero, start_func_loop        # Keep loop going
    end_func_loop:
    
    addi t3, zero, 2                           # t3 = 2

    bne t0, t3, not_prime                      # if (no_remainder == 2)
    addi a0, zero, 1                           # a0 = 1
    jr ra                                      # return 1

    not_prime:
    addi a0, zero, 0                           # a0 = 0
    jr ra                                      # return 0


.data
s_prompt:   .asciz "How many primes? (n >= 0)"
s_newline:	.asciz "\n"