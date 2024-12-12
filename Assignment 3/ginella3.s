# ginella3.s
# Massimo Ginella, massimoginella12@gmail.com
# Uses recursion and Euclids GCD algorithm to find the GCD of two positive integers.

.text
main:
    addi s0, zero, 0                  # int n = 0;
    addi s1, zero, 0                  # int m = 0;
    addi s2, zero, 0                  # int gcd = 0;

    la a0, s_greeting                 # Load "Euclids GCD Program" into register a0
    sout a0                           # std::cout << "Euclids GCD Program";

    la a0, s_newline                  # Load endl into a0
    sout a0                           # std::cout << std::endl;

    la a0, s_input1                   # Load "m ? " into register a0
    sout a0                           # std::cout << "m ? ";
    din s0                            # std::cin >> m;

    la a0, s_input2                   # Load "n ? " into register a0
    sout a0                           # std::cout << "n ? ";
    din s1                            # std::cin >> n;

    add a0, zero, s0                  # M = m;
    add a1, zero, s1                  # N = n;

    jal ra, GCD
    add s2, a0, zero                  # gcd = GCD(n, m)

    la a0, s_output                   # load output string into a0
    sout a0                           # std::cout << "gcd(m, n) = " << gcd;
    dout s2

    halt


# Arguments (a0, a1) -> (M, N)
# Return (a1)
GCD:
    beq a0, zero, return_m            # if (M == 0) 

    addi t0, zero, 0                  # set temp register to 0
    addi sp, sp, -4                   # make room on stack for previous return address
    sw ra, 0(sp)                      # store previous return address on stack
    add t0, zero, a0                  # save the value of N before it gets modified
    rem a0, a1, a0                    # M = N % M
    add a1, zero, t0                  # N = M
    jal ra, GCD                       # GCD(N % M, N)

    return_m:
    lw ra, 0(sp)                      # load the return address from the stack
    addi sp, sp, 4                    # collapse this part of the stack
    add a0, zero, a1                  # change the value in register a0 to the return value for correct convention
    jr ra                             # return N



data:
s_greeting:   .asciz "Euclid's Greatest Common Divisor Algorithm"
s_input1:     .asciz "m ? "
s_input2:     .asciz "n ? "
s_output:     .asciz "gcd(m, n) = "
s_newline:	  .asciz "\n"