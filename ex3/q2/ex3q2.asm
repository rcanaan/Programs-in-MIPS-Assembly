#Rinat Canaan 207744012
#ex3 q2
.data
#array: .byte 3,6,12,24,48,96
#array: .byte 3,6,9,12,15,18
#array: .byte 3,6,9,-12,15,18
#array: .byte 3, 9 , 27, 81 #doesn't work
#array: .byte 1, 1 , 1, 1 # doesn't works
array: .byte 3,9 ,27, 82#doesn't work
geometric_string: .asciiz "the sequence is a geometric sequence\nQ is: "
arithmetic_string: .asciiz "the sequence is a arithmetic sequence\nD is: "
first_number_string: .asciiz "  a1 is: " 
.text
la $a0,array # a0 is point÷r to arr
li $a1,4 # a1 is number of values
li $s1, 1 #for geometric sequence
addi $s0,$a0,0 # s0 is pointr to arr
lb $t0,0($s0) #t0 contains first number
addi,$t7,$t0,0 #save first number in special register
lb $t1,1($s0) # t1 contains second number
sub $t3,$t1,$t0 # t3 is d if exist (saves the result at $t3)
div $t1,$t0 #to check if this is a geometric sequence
mflo $t4 # t4 contains Q if exist (saves the result in LO)
mfhi $s4 #s4 saves the remainder (we want it to be 0 for geometric sequence)
bne $s4 ,$zero , end # if HI isn't 0, it means there is a reminder 
#li $t6,1 # t6 is a flag and assume it is a arithmetic sequence
arithmetic:
addi $t5,$a1,-1 # t5 is a counter (between the  numbers)
loop_arithmetic:
beq $t5,$s1,end_arithmetic #if $t5 =0 it means he checkes all the numbers
addi $s0,$s0,1 # pointr ++
lb $t0,0($s0) #t0 contains first number
lb $t1,1($s0) # t1 contains second number
sub $t2,$t1,$t0 # t2 is d in the loop
bne $t2,$t3,geometric #the "d" is different it means it isn't a arithmatic seq, than check if tis a geo seq
addi $t5,$t5,-1 # t5--
j loop_arithmetic

geometric:
addi $t5,$a1,-2 # t5 is a counter
loop_geometric:

beq $t5,$s1,end_geometric #if $t5=0 it means it checked all the numbers
div $t1, $t0
mflo $s2 # t4 contains Q if exist (saves the result in LO)
bne $s2,$t4,end # if t2 != t4, its not both of the sequences

addi $s0,$s0,1 # pointr ++
lb $t0,0($s0) # t0 contains first number
lb $t1,1($s0) # t1 contains second number
div $t1,$t0 # t2 is Q in the loop
mflo $t2
mfhi $s3 #s3 saves the remainder (we want it to be 0 for geometric sequence)
bne $s3 ,$zero , end # if HI isn't 0, it means there is a reminder 
bne $s4 ,$s3, end
bne $t2,$t4,end # if t2 != t4, its not both of the sequences
addi $t5,$t5,-1 # t5--
j loop_geometric

end_geometric:
la $a0,geometric_string
li $v0,4
syscall
addi $a0,$t4,0
li $v0,1
syscall
j print_a1
end_arithmetic:
la $a0,arithmetic_string
li $v0,4
syscall
addi $a0,$t3,0
li $v0,1
syscall
print_a1:
la $a0,first_number_string
li $v0,4
syscall
add $a0,$t7,$zero
li $v0,1
syscall

end: nop



