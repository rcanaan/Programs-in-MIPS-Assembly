#Rinat Canaan and Chani Mazuz
#ex1 question 2
startLoop:
li $v0, 5#read the number
syscall#act 

slti $t0, $v0, 100   #if v0<100, than t0 = 1(true), else - t0 = 0 (false)
beq $t0, $zero, startLoop#if t0==0, start over again (meaning- in case v0>99 go and strat over)


slti $t0, $v0, -99#if v0<-99, t0 =1, else t0 =0 (instead of if t0 > -100)
bne $t0, $zero, startLoop#if t0==0,  start over again (meaning- in case v0<-99 go and start over)

beq $v0, $zero, endLoop# if $v0 == 0, break and print the sum on the screen
add $a0, $a0, $v0#sum+=$a0

j startLoop#if $a1 != 0, go over again to the loop
endLoop:
li $v0 , 1#printing 
syscall
 
 #Example1:
 #input: -100, -99, -98,0
#result: -197

#example 2:
#input: 1, 2, 3, -100, 95, -99, 0
#result: 2
