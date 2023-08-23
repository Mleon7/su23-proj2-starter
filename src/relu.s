.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================

# i -> s0, array[i] -> t1
# for (int i = 0; i != n; i++) {
#   if (array[i] < 0) {
#       array[i] = 0; 
#   }
# }

relu:
    addi t0, x0, 1
    blt a1, t0, quit

    # Prologue
    addi sp, sp, -4
    sw s0, 0(sp)
    
    addi s0, x0, 0

loop_start:
    
    beq s0, a1, loop_end

    lw t1, 0(a0)
    bge t1, x0, loop_continue
    sw x0, 0(a0)


loop_continue:

    addi s0, s0, 1
    addi a0, a0, 4
    j loop_start

loop_end:

    # Epilogue
    lw s0, 0(sp)
    addi sp, sp, 4


    jr ra

quit:
    li a0 36
    j exit