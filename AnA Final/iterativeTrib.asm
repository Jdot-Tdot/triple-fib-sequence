.data
# Same varible/start up as the others.
	prompt0:  .asciiz "Enter tribonacci(0): "
	prompt1:  .asciiz "Enter tribonacci(1): "
	prompt2:  .asciiz "Enter tribonacci(2): "
	promptN:  .asciiz "Enter n: "
	result0: .asciiz "tribonacci("
	result1: .asciiz ") = "
.text
### The Prompts \/
dataget0:
	li $v0, 4
	la $a0, prompt0
	#to actually print the prompt
	syscall
	
	#Get the int
	li $v0, 5
	syscall
	#store it actually
	# could have done addi, or add with $zero.
	move $s0,$v0
	
	#Branch if lower than zero.
	blt  $s0,$zero, dataget0

dataget1:
	li $v0, 4
	la $a0, prompt1
	#to actually print the prompt
	syscall
	
	#Get the int
	li $v0, 5
	syscall
	#store it actually
	move $s1,$v0
	
	#Branch if lower than zero.
	blt  $s1,$zero, dataget1

dataget2:
	li $v0, 4
	la $a0, prompt2
	#to actually print the prompt
	syscall
	
	#Get the int
	li $v0, 5
	syscall
	#store it actually
	move $s2,$v0
	
	#Branch if lower than zero.
	blt  $s2,$zero, dataget2

datagetN:
	li $v0, 4
	la $a0, promptN
	#to actually print the prompt
	syscall
	
	#Get the int
	li $v0, 5
	syscall
	#store it actually
	move $s3,$v0
	
	#Branch if lower than zero.
	blt  $s3,$zero, datagetN
## THE DATA VALIDATOIN AND GETTING /\

### The work \/
	add $s4, $zero $zero # these are the amount of iterations.
	addi $t3, $zero, 3 # need to have t3 be 3
	
# Remember the work we done in C. But how do we check if it divisible by three???
# So this is actually just doing the choosing logic.
loop:
	div $s4, $t3
	mfhi $t1
	
	# our end condition is met.
	bne $s4, $s3, movechoose
	beq $t1, 0, pickboxblack
	beq $t1, 1, pickboxgrey
	j pickboxwhite
	
	#end condition not met and we need to move the boxes
	movechoose:
		beq $t1, 0, moveboxblack
		beq $t1, 1, moveboxgrey
		j moveboxwhite
	
	#When we hit iterations = N AND pick which box to do
	pickboxblack:
		move $s5, $s0
		j end
	pickboxgrey:
		move $s5, $s1
		j end
	pickboxwhite:
		move $s5, $s2
		j end
	
	# When N is not the same as iterations.
	moveboxblack:
		add $t0, $s1, $s2
		add $s0, $s0, $t0
		addi $s4, $s4, 1
		j loop
	moveboxgrey:
		add $t0, $s0, $s2
		add $s1, $s1, $t0
		addi $s4, $s4, 1
		j loop
	moveboxwhite:
		add $t0, $s0, $s1
		add $s2, $s2, $t0
		addi $s4, $s4, 1
		j loop
### The work /\

### The output \/
end:
	# Print the start with the N
	li $v0, 4
	la $a0, result0
	syscall
	li $v0, 1 #print n
	add $a0, $s3, $zero
	syscall
	li $v0, 4 #print next bit
	la $a0, result1
	syscall
	li $v0, 1 #print output of loop.
	add $a0, $s5, $zero
	syscall
### The output /\