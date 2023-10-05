.data

arrayteste: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0
nline: .asciiz "\n"

.text

# $s3 = arrayteste / array[]
# $s4 = tamanho do array
# $s0 = contador do for1 / i
# $s1 = contador do for2 / j

la		$s3, arrayteste
la		$s4, 10

bubblesort:
move	$s0, $zero						# i = 0				; s0 = 0 
for1:
move	$s1, $zero 						# j = 0				; s1 = 0
addi	$t0, $s4, -1					# 					; t0 = s4 - 1
slt		$t1, $s0, $t0					# 					; t1 = s0 < t0
beq		$t1, $zero, endfor1				# for(i < tamanho)	; if (s0 == tamanho) goto endfor1
	for2:
	addi	$t1, $s0, 1					# 					; t1 = s0 + 1
	sub		$t1, $s4, $t1				# 					; t1 = s4 - t1
	slt		$t2, $s1, $t1				# 					; t2 = s1 < t1
	beq		$t2, $zero, endfor2			# for(j < tamanho)	; if (s1 == tamanho) goto endfor2

		li		$t0, 0					# $t0 = contador para printar os números no array
		la		$t1, arrayteste			# $t1 = endereço de memória do array
		printarray:
			bge     $t0, $s4, endprintarray

			# Carrega em $t2 o valor em $t1 e avança o ponteiro de $t1
			lw      $t2, 0($t1)			# t2 = *t1;
			addi    $t1, $t1, 4			# t1 += 4;	avança o ponteiro para a próxima posição no array

			# Printa o $t2
			li      $v0, 1      		# carrega a syscall para printar int
			move    $a0, $t2			# a syscall printa o que está $a0, logo carregamos $t2 em $a0
			syscall

			# Printa um espaço " "
			li      $v0, 11				# carrega a syscall para printar um char
			li      $a0, 32				# espaço = 32 na tabela ASCII
			syscall

			# Incrementa o contador do loop de printar números
			addi    $t0, $t0, 1
			j      	printarray
		endprintarray:
		li		$v0, 4					# carrega a syscall para printar uma string, já que o \n não é um char
		la		$a0, nline
		syscall

		# $t3 = endereço de memória do array na posição atual
		# $t6 = valor do array na posição atual
		# $t7 = valor do array na próxima posição
		sll		$t3, $s1, 2				# t3 = j * 4;
		add		$t3, $s3, $t3			# t3 = arrayteste + j * 4;
		lw		$t6, 0($t3)				# t6 = *t3 		| t6 = arrayteste[j]
		lw		$t7, 4($t3)				# t7 = *t3++ 	| t7 = arrayteste[j+1]

		slt		$t0, $t7, $t6  			# t0 = arrayteste[j+1] < arrayteste[j]
		beq		$t0, $zero, elseif		# if(t0) goto elseif
		
		# Faz o swap
		sw		$t7, 0($t3)				# arrayteste[j] = t7
		sw		$t6, 4($t3)				# arrayteste[j+1] = t6

		elseif:
		
	# Incrementa o contador do for 2
	addi		$s1, $s1, 1
	j			for2
	endfor2:

# Incrementa o contador do for 1
addi	$s0, $s0, 1
j		for1
endfor1:

# Finaliza o programa
li		$v0, 10
syscall