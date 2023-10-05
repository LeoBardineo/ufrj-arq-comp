.data

arrayteste: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0
nline: .asciiz "\n"

.text

# $s0 = arrayteste / array[]
# $s1 = tamanho do array
# $s2 = contador do for1 / i
# $s3 = contador do for2 / j
# $s4 = eleito

la      $s0, arrayteste
la      $s1, 10

insertionSort:
li      $s2, 1              # i = 0
for1:
li      $t0, 0				# $t0 = contador para printar os números no array
la      $t1, arrayteste		# $t1 = endereço de memória do array
printarray:
    bge     $t0, $s1, endprintarray

    # Carrega em $t2 o valor em $t1 e avança o ponteiro de $t1
    lw      $t2, 0($t1)		# t2 = *t1;
    addi    $t1, $t1, 4		# t1 += 4;	avança o ponteiro para a próxima posição no array

    # Printa o $t2
    li      $v0, 1      	# carrega a syscall para printar int
    move    $a0, $t2		# a syscall printa o que está $a0, logo carregamos $t2 em $a0
    syscall

    # Printa um espaço " "
    li      $v0, 11			# carrega a syscall para printar um char
    li      $a0, 32			# espaço = 32 na tabela ASCII
    syscall

    # Incrementa o contador do loop de printar números
    addi    $t0, $t0, 1
    j       printarray
endprintarray:
li      $v0, 4					# carrega a syscall para printar uma string, já que o \n não é um char
la      $a0, nline
syscall

slt     $t0, $s2, $s1           #                   ; t0 = s2 < s1
beq     $t0, $zero, endfor1     # for(i < tam)      ; if(!t0) goto endfor1
    sll     $s5, $s2, 2         #                   ; s5 = s2 * 4
    add     $s5, $s5, $s0       #                   ; s5 = s5 + array (endereço na posição s2)
    lw      $t3, 0($s5)         #                   ; *t3 = *s5 (array[i])

    add     $s4, $zero, $t3     # eleito = array[i] ; s4 = t3
    addi    $s3, $s2, -1        # j = i - 1         ; s3 = s2 - 1
    slt     $t1, $zero, $s3     #                   ; t1 = 0 < s3
    
    while:
    sll     $s5, $s3, 2         #                   ; s5 = s3 * 4
    add     $s5, $s5, $s0       #                   ; s5 = s5 + array (endereço na posição s3)
    lw      $t3, 0($s5)         #                   ; *t3 = *s5 (array[j])
    
    slt     $t1,$s3,$zero       #                           ; t1 = s3 < 0
    slt     $t2,$s4,$t3         #                           ; t2 = s4 < t3
    bne     $t1,$zero,endwhile1 # while(j >= 0)             ; if (s3 < 0) goto endwhile1
    bne     $t2,$zero,endwhile1 # while(eleito < array[j])  ; verifica eleito < array[j]
        sll     $s5, $s3, 2     #                           ; s5 = s3 * 4   pega o indice * 4
        add     $s5, $s5, $s0   #                           ; s5 = s0[s3]   soma o indice * 4 ao endereço do array
        lw      $s7, 0($s5)     #                           ; s7 = *s5
        addi    $s6, $s5, 4     #                           ; s6 = s5++     coloca o endereço da proxima posição em s6
        sw      $s7, 0($s6)     # array[j+1] = array[j]     ; *s6 = s7      
        addi    $s3,$s3,-1      # j -= 1                    ; s3 -= 1
    j while
    endwhile1:
    sll     $s6, $s3, 2         #                       ; s6 = s3 * 4   pega o indice * 4
    addi    $s6, $s6, 4         #                       ; s6 += 4
    add     $s6, $s6, $s0       #                       ; s6 = s6[s3]   soma o indice * 4 ao endereço do array
    sw      $s4, 0($s6)         # array[j + 1] = eleito ; *s6 = s4;
addi    $s2,$s2,1               # i += 1                ; s2 += 1
j       for1
endfor1:
# Finaliza o programa
li      $v0, 10
syscall