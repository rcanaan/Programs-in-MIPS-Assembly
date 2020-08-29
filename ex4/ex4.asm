#ex4
#Rinat Canaan 207744012
#Functions
.data
str1: .asciiz "ENTER VALUE \n"
str2: .asciiz "ENTER OP CODE \n"
end_str: .asciiz "the result is "

.text
li $t0, '+' #the options for the different actions
li $t1, '*'
li $t2, '^'
li $t3 '@'

#printing and reading
li $v0, 4 #system call for printing
la $a0, str1 #address of str1 to be printed "ENTER VALUE "
syscall
li $v0, 5 #read the entered number
syscall
add $a2, $v0, $zero #copy the entered number to register $a2

li $v0, 4 #system call for printing
la $a0, str2 #address of str2 to be printed "ENTER OP CODE"
syscall
li $v0,12 # system service receive char
syscall
add $s0, $v0, $zero #copy the symbol to register $s0

li $v0, 4 #system call for printing
la $a0, str1 #address of str1 to be printed "ENTER VALUE "
syscall
li $v0, 5 #read the entered number
syscall
add $a3, $v0, $zero #copy the entered number to register $a2

Omult:
bne $s0 ,$t1, Oadd #checks if this mult optioin, else go to add
add $sp $sp -16 #setting it as a pointer
sw $ra 0($sp) #the adrees/num line to to jump to
sw $a1 4($sp)
sw $t4 8($sp)
slt $t4, $a0, $zero #checks if the number is positive or negative
beq $t4 ,$zero ,setup #if $t4 == 0, else this is a negative number
#for negative
sub $a1 ,$zero ,$a1 #changes the sign
sub $a0 ,$zero ,$a0

setup:
add $v0 ,$zero ,$zero #creates returned value
add $t4, $zero, $a0

loop:
beq $t4, $zero, end#if the "mone" is 0, end
add $a0, $v0, $zero #copy the value from $v0 to $a0
jal Oadd #adding function
sub $t4 $t4 +1 #reduce the "mone"
j loop 

 
  
   
end:
lw $ra 0($sp)
lw $a1 4($sp)
lw $a0 12($sp
lw $t4 8($sp)
addi $sp, $sp, 16 #setting from the start as a pointer
jr $ra #jump where the $ra points to














#start:
bne $s0,$t0,mult_option # if not addtion skip
jal addtion
addi $a0,$v0,0 # save result to a0 
j print
mult_option:
bne $s0,$t1,pow_option # if not mult skip
jal multiplication
addi $a0,$v0,0 # save result to a0 
j print
pow_option:
bne $s0,$t2,end # if not pow end program
jal pow
addi $a0,$v0,0 #save result to a0 
print:
li $v0,1 #print resoult
syscall
j end
addtion: # additon function
add $v0,$a0,$a1 
jr $ra

multiplication:
addi $t6,$ra,0 # save retun adress

addi $a2,$a0,0 # save a0 and a1
addi $a3,$a1,0

addi $t0,$a1,-1 # t0 is counter of loop
addi $a1,$a0,0
loop_mult:
blez $t0,end_mult
jal addtion
add $a0,$zero,$v0 # a0 = v0
addi $t0,$t0,-1
j loop_mult
end_mult: 
addi $v0,$a0,0 # resolt in v0

addi $a0,$a2,0 # recover back a0 and a1
addi $a1,$a3,0
addi $ra,$t6,0 # recover retun adress
jr $ra

pow:
addi $t7,$ra,0 # save retun adress

addi $t1,$a1,-1 # t1 is counter of loop
addi $a1,$a0,0
loop_pow:
blez $t1,end_pow
jal multiplication
add $a0,$zero,$v0 # a0 = v0
addi $t1,$t1,-1
j loop_pow
end_pow: 
addi $v0,$a0,0 # resolt in v0

addi $ra,$t7,0 # recover retun adress
jr $ra

end:
