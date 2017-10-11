.data
# Messages to be displayed to the user

Message: .asciiz  "Please enter a number: "
number1: .word 0

outOfBound_message01: .asciiz "$t0 = "
outOfBound_message02: .asciiz " is a number smaller than 2! Please insert a number greater or equal to 2.\n"

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
	
	blt	$t0,2,_SmallNumber	#Jump to _SmallNumber in case the number is less than 2

_SmallNumber:

	# Show the msg that $t0 is NOT 2-digit and goto _Start
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