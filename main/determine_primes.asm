.data
# Messages to be displayed to the user

Message: .asciiz  "Please enter a number: "
number1:   .word   0

.text
_Main:

	# Ask to the user to enter the number to test
	la      $a0, Message
        li      $v0, 4
        syscall
