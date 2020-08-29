#ex2q2 Rinat Canaan 207744012
#this program runs a calculator system

.data # setting the orders to the user
.data
str1: .asciiz "ENTER VALUE \n"
str2: .asciiz "ENTER OP CODE \n"
error_str: .asciiz "ERROR\n"
end_str: .asciiz "the result is "

.text
li $t0, '+'
li $t1, '-'
li $t2, '*'
li $t3, '@' 
li $t4, -1
li $t5, 0
startloop:
li $v0, 4 #system call for printing
la $a0, str1 #address of str1 to be printed "ENTER VALUE "
syscall

li $v0, 5 #read the entered number
syscall
add $a2, $v0, $zero #copy the entered number to register $a2

start:
li $v0, 4 #system call for printing
la $a0, str2 #address of str2 to be printed "ENTER OP CODE"
syscall

li $v0,12 # system service receive char
syscall
add $a1, $v0, $zero #copy the symbol to register $a1
beq $a1,$t3, endloop #if $a1= "@", then finish the program, else continue

#else, receive another number and check if this is the other actions
li $v0, 4 #system call for printing
la $a0, str1 #address of str1 to be printed "ENTER VALUE "
syscall

li $v0, 5 #read the entered number
syscall
add $a3, $v0, $zero #copy the entered number to register $a3

beq $a1, $t0, plus #if $a1==+
beq $a1, $t1, minus#if $a1== -
beq $a1, $t2, multiply#if $a1== *
j startloop #if this entered symbol is not what had been defined, read a new number

#the actions
plus: 
#add $t5, $a2, $a3  # $a1= $a1 + $a3, and $a1 is used as "sum"
add $a2, $a2, $a3  # $a1= $a1 + $a3, and $a1 is used as "sum"
j start  #go over again to enter another symbol (action)

minus:
#sub $t5, $a2, $a3  # $a1= $a1 - $a3, and $a1 is used as "sum"
sub $a2, $a2, $a3  # $a1= $a1 - $a3, and $a1 is used as "sum"
j start #go over again to enter another symbol (action)

multiply:
mult $a2, $a3  #the result would kept in LO or HI
mflo $t6 #move from LO to $t6, copy the result back
mfhi $t7 #move from HI to $t7 to check if it full of 0 (positive) or 1 (negative)
slti  $t8, $t6, 0   #if LO < 0, if Lo is negative
bne $t8, $zero, error_loop  # if $t5 != 0, is means: $t5 = 1
#add $t5 $t6 $zero
add $a2 $t6 $zero
j next
error_loop:
bne $t7, $t4 print_error  #if HI != -1 
add $a2 $t6 $zero
#beq $t7, $t4 print_error  #if HI != -1
#j next
j start
print_error:
la $a0 ,error_str # load begining of str ERROR to $a0 (required argument)
li $v0 ,4 # system service print string
syscall
li $v0 10 # code of exit program
syscall

slti $t8, $t6, 0  # if LO > 0, if Lo is positive
beq $t8 , $zero, error_loop2
j next
error_loop2:
bne $t7, $zero, print_error
j next

next:
j start
endloop:
la $a0 ,end_str # load begining of str the result is to $a0 (required argument)
li $v0,4 # system service print string
syscall
addi $a0,$a2,0 # load result to $a0 (argument)
li $v0,1 #system service print int 
syscall # prints result

