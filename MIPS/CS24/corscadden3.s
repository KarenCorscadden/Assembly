# CS24 function that recursively calculates Greatest Common Divisor
#   via Euclid's GCD Algorithm:
#     GCD(M,N) = M                (if N is 0)
#     GCD(M,N) = GCD(N, M % N)    (if N > 0)
# file:	Corscadden3.s, Fall 2022, (c) Karen Corscadden

.globl main

.text
main:	
	addi $v0, $zero, 4	# 4 = print string
	la $a0, s_greeting		# greeting
	syscall

  addi $v0, $zero, 4	# 4 = print string
	la $a0, s_prompt1		# program prompt
	syscall

  li $v0, 5			# read int (into $v0) assumption will be >= 0
	syscall

	move $s0, $v0 # copy the inputted integer (first integer = M) into $s0

  li $v0, 5			# read int (into $v0) assumption will be >= 0
	syscall

	move $s1, $v0 # copy the inputted integer (second integer = N) into $s1

  blt $s0, $s1, switch
  move $a0, $s0 # copy M into first argument slot
  move $a1, $s1 # copy N into second argument slot
  j do_calc
switch:
  move $a0, $s1 # copy N into first argument slot (becomes M)
  move $a1, $s0 # copy M into second argument slot (becomes N)

do_calc:
  jal calc_gcd

  move $t0, $v0 # copy result of GCD calculation into $t0 for usage
  move $a0, $t0 # copy GCD into first argument slot to get ready to print

  jal print_gcd

done:
	li $v0, 10		# 10 = exit
	syscall

# ----------
# print the GCD result from $a0
print_gcd:
	li $v0, 1		# 1 = print int
	syscall
	
	li $v0, 4		# 4 = print string
	la $a0, newline
	syscall
	
	jr $ra			# return

# ----------
# recursively calculates Greatest Common Divisor
#   via Euclid's GCD Algorithm:
#     GCD(M,N) = M                (if N is 0)
#     GCD(M,N) = GCD(N, M % N)    (if N > 0)
# returns GCD in $v0
calc_gcd:
  # create new stack frame
  addi $sp, $sp, -4  # adjust stack pointer
  sw $ra, 0($sp)  # push ra into the stack

  beq $a1, $zero, trivial_case

  div $a0, $a1 # calculate M % N
  mfhi $t1  # store in $t1

  move $a0, $a1 # move N to the first argument position (M)
  move $a1, $t1 # move M % N to the second argument position (N)
  jal calc_gcd  # call recursive function
  j gcd_ret			# jump to gcd_ret

trivial_case:
  move $v0, $a0

gcd_ret:
  # tear down the stack frame
  lw $ra, 0($sp)  # restore register ra from stack
  addi $sp, $sp, 4  # adjust stack pointer to take down the stack frame
  jr $ra  # return

.data
s_greeting: .asciiz "Euclid's GCD algorithm\n"
s_prompt1:   .asciiz "Enter two integers (0 or greater): "
newline:		.asciiz "\n"
