################# David Wei #################
################# dawei #################
################# 113446591 #################

################# DO NOT CHANGE THE DATA SECTION #################

.data
arg1_addr: .word 0
arg2_addr: .word 0
num_args: .word 0
invalid_arg_msg: .asciiz "One of the arguments is invalid\n"
args_err_msg: .asciiz "Program requires exactly two arguments\n"
invalid_hand_msg: .asciiz "Loot Hand Invalid\n"
newline: .asciiz "\n"
zero: .asciiz "Zero\n"
nan: .asciiz "NaN\n"
inf_pos: .asciiz "+Inf\n"
inf_neg: .asciiz "-Inf\n"
mantissa: .asciiz ""

.text
.globl hw_main
hw_main:
    sw $a0, num_args
    sw $a1, arg1_addr
    addi $t0, $a1, 2
    sw $t0, arg2_addr
    j start_coding_here
print_arg_err:
    la $a0, args_err_msg
    addi $v0, $0, 4
    syscall
    j done
print_invalid_arg:
    la $a0, invalid_arg_msg
    addi $v0, $0, 4
    syscall
    j done
print_invalid_hand:
    la $a0, invalid_hand_msg
    addi $v0, $0, 4
    syscall
    j done
print_inf_neg:
    la $a0, inf_neg
    addi $v0, $0, 4
    syscall
    j done
print_inf_pos:
    la $a0, inf_pos
    addi $v0, $0, 4
    syscall
    j done
print_zero:
    la $a0, zero
    addi $v0, $0, 4
    syscall
    j done
print_nan:
    la $a0, nan
    addi $v0, $0, 4
    syscall
    j done
start_coding_here:
    li $t0, 0
    li $t1, 0
    li $t2, 0
    li $t3, 0
    li $t4, 0
    li $t5, 0
    li $t6, 0
    li $t7, 0
    li $t8, 0
    li $t9, 0
    li $s1, 0
    li $s2, 0
    li $s3, 0
    
    li $s0, 2
    bne $a0, $s0, print_arg_err
    lw $t0, arg1_addr
    lbu $t1, 1($t0)
    bnez $t1, print_invalid_arg
    lbu $t2, 0($t0)
caseD:
    li $t3, 68
    bne $t2, $t3, caseO
    j testSecondArg
caseO:
    li $t3, 79
    bne $t2, $t3, caseS
    li $s6, 0
    li $s7, 26 
    j immediate
caseS:
    li $t3, 83
    bne $t2, $t3, caseT
    li $s6, 6
    li $s7, 27
    j immediate
caseT:
    li $t3, 84
    bne $t2, $t3, caseI
    li $s6, 11
    li $s7, 27
    j immediate
caseI:
    li $t3, 73
    bne $t2, $t3, caseF
    li $s6, 16
    li $s7, 16
    j immediate
caseF:
    li $t3, 70
    bne $t2, $t3, caseL
    lw $t0, arg2_addr
    li $t2, 48  # number 0
    li $t4, 70  # UPPERCASE F
    li $t5, 57  # number 9
    li $t7, 'A'
    li $s0, 16
    li $s1, 0 #final number
    li $t8, 0 #counter
    li $t9, 8 #max
    lbu $t1, 0($t0)
    blt $t1, $t2,print_invalid_arg
    bgt $t1, $t4,print_invalid_arg
    slti $t3, $t1, 65 # store 1 if t1 less than 65
    sgt $t6, $t1, $t5 # store 1 if t1 greater than 57
    beq $t3, $t6, print_invalid_arg
    addi $t8, $t8, 1
    beqz $t3, addLetter2
    j addNumber2
    
caseL:
    li $t3, 76
    bne $t2, $t3, print_invalid_arg
    lw $t0, arg2_addr
    lbu $t1, 0($t0)
    li $t2, 77
    li $t3, 80
    li $t4, 0 
    li $t5, 0 #counter
    li $t6, 49
    li $t7, 52
    li $s6, 51
    li $s7, 56
    li $t8, 0 #P counter
    li $t9, 0
    li $s3, 12
    j lootHand

testSecondArg:  
    lw $t1, arg2_addr
    li $t3, 45
    lbu $t2, 0($t1)
    li $t4, 10
    li $t5, 48
    li $t6, 57
    li $s1, 0 #final number
    li $t7, 1 #number 1
    beq $t2, $t3, moveToSecond #check if the first letter is a negative sign
    j calculate
moveToSecond:	#load from the address one byte after 
    addi $t1, $t1, 1
    j calculateNegative
calculateNegative:
    lbu $t2, 0($t1)
    beqz $t2, printNumber
    bgt $t2, $t6, print_invalid_arg #check if $t2 is less than or equal to 57
    blt $t2, $t5, print_invalid_arg #check if $t2 is greater than or equal to 48
    mul $s1, $s1, $t4 #multiply by 10
    sub $t2, $t2, $t5 #convert string to int
    sub $s1, $s1, $t2 #sub from final number
    addi $t1, $t1, 1 #increment the address by one
    j calculateNegative
calculate:  
    lbu $t2, 0($t1)
    beqz $t2, printNumber
    bgt $t2, $t6, print_invalid_arg #check if $t2 is less than or equal to 57
    blt $t2, $t5, print_invalid_arg #check if $t2 is greater than or equal to 48
    mul $s1, $s1, $t4 #multiply by 10
    sub $t2, $t2, $t5 #convert string to int
    add $s1, $s1, $t2 #add to final number
    addi $t1, $t1, 1 #increment the address by one
    j calculate
printNumber:
    move $a0, $s1
    addi $v0, $0, 1
    syscall
    j done
    
immediate:
    lw $t0, arg2_addr
    lbu $t1, 0($t0)
    li $t2, 48  # number 0
    li $t3, 120 # letter x
    li $t4, 70  # UPPERCASE F
    li $t5, 57  # number 9
    li $t7, 'A'
    li $s0, 16
    li $s1, 0 #final number
    li $t8, 0 #counter
    li $t9, 8 #max
    bne $t1, $t2, print_invalid_arg
    addi $t0, $t0, 1
    lbu $t1, 0($t0)
    bne $t1, $t3, print_invalid_arg
    j I_typeLoop

I_typeLoop:
    addi $t0, $t0, 1
    lbu $t1,0($t0)
    beqz $t1, shifting
    blt $t1, $t2,print_invalid_arg
    bgt $t1, $t4,print_invalid_arg
    slti $t3, $t1, 65 # store 1 if t1 less than 65
    sgt $t6, $t1, $t5 # store 1 if t1 greater than 57
    beq $t3, $t6, print_invalid_arg
    beqz $t3, addLetter
    j addNumber
F_typeLoop:
    addi $t0, $t0, 1
    lbu $t1,0($t0)
    beqz $t1, checkSpecial
    addi $t8, $t8, 1
    blt $t1, $t2,print_invalid_arg
    bgt $t1, $t4,print_invalid_arg
    slti $t3, $t1, 65 # store 1 if t1 less than 65
    sgt $t6, $t1, $t5 # store 1 if t1 greater than 57
    beq $t3, $t6, print_invalid_arg
    beqz $t3, addLetter2
    j addNumber2
addNumber:
    sub $t1, $t1, $t2
    mul $s1, $s1, $s0
    add $s1, $s1, $t1 
    addi $t8, $t8, 1
    bgt $t8, $t9, print_invalid_arg
    j I_typeLoop
addLetter:
    sub $t1, $t1, $t7
    addi $t1, $t1, 10
    mul $s1, $s1, $s0
    add $s1, $s1, $t1 
    addi $t8, $t8, 1
    bgt $t8, $t9, print_invalid_arg
    j I_typeLoop
addNumber2:
    sub $t1, $t1, $t2
    mul $s1, $s1, $s0
    add $s1, $s1, $t1 
    bgt $t8, $t9, print_invalid_arg
    j F_typeLoop
addLetter2:
    sub $t1, $t1, $t7
    addi $t1, $t1, 10
    mul $s1, $s1, $s0
    add $s1, $s1, $t1 
    bgt $t8, $t9, print_invalid_arg
    j F_typeLoop
shifting:
    beq $s6, $s7, shiftingImmediate
    sllv $s1, $s1, $s6
    srlv $s1, $s1, $s7
    j printNumber
    
shiftingImmediate:
    sllv $s1, $s1, $s6
    srav $s1, $s1, $s7
    j printNumber
    
checkSpecial:
    bne $t8, $t9, print_invalid_arg
    li $t8, 0
    beq $s1, $t8, print_zero
    li $t8, 2147483648
    beq $s1, $t8, print_zero
    li $t8, 4286578688
    beq $s1, $t8, print_inf_neg
    li $t8, 2139095040
    beq $s1, $t8, print_inf_pos
    li $t8, 2139095041
    li $t9, 2147483647
    sle $t7, $s1, $t9
    sge $t6, $s1, $t8
    beq $t6, $t7, print_nan
    li $t8, 4286578689
    li $t9, 4294967295
    sle $t7, $s1, $t9
    sge $t6, $s1, $t8
    beq $t6, $t7, print_nan
    j storeExponent

storeExponent:
    li $t9, 2139095040
    and $t0, $s1, $t9
    srl $t0, $t0, 23
    li $t7, 127
    sub $t0, $t0, $t7
    move $a0, $t0
    j checkNegative

checkNegative:
    li $t8, 2147483648
    and $t0, $s1, $t8
    la $t1, mantissa
    srl $t8, $t8, 8
    beqz $t0, addDot 
negative:
    li $t6, 45
    sb $t6, 0($t1)
    addi $t1, $t1, 1
addDot:
    li $t6, 49
    sb $t6, 0($t1)
    addi $t1, $t1, 1
    li $t5, 46
    sb $t5, 0($t1)
loopBits:
    li $t5, 1
    beq $t8, $t5, storeString
    srl $t8, $t8, 1
    and $t0, $s1, $t8
    beqz $t0, addZero
    j addOne
addZero:
    addi $t1, $t1, 1
    li $t6, 48
    sb $t6, 0($t1)
    j loopBits
addOne:
    addi $t1, $t1, 1
    li $t6, 49
    sb $t6, 0($t1)
    j loopBits
storeString:
    addi $t1, $t1, 1
    li $t6, 0
    sb $t6, 0($t1)
    la $a1, mantissa
    j done
lootHand:
    lbu $t1, 0($t0)
    beqz $t1, checkAndStore
    addi $t5, $t5, 1
    beq $t1, $t2, addM
    beq $t1, $t3, addP
    j print_invalid_hand
    
addP:
    addi $t0, $t0, 1
    addi $t5, $t5, 1
    lbu $t1, 0($t0)
    blt $t1, $t6, print_invalid_hand
    bgt $t1, $t7, print_invalid_hand
    addi $t8, $t8, 1
    addi $t0, $t0, 1
    j lootHand
addM:
    addi $t0, $t0, 1
    addi $t5, $t5, 1
    lbu $t1, 0($t0)
    blt $t1, $s6, print_invalid_hand
    bgt $t1, $s7, print_invalid_hand
    addi $t9, $t9, 1
    addi $t0, $t0, 1
    j lootHand
    
checkAndStore:
    bgt $t5, $s3, print_invalid_hand
    li $s1, 0
    add $s1, $s1, $t9
    sll $s1, $s1, 3
    add $s1, $s1, $t8
    move $a0, $s1 
    addi $v0, $0, 1
    syscall
    j done
done:
    li $v0, 10
    syscall
    
    
    
    
    
    
