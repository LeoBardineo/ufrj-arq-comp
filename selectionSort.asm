.data

numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0
nline: .asciiz "\n"
.text

#array = $s0
#tam = $s1
#i = $s2
#j = $s3
#idMenor = $s4

la $s0, numbers 
la $s1, 10

selectionSort:
addi $sp,$sp,-4
sw $s0,0($sp)
move $s2,$zero                      
for1:
    slt $t0,$s2,$s1                 #verifica se i<tam ou s2<s1
    beq $t0,$zero,exit1             #se t0 = 0, sai do for, se não continua
    add $s4,$s2,$zero
    addi $s3,$s2,1
    for2:
        slt $t0,$s3,$s1             #verifica se j<tam, ou s3 < s1, se sim t0 =1, se não t0=0 
        beq $t0,$zero,exit2         #verifica se t0=0
        if:
            add $s3, $s3,$s0        #s3 = s3 + s0
            lw $t3, 0($s3)
            add $s4, $s4,$s0        #s4 = s4 + s0
            lw $t4, 0($s4)          
            slt $t1,$t3,$t4         #t1 <- t3<t4
            beq $t1,$zero,if1end    #verifica t1=0
            move $s4,$s3            
        if1end:
        addi $s3,$s3,1              #s3=s3+1
        j for2
    exit2
    addi $s2,$s2,1                  #s2=s2+1
    beq $s2,$s4, if2end             #verifica s2=s2
    if2:
        #add $s2, $s2,$s0            #s2=s2+s0
        #lw $t5, 0($s2)
        #add $s4, $s4,$s0            #s4=s4+s0
        #lw $t4, 0($s4)      
        sll $s5, $s2, 2     # s5 = s2 * 4   pega o indice * 4
        add $s5, $s5, $s0   # s5 = s5[s2]   soma o indice * 4 ao endereço do array
        addi $s6, $s5, 4    # s6 = s5++     coloca o endereço da proxima posição em s6
        sll $s7, $s4, 2     # s7 = s4 * 4   pega o indice * 4
        add $s7, $s7, $s0   # s7 = s7[s4]   soma o indice * 4 ao endereço do array
        addi $t3, $s7, 4    # s5 = s7++     coloca o endereço da proxima posição em s6
    
        add $t4,$zero,$s5           #t4<-s5
        add $s5,$zero, $s7          #s5<-s7
        add $s7,$zero, $t4          #s7<-t4

    
    if2end:
    j for1
exit1:
lw $s0,0($sp)
addi $sp,$sp,4                      #sp=sp+4
jr $ra