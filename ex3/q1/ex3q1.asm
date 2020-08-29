#Rinat Canaan 207744012
#ex3 q1 - bubble sort
.data
#vec: .word -18, -3, 4, -10, 0, -9, 3
#vec: .word 18, 6, 5, 4, 0, -9, 3
#vec: .word 18, -6, 5, -4, 0, -9, 3
vec: .word 18 6 5 4 3 0 -112
.text
la $a0, vec #setting $a0 as a pointer to vec
li $a1, 7 #$a1= size of vec (7)
la $t0, 0 # i=0
la $t1, 0 #j=0
addi $t2, $a1, -1 # $t2 = (size-1)
addi $t3,$a0,0 # $t3 = $a0 (temp pointer)

for_loop:
addi $t0, $t0, 1# i++, belongs to the for loop  
#la $t0, 1# i++, belongs to the for loop 
beq $t1, $t2, end_for #if j=(size-1) finish
#slt $t3, $t1, $t2 # if(t1<t2)= if(j<size-1)  (we want it to be smaller)
#beq $t3, $zero #checks the slt result. if $t3=0 it means that the condition is not fulfuled (we want $t3=1, to continue)
lw $s0 0($t3) #$s0 = vec[0]
lw $s1 4($t3)#s0 = vec[1]
slt $a2 ,$s1 , $s0 #if (vec[i+1}<vec[i])
beq $a2, $zero, second_if  #checks the slt result. if $a2=0 it means that the condition is not fulfuled (we want $a2=1, to continue)
#inside the first if-swap
sw $s0 4($t3) 
sw $s1 0($t3)  
#addi $t3,$t3,4 # pointr ++
#end of swap
second_if:
addi $t3,$t3,4 # pointr ++
bne $t0, $t2,  for_loop #if(i != size-1) jump to the for_loop
#if (i =size-1):
li $t0, 0 #i = 0
addi $t3,$a0,0 # $t3 = $a0 (temp pointer)
addi $t1, $t1, 1#j++
#end of second if
#addi $t0, $t0, 1# i++, belongs to the for loop  
j for_loop
end_for:
# print
#addi $t3,$a0,0 # $t3 is the pointr because $a0 is needed for system calls
li $v0,1 #for syscall of print int
print_loop: 
beq $a1,$zero,end_print_loop # while ($a1 != 0)
lw $a0,0($t3) # load word to print
syscall
addi $t3,$t3,4 # pointr ++
addi $a1,$a1,-1 # $a1--
j print_loop
end_print_loop: nop
