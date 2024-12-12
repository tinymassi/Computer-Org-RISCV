# ginella4.s
# Massimo Ginella, massimoginella12@gmail.com
# Recieves a 32 bit binary sequence as an input string and compares it to 32 different binary patterns. If there are less than 8 
# differences, it will print the index of the first matching pattern. If there are no matches, it will print 'error'.

.text
main:

    la a0, s_greeting1              # std::cout << "CS24: Pattern Matching Program" << std::endl;
    sout a0

    la a0, s_newline                # std::cout << std::endl
    sout a0

    la a0, s_greeting2              # std::cout << "Enter Your Pattern";
    sout a0

    la a0, s_newline                # std::cout << std::endl
    sout a0

    la a0, s_greeting3              # std::cout << "01234567890123456789012345678901" << std::endl;
    sout a0

    la a0, s_newline                # std::cout << std::endl
    sout a0


    la a0, buffer                   # a0 points to first index of 40 byte array in memory
    sin a0                          # std::cin >> binary_input;


    jal ra, string_to_integer       # call function string_to_integer() to convert input string to an integer


    jal ra, check_match             # call function check_match to check if the input integer matches any patterns


    addi t0, zero, -1               # can i use the t0 register here to set it to -1???
    
    beq a0, t0, error               # if a0 = t0 then a0 = -1 so there was no match so print 'error'

    dout a0                         # otherwise, a0 holds the index of a matching pattern to output it             
    halt                            # end program here

    error:
    la a0, s_error                  # std::cout << "error" << std::endl;
    sout a0

    halt                            # end program here




# FUNCTION THAT CONVERTS THE INPUT STRING INTO ITS INTEGER VALUE
# arguments: None, void function
# return: a0 -> stores the integer that was represented by the binary input string
string_to_integer:
    addi t0, zero, 0                # t0 -> register for storing integer value of binary string
    addi t1, zero, 0                # t1 -> register for storing the index 'i' of the loop
    addi t2, zero, 32               # t2 -> register for storing the stopping point of the loop
    addi t3, zero, 0                # t3 -> register for storing the byte value stored at the strings index
    la t4, buffer                   # t4 -> points to the first index of the string in memory

    start_loop1:
        beq t1, t2, end_loop1       # if t1 == 32, exit the loop

        lb t3, 0(t4)                # load one character from the stirng at a time into t3
        addi t4, t4, 1              # a0 = a0 + 1 byte (moving through the string character character in memory)
        addi t3, t3, -48            # t4 = integer representation of '0' -> 0 or '1' -> 1

        slli t0, t0, 1              # Shift binary sequence in t0 by 1 to the left to free up space for incoming 1 or 0 in binary
        or t0, t0, t3               # OR t0 and t4 to copy over the 1 or 0 stored in t4 over to t0 essentially copying the bit sequence

        addi t1, t1, 1              # t1++;
        beq zero, zero, start_loop1
    end_loop1:

    add a0, zero, t0                # store the final integer value into a0 to return back to main

    jr ra




# FUNCTION THAT FINDS THE INDEX OF THE FIRST MATCH OR RETURNS -1 IF NO MATCH IS FOUND
# arguments: a0 -> input integer
# return: a0 -> stores index of the first matching pattern
check_match:
    addi sp, sp, -16                # free up 16 bytes of space on stack (2 words of storage)
    sw ra, 0(sp)                    # preserve the return address for this non-leaf function
    sw a0, 4(sp)                    # preserve the value in a0 (input integer)
    sw s0, 8(sp)                    # preserve the value in s0 for main
    sw s1, 12(sp)                   # preserve the value in s1 for main

    la s0, patterns                 # s0 -> memory address points to the first index of all the patterns
    addi s1, zero, 0                # s1 -> used to index through loop 32 times to traverse patterns label
    
    addi t0, zero, 0                # t0 -> temporarily holds number of differences inside loop (OK TO GET CLOBBERED DURING FUNCTION CALL)
    addi t1, zero, 0                # t1 -> temporarily holds comparison value for match or no match inside loop (OK TO GET CLOBBERED DURING FUNCTION CALL)
    addi t2, zero, 0                # t2 -> temporarily holds stopping point value (32) for the loop (OK TO GET CLOBBERED DURING FUNCTION CALL)

    start_loop2:
        addi t2, zero, 32           # temporarily set t2 equal to 32 for branch instruction on the next line
        beq t2, s1, end_loop2       # if s1 == t2 (32), stop the loop

        lw a1, 0(s0)                # store the pattern in a1
        addi s0, s0, 4              # move 4bytes (32 bits) to the next index of patterns

        jal ra, check_similar       # send a0 (input integer) and a1 (pattern for comparison) to check_similar function

        add t0, zero, a0            # t0 = temporarily holds number of differences
        addi t1, zero, 8            # t1 = 8 for comparison

        lw a0, 4(sp)                # restore a0 to contain the input integer. This MUST happen here so that I can continually use the input integer in the next leaf function call.
    
        blt t0, t1, match1          # if t0 < 8 (if num of differences is less than 8), we have a match!

        addi s1, s1, 1              # s1++
        beq zero, zero, start_loop2
    end_loop2:

    addi a0, zero, -1               # this code happens only if there was no match so a0 will be set to -1
    lw ra, 0(sp)                    # restore the return address for this function back into ra register
    lw s0, 8(sp)                    # restore s0 to contain its original value before anything is done to it
    lw s1, 12(sp)                   # restore s1 to contain its original value before anything is done to it
    addi sp, sp, 16                 # collapse the stack
    jr ra

    match1:
    add a0, zero, s1                # a0 = s1 (loop index & therefore index of matching pattern)
    lw ra, 0(sp)                    # restore the return address for this function back into ra register
    lw s0, 8(sp)                    # restore s0 to contain its original value before anything is done to it
    lw s1, 12(sp)                   # restore s1 to contain its original value before anything is done to it
    addi sp, sp, 16                 # collapse the stack
    jr ra




# FUNCTION THAT KEEPS TRACK OF THE NUMBER OF DIFFERENCES BETWEEN BINARY SEQUENCE OF A PATTERN AND OF THE INPUT INTEGER
# arguments: a0 -> input integer, a1 -> pattern for comparison
# return: a0 -> number of differences between the two
check_similar:
    xor t0, a0, a1                  # t0 -> by XOR'ing a0 & a1, the differing bits get turned to 1's and matching get turned to 0's. This sequence is stored in t0
    addi t1, zero, 0                # t1 -> register for storing the index 'i' of the loop
    addi t2, zero, 32               # t2 -> register for storing the stopping point of the loop
    addi t3, zero, 1                # t3 -> a bitmask containing binary sequence 0000 -> 00001
    addi t4, zero, 0                # t4 -> will be the result of the bitmask holding either a 0 or 1
    addi t5, zero, 0                # t5 -> used to store the number of differences

    start_loop3:
        beq t2, t1, end_loop3

        and t4, t0, t3              # t4 will equal 1 if it picks up a difference, and 0 if it picks up a match
        srli t0, t0, 1              # shift the binary sequence to the right to see if the LSB is a 1 or 0
        beq t4, zero, match2        # if t4 holds 0, then there was no difference found

        addi t5, t5, 1              # t5++ -> otherwise, if t4 holds 1, we found a difference and can add one to the difference counter

        match2:
        addi t1, t1, 1              # t1++
        beq zero, zero, start_loop3
    end_loop3:

    add a0, zero, t5                # a0 = t5 -> set return register equal to number of differences between binary sequences
    jr ra




data:
s_greeting1:  .asciz "CS24: Pattern Matching Program"
s_greeting2:  .asciz "Enter Your Pattern"
s_greeting3:  .asciz "01234567890123456789012345678901"
s_newline:    .asciz "\n"
s_error:      .asciz "error"
buffer:       .zero 40
patterns:     .word 0
              .word 1431655765
              .word 858993459
              .word 1717986918
              .word 252645135
              .word 1515870810
              .word 1010580540
              .word 1768515945
              .word 16711935
              .word 1437226410
              .word 869020620
              .word 1721329305
              .word 267390960
              .word 1520786085
              .word 1019428035
              .word 1771465110
              .word 65535
              .word 1431677610
              .word 859032780
              .word 1718000025
              .word 252702960
              .word 1515890085
              .word 1010615235
              .word 1769576086
              .word 16776960
              .word 1437248085
              .word 869059635
              .word 1721342310
              .word 267448335
              .word 1520805210
              .word 1019462460
              .word 1771476585

