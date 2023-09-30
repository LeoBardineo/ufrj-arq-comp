.data

numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0

.text

la $s2, numbers
la $a1, 10
# array[] = $a0
# tam = $a1
# i = $s0
# j = $s1

bubblesort:
addi $sp, $sp, -4
sw $s0, 0($sp)	
move $s0, $zero	# i = 0
move $s1, $zero # j = 0
for1tst:
addi $t0, $a1, -1
slt $t1, $s0, $t0
beq $t1, $zero, exit1
	for2tst:
	addi $t1, $s0, 1
	sub $t1, $a1, $t1
	
	slt $t2, $s1, $t1
	beq $t2, $zero, exit2
		# {
		li $v0, 1     	
		lw $t5, 0($s2)
		move $a0, $t5  	
		syscall       

		li $a0, 32					#print space
		li $v0, 11
		syscall	
		
		li $v0, 1     	
		lw $t5, 4($s2)
		move $a0, $t5  	
		syscall

		li $a0, 32					#print space
		li $v0, 11
		syscall
		li $a0, 32					#print space
		li $v0, 11
		syscall
		li $a0, 32					#print space
		li $v0, 11
		syscall
		li $a0, 32					#print space
		li $v0, 11
		syscall

		sll $t3, $s1, 2				# t3 = j * 4
		sll $t4, $s1, 3				# t4 = j * 8
		add $t3, $t3, $s2			# t3 = array[j]
		add $t4, $t4, $s2			# t4 = array[j + 1]

		slt $t0, $t4, $t3  			# t0 = arr[j] > arr[j+1]
		beq $t0, $zero, elseif		# if(!t0)
		
		move $t1, $t3				# t1 = arr[j]
		move $t4, $t3				# arr[j+1] = arr[j]
		move $t3, $t1				# arr[j] = t1

		li $v0, 1     		#prepare system call 
		lw $t5, 0($s2)
		move $s2, $t5  	#copy t0 to a0 
		syscall       		#print integer 

		elseif:
		# }
	addi $s1, $s1, 1
	j for2tst
	exit2:

addi $s0, $s0, 1
j for1tst
exit1:

lw $s0,0($sp)
addi $sp, $sp,4
jr $ra

void bubbleSort(int array[], int tam){
    int temp;
    int trocado = 0;
    for (int i = 0; i < tam - 1; i++){
        for (int j = 0; j < tam - i - 1; j++){
            if(array[j] > array[j + 1]){
                swap(&array[j], &array[j + 1]);
                trocado = 1;
            }
        }

        if(!trocado){
            break;
        }
    }
}

if(array[j] > array[j + 1]){
	swap(&array[j], &array[j + 1]);
}


    lw $t2, 40($s2)			# t2

	lw $t0, 32($s3)			# t0 = A[32/4]
	add $s1, $s2, $t0		# s1 = s2 + t0

	# a = b + c
	# A[a] = h + A[8];

	add $s3, $s4, $s5	# a = b + c
	lw $t0, 32($s3)		# t0 = A[8]
	add $t0, $s2, $t0	# t0 = h + A[8]
	add $t1, $s0, $s0	# t1 = a + a
	add $t1, $t1, $t1	# t1 = t1 + t1 	-> t1 = a * 4
	add $t1, $t1, $s3	# t1 = t1 + A 	-> t1 = a * 4(A) 	-> t1 = A[a]
	sw $t0, 0($t1)		# A[a] = t0

swap:
sll $t1, $a1, 2			# t1 = k * 4
add $t1, $a0, $t1		# t1 = v[k]
lw $t0, 0($t1)			# t0 = v[k]
lw $t2, 4($t1)			# t2 = v[k + 1]
sw $t2, 0($t1)			# v[k] = t2
sw $t0, 4($t1)			# v[k + 1] = t0
jr $ra					# preserva (?)