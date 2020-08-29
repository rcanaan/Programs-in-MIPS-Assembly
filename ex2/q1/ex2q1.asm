#ex2 q1 Rinat canaaan 207744012
#this program finds the biggest number at the array and prints it

.data#the information
array: .byte -2, -8, -7, -3, -9

.text	#the actions
la $a0, array 	#setting $a0 as a pointer to array
#la $a3, 	#setting $a3 also as a pointer to array
la $a1, 4	#$a1 presents the length of the array ,5
la $a3, 0
lb $v0, 0($a0)	#setting $v0 as the first index for the start (max = arr[0])
#lb $a2, 1($a0)	#setting $a2 to be after $v0 ($a2 = i, $a2= arr[1])

#addi $a0,$a0,1 # $a0++ promoting pointer to array of data
startloop:
lb $a2, 1($a0)	#setting $a2 to be after $v0 ($a2 = i, $a2= arr[1])
slt $t0, $v0, $a2	#if (biggest < vec[i])
bne $t0, $zero, continue #if ($t0 == 1), meaning: if the previous condition was fullfilled 
addi $a0, $a0, 1#else, i++ (and because this is *bytes* the jumps will be with 1 and not 4)
addi $a3, $a3, 1
j middle

continue: #in case (biggest < vec[i])
la $v0, ($a2) # right now, biggest = arr[i] ($v0 = $a2)
addi $a0,  $a0, 1 # i++ , going to the next index anyway
addi $a3, $a3, 1

middle:
beq $a3, $a1, endloop #if this is the end of the array
j startloop

endloop:
addi $a0, $v0, 0
li $v0, 1
syscall

#output:
#9
