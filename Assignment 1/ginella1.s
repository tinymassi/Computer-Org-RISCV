# ginella1.s
# Massimo Ginella, massimoginella12@gmail.com
# Recieve flow of input, create sum, pick max input, if input is 0, end program.

.text
main:
    addi t0, zero, 0                 # input
    addi t1, zero, 0                 # sum
    addi t2, zero, 0                 # max

    din t0                           # std::cin >> input;
    add t1, t1, t0                   # sum += input;

    beq t0, zero, no_input           # if i == 0 skip loop and go to the 'No input' label
    addi t2, t0, 0                   # max = input;

    start_while_loop:
        din t0                       # std::cin >> input;
        beq t0, zero, end_while_loop # if input == 0 branch out of the while loop

        add t1, t1, t0               # sum += input;

        bge t2, t0, end_if           # if(max < input)
        addi t2, t0, 0               # max = input;
        end_if:

        beq zero, zero, start_while_loop  # while(input != 0)
    end_while_loop:

    # This code happens when user has input anything other than just '0'
    la a0, s_max                   
    sout a0                          # std::cout << "Max Value: ";
    dout t2                          # std::cout << max;
    la a0, s_newline
    sout a0                          # std::cout << std::endl;
    la a0, s_sum
    sout a0                          # std::cout << "Sum Value: ";
    dout t1                          # std::cout << sum;
    beq zero, zero, end              # Skip over the 'no input' label

    no_input:                      
    la a0, s_noinput
    sout a0                          # std::cout << "No Input.";

    end:

    halt                             # End the program


.data
s_max:      .asciz "Max Value: "
s_sum:      .asciz "Sum Value: "
s_noinput:  .asciz "No Input."
s_newline:	.asciz "\n"
