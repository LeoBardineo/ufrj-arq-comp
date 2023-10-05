.data

numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0
nline: .asciiz "\n"

.text

la $s3, numbers
la $s4, 10

# array[] = $a0
# tam = $s4
# i = $s0
# j = $s1

bubblesort:
move $s0, $zero	# i = 0
for1:
move $s1, $zero # j = 0
addi $t0, $s4, -1
slt $t1, $s0, $t0
beq $t1, $zero, endfor1	# if s0 == tamanho acabaFor
	for2:
	addi $t1, $s0, 1
	sub $t1, $s4, $t1
	
	slt $t2, $s1, $t1
	beq $t2, $zero, endfor2	# if s1 == tamanho acabaFor
		# {
		li      $t0, 0
		la      $t1, numbers
		printarray:
			bge     $t0, 10, endprintarray

			# load word from addrs and goes to the next addrs
			lw      $t2, 0($t1)		# t2 = *t1
			addi    $t1, $t1, 4		# t1 += 4;

			# syscall to print value
			li      $v0, 1      	# printar int, ele printa o $a0
			move    $a0, $t2
			syscall
			# optional - syscall number for printing character (space)
			li      $a0, 32
			li      $v0, 11  
			syscall

			#increment counter
			addi    $t0, $t0, 1
			j      printarray
		endprintarray:
		li $v0, 4					#print out \n
		la $a0, nline
		syscall

		sll $t3, $s1, 2				# t3 = j * 4
		add $t3, $s3, $t3
		lw $t6, 0($t3)
		lw $t7, 4($t3)

		slt $t0, $t6, $t7  			# t0 = arr[j] > arr[j+1]
		beq $t0, $zero, elseif		# if(!t0)
		# swap
		sw $t7, 0($t3)
		sw $t6, 4($t3)

		elseif:
		# }
	addi $s1, $s1, 1
	j for2
	endfor2:

addi $s0, $s0, 1
j for1
endfor1:

final:	
	li $v0, 10						# termina o programa
	syscall