# CS24, file:Exercise Sept 21.s, Fall 2022, (c) Karen Corscadden, Claire Longsworth, Simon Saltikov
# In Class Exercise, September 21, 2022
# C code translation of while loop construct
# while A[i] == c i++
# $s0 holds base address of A
# $s1 holds c
# $t0 holds i (guaranteed to be zero)
# can use $t1 through $t4 only
	
.globl main			

.text				
main:
  move $t2, $s0 # initialize $t2 with address of A[0]
loop:
  lw $t1, 0($t2) # load value stored at location $t2 (A[i])
  bne $s1, $t1, done # where $t1 holds the value of A[i]
  addi $t0, $t0, 1  # i++
  sll $t3, $t0, 2 # $t3 = 4 * i
  add $t2, $s0, $t3 # $t2 = address of A[i]
  j	loop				# jump to loop
done:
	li $v0, 10			# exit
	syscall

