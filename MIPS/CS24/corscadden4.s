# CS24 program that compares a user entered binary number
#   to a list of stored numbers and returns the index of
#   the pattern that is the closest match, or -1 if none
#   of the patterns are a close match. This program uses
#   two functions:
#     bits_difference returns the number of bits different
#       between two numbers
#     closest_index returns the index of the pattern that
#       is the closest match to a given number or -1 if
#       none of the patterns are close
# file:	corscadden4.s, Fall 2022, (c) Karen Corscadden

.globl main

.text
main:	
	addi $v0, $zero, 4	# 4 = print string
	la $a0, s_greeting		# greeting
	syscall

  addi $v0, $zero, 4	# 4 = print string
	la $a0, s_prompt1		# program prompt
	syscall

  li $v0, 8			# read string (into input) assumption will be 32 characters
  la $a0, input
  lw $a1, inputSize
	syscall

  li $v0, 4		# 4 = print string
	la $a0, newline
	syscall

  la $t0, input
  add $t1, $zero, $zero # initialize input array index to zero
  add $t2, $zero, $zero # initialize integer input value to zero

main_loop:
  sll $t2, $t2, 1 # shift int value left by 1 bit
  add $t3, $t0, $t1 # calculate the address of the next array value
  lb $t3, 0($t3)  # load array value into $t3
  addi $t3, $t3, -48 # convert ascii to int
  or $t2, $t2, $t3 # set the lowest bit
  addi $t1, $t1, 1  # increase array index
  addi $t3, $zero, 32 # load exit criteria into register
  blt $t1, $t3, main_loop  # exit loop after looped through entire array

  move $a0, $t2 # move inputted bit pattern into $a0 to pass to function
  jal closest_index

  move $t0, $v0 # save return value to register $s0

	li $v0, 4		# 4 = print string
	la $a0, s_output
	syscall

	li $v0, 1		# 1 = print int
  move $a0, $t0 # move the value to be printed to $a0
	syscall
	
	li $v0, 4		# 4 = print string
	la $a0, newline
	syscall

	li $v0, 10		# 10 = exit
	syscall

# ----------
# closest_index returns the index of the pattern that
#   is the closest match to a given number or -1 if
#   none of the patterns are close
closest_index:
  # create new stack frame
  addi $sp, $sp, -24  # adjust stack pointer
  sw $ra, 20($sp)  # push ra onto the stack
  sw $s0, 16($sp)  # push s0 onto the stack
  sw $s1, 12($sp)  # push s1 onto the stack
  sw $s2, 8($sp)  # push s2 onto the stack
  sw $s3, 4($sp)  # push s3 onto the stack
  sw $s4, 0($sp)  # push s4 onto the stack

  addi $s0, $zero, -1 # default return value
  addi $s1, $zero, 8 # initial value for bits difference
  add $s2, $zero, $zero # initial value for array "index"
  la $s3, array # load array address into $s3
  add $s4, $zero, $a0 # store input value in an s register

index_loop:
  move $a0, $s4 # move input value into $a0
  add $t0, $s2, $s3 # calculate the address of the next array value
  lw $a1, 0($t0)  # load array value into $a1
  jal bits_difference
  bge $v0, $s1, iloop_always  # if v0 is less than s1, update $s1 and $s0, else, continue
  add $s1, $zero, $v0 # update the smallest bits difference register
  srl $s0, $s2, 2 # calculate the index value, $s2 / 4, and update "return" value register
iloop_always:
  addi $s2, $s2, 4  # increase array index
  addi $t0, $zero, 125 # load exit criteria into register
  blt $s2, $t0, index_loop  # exit loop after looped through entire array
  
index_ret:
  move $v0, $s0 # move the index value to return register
  # tear down the stack frame
  lw $s4, 0($sp)  # restore s4 from stack
  lw $s3, 4($sp)  # restore s3 from stack
  lw $s2, 8($sp)  # restore s2 from stack
  lw $s1, 12($sp)  # restore s1 from stack
  lw $s0, 16($sp)  # restore s0 from stack
  lw $ra, 20($sp)  # restore ra from stack
  addi $sp, $sp, 24  # adjust stack pointer to take down the stack frame
  jr $ra  # return

# ----------
# bits_difference returns the number of bits different
#   between two numbers
bits_difference:
  xor $t3, $a0, $a1 # $t3 = $t1 ^ $t2, gives 1's on all bits that are different
  add $t1, $zero, $zero # initialize number of bits different to zero
bits_loop:
  beq $t3, $zero, bits_ret # exit if no more bits different
  andi $t2, $t3, 1 # check if least sig bit is a 1 or not
  add $t1, $t1, $t2 # if lsb was a 1, add 1 to number of bits different
  srl $t3, $t3, 1 # shift right by 1 bit
  j bits_loop # loop
bits_ret:
  move $v0, $t1 # return number of bits different
  jr $ra

.data
s_greeting: .asciiz "Pattern match program!\n"
s_prompt1:   .asciiz "Enter a 32 bit binary number: "
s_output:   .asciiz "The closest index is: "
newline:		.asciiz "\n"
input:    .space 33
inputSize:   .word 33
array: .word 0, 1431655765, 858993459, 1717986918, 252645135, 1515870810, 1010580540, 1768515945, 16711935, 1437226410, 869020620, 1721329305, 267390960, 1520786085, 1019428035, 1771465110, 65535, 1431677610, 859032780, 1718000025, 252702960, 1515890085, 1010615235, 1769576086, 16776960, 1437248085, 869059635, 1721342310, 267448335, 1520805210, 1019462460, 1771476585