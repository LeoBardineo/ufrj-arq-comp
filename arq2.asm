.data
numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0
nline: .asciiz "\n"
.text

#array = $s0
#tam = $s1
#i = $s2
#j = $s3
#eleito = $s4

la $s0, numbers
la $s1, 10

insertionSort:
addi $sp,$sp,-4
sw $s0,0($sp)

move $s2, $zero
for1:
slt $t0,$s2,$s1
beq $t0,$zero, exit1

add $s2, $s2,$s0
lw $t3, 0($s2)

add $s4,$zero, $t3
addi $s3,$s2,-1
    slt $t1,$zero,$s3
    
    add $s3, $s3,$s0
    lw $t3, 0($s3)
    
    slt $t2,$s4,$t3
    bne $t1,$zero,exit2
    bne $t2,$zero,exit2
    while:
    add $s3, $s3,$s0
    lw $t3, 0($s3)
    lw $t4, 4($s3)
    move $t4,$t3
    addi $s3,$s3,-1
    exit2:
    move $t4, $s4
addi $s2,$s2,1
j for1
exit1:

lw $s0,0($sp)
addi $sp,$sp,4
jr $ra