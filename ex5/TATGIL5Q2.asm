# targil 5

.data
.ascii
read:"give me a hexadecimal number please: \0"
input:"input= \0"
output:"output= \0"
err:"oops! this op code is not one of the op code we have here :(\0"

get_numbers:"give me 6 numbers por favor\0"
note:"this code does not exist\0"
exist:"congradulatios!!!!! the code exist :)\0"
arr:

.byte
arr1:
1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 8 7 6 5 4 3 2 1 4 5 6 9 8 7 4
arr2:

.text
j q2

#---------------------------------------------------------------------------------------
# question 1
#--------------------------------------------------------------------------------------


q1:
 li $v0 4 
 la $a0 get_numbers # בקשה לקליטת המספרים לקוד
 syscall

li $t0 6  # כמות האיברים שבקוד
la $a0 arr2  # מקבל את הכתובת של מערך 2 שיכיל את המספרים של הקוד
read_numbers:
 li $v0 5 
 syscall
 sb $v0 0($a0)# קליטת המספר הראשון בקוד לתוך vo 
 addi $a0 $a0 1 # מתקדמים לאיבר הבא בקוד
 addi $t1 $t1 1#counter
 bne $t1 $t0 read_numbers

 la $a0 arr2 # מקבל את הכתובת של מערך 2 שיכיל את המספרים של הקוד
li $t4 33#מספר האיברים של הלולאה
 li $t0 7 
 la $a1 arr1 #מקבל את הכתובת של המערך הראשון שמכיל 32 מספרים 
 from_the_beginning:
 lb $t1 0($a1) #המrאשון במערך המספרים הנתונים, לתוך המשתנה t1
 add $a2 $zero $a1 # אי 2 מצביע לכתובת המערך הראשון שנמתצאת באי 1
 addi $a1 $a1 1 # מתקדמים במערך הראשון למספר הבא על ידי המצביע אי1
 addi $t5 $t5 1#הוא סופר את כמות הביטים בהם התקדמנו בהמלך התוכנית בארי 1 כשמגיע ל33 צריך לשלוח הודעה שאין רצף
 beq $t5 $t4 not_exist #ברגע שעברנו את כל המערך והגענו לסופו בלי הקוד

la $a3 arr2 # מקבל את כתובת המערך שמכיל את הקוד
lb $t2 0($a3) #טי 2 מקבל את המספר הראשון של הקוד
li $t6 6#הוא ההשוואה ללולאה
li $t7 0
loop:
bne $t1 $t2 from_the_beginning # כאשר המספר שבמערך המספרים הנתונים לא שווה למספר של הקוד, נחזיר את המצביע למערך של הקוד להתחלה ונבדוק מעכשיו והלאה האם אלו הם מספרים של הקוד
addi $a2 $a2 1 # מתקדמים למספר הבא במערך
 lb $t1 0($a2) #טוענים את המספר הבא במערך לתוך טי1
addi $a3 $a3 1 #מתקדם למספר הבא בקוד
lb $t2 0($a3) #טוענים את המספר הבא במערך לתוך טי2
addi $t7 $t7 1 # מספר האיברים ששווים לקוד
bne $t6 $t7 loop #ממשיכים להשוות מספרים ממערך הנתונים למערך הקוד

 li $v0 4 
 la $a0 exist #קוד סיום תכנית
 syscall
j exit

not_exist: #אם אין את הקוד בכלל במערך הנתונים
 li $v0 4 
 la $a0 note
 syscall
j exit

#---------------------------------------------------------------------------------------
# question 2
#--------------------------------------------------------------------------------------

q2:

li $v0 4 # the code of the output instruction  
la  $a0 read 
syscall

li $v0 5 #receiving the int
syscall
add $a2 $v0 $zero # the number is added to register $a2

add $s3 $zero $a2 # כדי שנדפיס אחר כך את הקלט ההתחלתי 

li $a0 0x0
add $a0 $a0 $v0
li $a3 0xff000000
li $a1 0x31000000
and $a2 $a0 $a3
beq $a1 $a2 one

li $a1 0x30000000
and $a2 $a0 $a3
beq $a1 $a2 zero

li $a1 0x48000000
and $a2 $a0 $a3
beq $a1 $a2 exchange

li $a1 0x74000000
and $a2 $a0 $a3
beq $a1 $a2 shift

j error


one:  #הצבת אחדות בביטים 0,1,6,7
li $t0 0x000000c3
or $a2 $t0 $a0
j end

zero: # הצבת אפסים בביטים 0,1,6,7
li $t0 0xffffff3c
and $a2 $t0 $a0
j end


exchange: 
li $t0 0x0000ff00
xor $a2 $t0 $a0
j end

shift:# מזיזים את המספר ב-n סיביות 
add $a2 $zero $a0
li $t0 0x01f00000 
and $t0 $t0 $a0
srl $t0 $t0 20
loop1:
beq $t0 $zero end
sll $a2 $a2 1
subi $t0 $t0 1
bne $t0 $zero loop1
j end

error:
li $v0 4  
la  $a0 err
syscall

li $v0 10 #code of receiving the second int
syscall

end:

li $v0 4  
la  $a0 input 
syscall

li $v0 1 #printing int
add $a0 $zero $s3
syscall

li $v0 4 #the code for printing a string 
la  $a0 output 
syscall

li $v0 1 #printing int
add $a0 $zero $a2
syscall


li $v0 10 #code of receiving the second int
syscall

exit: