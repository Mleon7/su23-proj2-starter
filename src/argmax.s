.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
# i -> s0, array[i] -> t0, index -> s1, max -> s2
# int max = array[0];
# int index = 0;
# for (int i = 1; i != n; i++) {
#   if (array[i] > max) {
#       index = i;
#       max = array[i];
#   }
# }

argmax:
    addi t0, x0, 1
    blt a1, t0, quit
    # Prologue
    # s0, s1, s2
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    lw s2, 0(a0)
    li s1, 0
    li s0, 1

loop_start:
    beq s0, a1, loop_end

    addi a0, a0, 4
    lw t0, 0(a0)

    bge s2, t0, loop_continue
    add s1, x0, s0 # s1 = i
    lw s2, 0(a0)

loop_continue:

    addi s0, s0, 1
    j loop_start

loop_end:
    # Epilogue
    add a0, x0, s1 # a0 = s1

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12

    jr ra

quit:
    li a0 36
    j exit