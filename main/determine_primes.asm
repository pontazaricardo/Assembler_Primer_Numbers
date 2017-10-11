.data
# Messages to be displayed to the user

Message: .asciiz  "Please enter a number (Enter 0 to exit): "
number1: .word 0

outOfBound_message01: .asciiz "$t0 = "
outOfBound_message02: .asciiz " is a number smaller than 2! Please insert a number greater or equal to 2.\n"

messsage_isPrime_01: .asciiz "$t0 = "
messsage_isPrime_02: .asciiz " IS a prime number!\n"

messsage_isNotPrime_01: .asciiz "$t0 = "
messsage_isNotPrime_02: .asciiz " is NOT a prime number!\n"

.text
_Main:

	# Ask to the user to enter the number to test
	la	$a0, Message
	li	$v0, 4
	syscall

	# Get the integer and store it in $t0
	li	$v0, 5
	syscall 
	sw	$v0, number1 #Store the number in $v0
	lw	$t0, number1 #Load the number in $t0

	# If the number is less than 2, tell the user to insert a number greater or equal to 2 and repeat
	
	beq	$t0,0,_Exit		#Branch to _Exit if number == 0.
	blt	$t0,2,_SmallNumber	#Jump to _SmallNumber in case the number is less than 2
	
	
	j _Main	
	
_IsPrime:

	# Display that the number is a primer, and jump back to the start point of the main.
	la      $a0, message_isPrime_01
	li      $v0, 4
	syscall

	j _Main	
	
_IsNotPrime:	

	j _Main	
	
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
	
	j _Main

_Exit:
	li	$v0, 10
	syscall