.data
success: .asciiz "code was found\n"
not_success: .asciiz "code was not found\n"
block: .byte 1,2,3,4,5,6,7,8,9,10,121,12,122,14,15,16,117,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32 
.text
la $a0,block # a0 points to array
# receive code
li $v0,5
syscall
addi $s0,$v0,0
li $v0,5
syscall
addi $s1,$v0,0
li $v0,5
syscall
addi $s2,$v0,0
li $v0,5
syscall
addi $s3,$v0,0
li $v0,5
syscall
addi $s4,$v0,0
li $v0,5
syscall
addi $s5,$v0,0
# check for code
addi $t7,$zero,27 #counter for loop
loop:
blez $t7,not_success_print
addi $t6,$zero,0 # t6 = 0
lb $t0,($a0) # load 6 cuurent bytes
lb $t1,1($a0)
lb $t2,2($a0)
lb $t3,3($a0)
lb $t4,4($a0)
lb $t5,5($a0)
bne $t0,$s0,next
addi $t6,$t6,1
bne $t1,$s1,next
addi $t6,$t6,1
bne $t2,$s2,next
addi $t6,$t6,1
bne $t3,$s3,next
addi $t6,$t6,1
bne $t4,$s4,next
addi $t6,$t6,1
bne $t5,$s5,next
addi $t6,$t6,1
addi $t6,$t6,-6 # if t6-6=0 the code was found
beq $t6,$zero,success_print
next:
addi $t7,$t7,-1 # counter --
addi $a0,$a0,1 # pointr ++
j loop
# print found or not
success_print: 
li $v0,4
la $a0,success
syscall
j end
not_success_print:
li $v0,4
la $a0,not_success
syscall

end: #print code
addi $a0,$s0,0
li $v0,1
syscall
addi $a0,$s1,0
li $v0,1
syscall
addi $a0,$s2,0
li $v0,1
syscall
addi $a0,$s3,0
li $v0,1
syscall
addi $a0,$s4,0
li $v0,1
syscall
addi $a0,$s5,0
li $v0,1
syscall
