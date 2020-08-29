#Rinat Canaan and Hani Mazuz
#ex1 question 1
.data
array1: .word 1 2 3 4 0
array2: .word 6 7 8 9
.text
la $a0 , array1#setting pointer to array1
la $a1, array2#setting pointer to array2
startLoop:
lw $t4 ,0($a0)#using $t4 as temp
sw $t4 ,0($a1)
addi $a0, $a0, 4#jump to the next index
addi $a1, $a1, 4#jump to the next index
beq $t4 0 finish#if $t4 == 0 stop
addi $t1, $t1, 1#else, continue and count how many integets had copied
bne $t4 0 startLoop#if $t4 != 0, go over again to the loop
finish: 
