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


## Call our function

move $a0, $s0 #Black Box
move $a1, $s1 #Grey Box
move $a2, $s2 #White Box
move $a3, $s3 #N

jal the_recursive
addi $s5, $v0, 0 #get our output.

j end

### The work \/
# We are going to make the black box into the white box but with the additions, we are going to have to do like 2 more calls to get to the right black box.
the_recursive:
	# we only need to save the $ra link
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#base case
	
	# easy bit
	bne $a3, $zero, rcase # not end of recursive function
	addi $v0, $a0, 0
	#hard bit getting back $ra
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	rcase: #recursive case
	
	#easy bit
	add $t0, $a0, $a1 # set up for add box shift
	add $a0, $a1, $zero #box shift
	add $a1, $a2, $zero #box shift
	add $a2, $a2, $t0 # the added box shift
	
	addi $a3, $a3, -1 # so we can get to the base case
	
	#hard bit, I don't believe we need to save the stack pointer right here, just load it afterwards.
	jal the_recursive
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


	
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
	
	# need to tell system it is done.
	li $v0, 10
	syscall
### The output /\