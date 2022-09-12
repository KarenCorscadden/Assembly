# CS24, file:2_18.s, Fall 2022, (c) Karen Corscadden
# Assignment 3, Question 4, September 12, 2022
# Find the shortest sequence of MIPS instructions that
# extracts bits 16 down to 11 from register $t0 and
# uses the value of this field to replace bits 31 down
# to 26 in register $t1 without changing the other
# bits of registers $t0 and $t1.
	
.globl main			

.text				
main:
  li $t0, 0x157FF
  li $t1, 0xFFFFFFFFFFFFFFFF
  li $t2, 0x1F800 # create a mask for extracting bits 16 to 11
  and $t2, $t0, $t2 # applies the mask to extract bits 16 - 11 into $t2
  sll $t2, $t2, 15
  li $t3, 0x3FFFFFF # creates a mask to extract the lower 26 bits
  and $t3, $t1, $t3 # extracts the lower 26 bits of $t1 into $t3
  and $t1, $t1, $t3 # zeros out the top 6 bits of $t1
  or $t1, $t1, $t2

	li $v0, 10			# exit
	syscall
	

