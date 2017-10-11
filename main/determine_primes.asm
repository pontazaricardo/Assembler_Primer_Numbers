.data
# Messages to be displayed to the user

Message: .asciiz  "Please enter a number: "
number1: .word 0

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
