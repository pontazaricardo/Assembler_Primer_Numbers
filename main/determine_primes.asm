.data
# Messages to be displayed to the user

Message: .asciiz  "Please enter a number (Enter 0 to exit): "
number1: .word 0

outOfBound_message01: .asciiz "$t0 = "
outOfBound_message02: .asciiz " is a number smaller than 2! Please insert a number greater or equal to 2.\n"

message_isPrime_01: .asciiz "$t0 = "
message_isPrime_02: .asciiz " IS a prime number!\n"

message_isNotPrime_01: .asciiz "$t0 = "
message_isNotPrime_02: .asciiz " is NOT a prime number!\n"

.text
_Main:

	# Ask to the user to enter the number to test
	la	$a0, Message
	li	$v0, 4
	syscall

	# Get the integer and store it in $t0
	li	$v0, 5
	syscall 
	sw	$v0, number1 		#Store the number in $v0
	lw	$t0, number1 		#Load the number in $t0

	# If the number is less than 2, tell the user to insert a number greater or equal to 2 and repeat
	
	beq	$t0,0,_Exit		#Branch to _Exit if number == 0.
	blt	$t0,2,_SmallNumber	#Jump to _SmallNumber in case the number is less than 2
	
	# Here we determine if the number is prime
	
	sub	$t7,$t0,1		#Set $t7=$t0-1 (number-1)
_While:
	beq	$t7,1,_IsPrime		#If we reach $t7==1, then $t0 is a prime.
	
	div	$t0,$t7			#We calculate mflo = $t0/$t7 and mfhi = $t0 % $t7.
	mfhi	$t6			#Save $t6=$t0 % $t7
	
	beq	$t6,0,_IsNotPrime	#If $t6==0, then we found a proper divisor greater than 1. We jump to _IsNotPrime.

	sub	$t7,$t7,1		#Set $t7 = $t7-1
		
	j	_While			#Continue the while cycle
	
_IsPrime:

	# Display that the number is a primer, and jump back to the start point of the main.
	la      $a0, message_isPrime_01
	li      $v0, 4
	syscall
	
	li $v0, 1
	add $a0, $t0 $zero
	syscall

	la      $a0, message_isPrime_02
	li      $v0, 4
	syscall

	j	_Main	

_IsNotPrime:	
	
	# Display that the number is NOT a primer, and jump back to the start point of the main.
	la      $a0, message_isNotPrime_01
	li      $v0, 4
	syscall

	li $v0, 1
	add $a0, $t0 $zero
	syscall

	la      $a0, message_isNotPrime_02
	li      $v0, 4
	syscall

	j	_Main	
	
_SmallNumber:

	# Display that the number is less than 2, and jump back to the start point of the main.
	la      $a0, outOfBound_message01
	li      $v0, 4
	syscall

	li $v0, 1
	add $a0, $t0 $zero
	syscall	    

	la      $a0, outOfBound_message02
	li      $v0, 4
	syscall

	# jump to _Main
	
	j	_Main

_Exit:
	li	$v0, 10
	syscall
