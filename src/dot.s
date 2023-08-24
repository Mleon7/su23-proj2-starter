.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================

# if a2 < 1 exit 36
# if a3 or a4 < 1 exit 37
# i -> s0, result -> s2
# result = 0;
# i = 0, j = 0;
# for (int t = 0; t < a2; t += 1) {
#   t0 = a0[i], i += a3;
#   t1 = a1[j], j += a4;
#   t2 = t0 * t1;
#   result += t2;
# }

dot:
    li t0, 1
    blt a2, t0, exit1
    blt a3, t0, exit2
    blt a4, t0, exit2

    # Prologue
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)

    # init
    li s0, 0
    li s1, 0
    li s2, 0
    slli s3, a3, 2
    slli s4, a4, 2

loop_start:
    bge s0, a2, loop_end

    lw t0, 0(a0)
    lw t1, 0(a1)
    mul t2, t0, t1
    add s2, s2, t2

    addi s0, s0, 1 # i = i + 1
    add a0, a0, s3
    add a1, a1, s4
    j loop_start


loop_end:
    add a0, x0, s2

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    addi sp, sp, 20

    jr ra

exit1:
    li a0, 36
    j exit
exit2:
    li a0, 37
    j exit
