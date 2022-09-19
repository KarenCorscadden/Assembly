# CS24 function that prints prime numbers
# file:	Corscadden2.s, Fall 2022, (c) Karen Corscadden

.globl main

.text
main:	
	addi $v0, $zero, 4	# 4 = print string
	la $a0, s_greeting		# greeting
	syscall

  addi $v0, $zero, 4	# 4 = print string
	la $a0, s_prompt		# program prompt
	syscall

  li $v0, 5			# read int (into $v0) assumption will be >= 0
	syscall

	move $s0, $v0 # copy the inputted integer (number of primes to print) into $s0
  li $s1, 2 # initialize $s1 with the smallest possible prime value

loop:
  beq $s0, $zero, done		# exit if the number of primes left to print is zero
  move $a0, $s1 # copy current int to test for primeness into $a0 to pass to test_prime
  jal test_prime  # tests $a0 for primeness, returns in $v0
  beq $v0, $zero, main_not_prime
  move $a0, $s1 # copy the current prime int into $a0 to pass to print function
  jal print_prime # prints the prime and a \n
  addi $s0, $s0, -1 # decrements the number of primes left to print
main_not_prime:
  addi $s1, $s1, 1  # increment value to test for primeness
  j loop  # jump to top of loop

done:
	li $v0, 10		# 10 = exit
	syscall

# ----------
# print a prime integer from $a0
print_prime:
	li $v0, 1		# 1 = print int
	syscall
	
	li $v0, 4		# 4 = print string
	la $a0, newline
	syscall
	
	jr $ra			# return

# ----------
# tests an integer in $a0 for primeness
# uses root value in $a1 for calculation
# prime candidate only needs to be tested via division against values
#   less than or equal to the sqrt of the prime, this is pessimistically
#   estimated with our root and square values (calculated in main)
# returns in $v0 1 if it is prime, else 0
test_prime:
  li $t0, 2 # initialize $t0 with smallest value to divide by
  li $t1, 2 # initialize $t1 with the first useful root value (root of a square to use to limit division iterations)
  li $t2, 4 # initialize $t2 with $t1^2
  beq $a0, $t0, is_prime  # if the number being checked is 2, it is prime
base_loop:
  ble $a0, $t2, test_loop  # do not increment the root if the prime to test is less than or equal to the square
  addi $t1, $t1, 1  # increment the root if it's too small
  mul $t2, $t1, $t1 # recalculate the square if the root was incremented
  j base_loop # if the base was incremented recheck to see if it needs to be incremented more
test_loop:
  div $a0, $t0  # $hi = prime_candidate % division_value
  mfhi $t3  # move remainder of division to $t1 so that it can be used in conditional branch
  beq $t3, $zero, not_prime  # if no remainder then the number is not prime
  beq $t1, $t0, is_prime # if the tested value is equal to the root, the number is prime
  addi $t0, $t0, 1  # increment number to divide by
  j test_loop # return to beginning of loop
is_prime:
  li $v0, 1 # set return value to 1
  j	prime_ret # jump to prime_ret
not_prime:
  move $v0, $zero # set return value to 0
prime_ret:
  jr $ra  # return

.data
s_greeting: .asciiz "Welcome to the prime printing function program!\n"
s_prompt:   .asciiz "How many primes? (Enter an integer 0 or greater) "
newline:		.asciiz "\n"
