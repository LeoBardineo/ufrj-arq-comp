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
move $s2,$zero                      # i = 0                      
for1:
    
		li		$t5, 0					# $t5 = contador para printar os números no array
		la		$t6, numbers			# $t6 = endereço de memória do array
		printarray:
			bge     $t5, $s1, endprintarray

			# Carrega em $t2 o valor em $t6 e avança o ponteiro de $t6
			lw      $t7, 0($t6)			# t7 = *t6;
			addi    $t6, $t6, 4			# t6 += 4;	avança o ponteiro para a próxima posição no array

			# Printa o $t7
			li      $v0, 1      		# carrega a syscall para printar int
			move    $a0, $t7			# a syscall printa o que está $a0, logo carregamos $t7 em $a0
			syscall

			# Printa um espaço " "
			li      $v0, 11				# carrega a syscall para printar um char
			li      $a0, 32				# espaço = 32 na tabela ASCII
			syscall

			# Incrementa o contador do loop de printar números
			addi    $t5, $t5, 1
			j      	printarray
		endprintarray:
		li		$v0, 4					# carrega a syscall para printar uma string, já que o \n não é um char
		la		$a0, nline
		syscall

    addi $s3, $s1, -1               # s3 = tam - 1
    slt $t0,$s2,$s3                 # t0 = (i < tam-1)
    beq $t0,$zero,exit1             # se t0 = 0, sai do for, se não continua
    add $s4,$s2,$zero               # idMenor = i
    sll $s4, $s4, 2                 # idMenor *= 4
    addi $s3,$s2,1                  # j = i + 1

    for2:
        slt $t0,$s3,$s1             # verifica se j<tam, ou s3 < s1, se sim t0 =1, se não t0=0 
        beq $t0,$zero,exit2         # verifica se t0=0
        if:
            # TODO: coloca os indices * 4
            sll $t8, $s3, 2         # t8 = j * 4
            add $t8, $t8, $s0       # t8 = array + j
            lw $t3, 0($t8)          # t3 = *(array + j)
            # sll $t9, $s4, 2       # t9 = idMenor * 4
            move $t9, $s4           # t9 = idMenor
            add $t9, $t9, $s0       # t9 = array + idMenor
            lw $t4, 0($t9)          # t4 = *(array + idMenor)
            slt $t1,$t3,$t4         # t1 = (t3 < t4)
            beq $t1,$zero,if1end    # if (t1 == 0) goto if1end
            move $s4, $s3           # idMenor = j
            sll $s4, $s4, 2         # idMenor *= 4
        if1end:
        addi $s3,$s3,1              # s3 = s3 + 1
        j for2
    exit2:

    beq $s2,$s4, if2end             #verifica s2=s4 ; if(i == idMenor) goto if2end
    if2:    
        sll $s5, $s2, 2     # s5 = i * 4   pega o indice * 4
        add $s5, $s5, $s0   # s5 = s0 + i * 4   soma o indice * 4 ao endereço do array

        move $s7, $s4       # s7 = idMenor
        add $s7, $s7, $s0   # s7 = s0 + idMenor   soma o indice * 4 ao endereço do array
        
        # Faz o swap
        # sll     $t3, $s2, 2             # t3 = s2 * 4
        # add     $t3, $t3, $s0           # t3 = s0[s2]
        lw      $t7, 0($s5)             # t7 = *s5 | t7 = array[i]

        # move    $t3, $s4                # t3 = s4
        # add     $t3, $t3, $s0           # t3 = s0[s4]
        lw      $t1, 0($s7)             # t1 = *s7 | t1 = array[idMenor]

		sw		$t7, 0($s7)				# arrayteste[s4] = t5
		sw		$t1, 0($s5)				# arrayteste[s2] = t1    
    if2end:

    addi $s2, $s2, 1                  #s2=s2+1        ; i++
    j for1
exit1:
# Finaliza o programa
li		$v0, 10
syscall
