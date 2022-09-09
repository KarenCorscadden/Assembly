# CS24, file:Corscadden1.s, Fall 2022, (c) Karen Corscadden
# Assignment 2, September 9, 2022
# inputs a series of integers, exit routine if 0 is entered
#		on exit routine, outputs sum of entered integers
#		  and maximum of entered integers
	
.globl main			

.text				
main:
  li $v0, 4			# print greeting
	la $a0, s_greet		
	syscall

  # these 2 lines get rid of the need for a special case for the first inputted value
  add $s0, $zero, $zero # initialize $s0 to zero so that when the first value is added to it it equals the first value
  li $s1, 0x80000000 # initialize $s1 to smallest possible 32 bit integer so that when the first value is compared
                    # to it, max will always end up less than or equal to the first value thus the first value will always
                    # get stored in max

loop:
  li $v0, 4			# print prompt
	la $a0, s_prompt		
	syscall		

	li $v0, 5			# read int (into $v0)
	syscall

	move $a0, $v0			# $a0 = $v0 (stdin integer)
	beq $a0, $zero, done		# jump to done if input is 0 (to start program exit routine)
	add $s0, $s0, $a0   # sum = sum + input
  blt $s1, $a0, new_max # jump to new_max if the stored maximum (in $s1) is less than the inputted value
	j loop				# next loop iteration

new_max:				# case where the stored maximum is less than the inputted value
	add $s1, $zero, $a0		# max = input
	j loop				# next loop iteration
			
# routine to call on exit that prints the 
# sum and maximum and then exits the program
done:
  li $v0, 4			# print sum introduction message
	la $a0, s_sum	
	syscall		

  li $v0, 1			# print sum value
	move $a0, $s0	
	syscall	

  li $v0, 4			# print new line
	la $a0, s_nl
	syscall	

  li $v0, 4			# print max introduction message
	la $a0, s_max
	syscall	

  li $v0, 1		# print max value
	move $a0, $s1
	syscall	

  li $v0, 4			# print new line
	la $a0, s_nl
	syscall	

	li $v0, 10			# exit
	syscall
	
.data				
s_greet:	.asciiz "Welcome to the sum/maximum program!\n" # "string" to print on program start
s_prompt:	.asciiz "Enter a number (0 to display sum and maximum and quit): "  # "string" to prompt user input
s_sum:		.asciiz "The sum is: "  # "string" to introduce sum value
s_max:		.asciiz "The maximum is: "  # "string" to introduce maximum value
s_nl:	  	.asciiz "\n"  # "string" to insert a newline
