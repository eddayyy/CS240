;****************************************************************************************************************************
;Program name: "Pure Assembly in 2022 Program".  This program demonstrates the input of a float number, the output of time, *
;radians, and the cosine of the inputted float                                                                              *
;                                                                                                                           *
;This file is part of the software program "Pure Assembly in 2022 Program".                                                 *
;Pure Assembly in 2022 Program is free software: you can redistribute it and/or modify                                      *
;****************************************************************************************************************************
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eduardo M. Nunez Gomez
;  Author email: eduardonunez@csu.fullerton.edu
;
;Program information
;  Program name: Pure Assembly In 2022 Program
;  Programming languages: All modules in X86-64 Assembly using the NASM Compiler with Intel Syntax, 1 Shell file to compile & link.
;  Date program began: 2022-Oct-24 0800 PDT GMT-07:00
;  Date of last update: 2022-Oct-31 1800 PDT GMT-07:00
;  Date comments upgraded: 2022-Oct-31 
;  Files in this program: _start.asm , cosine.asm , ftoa.asm , input.asm , io.asm , itoa.asm , stringtof.asm , r.sh
;  Status: Finished.
;  References consulted: Johnson Trong SI leader, x86-64 Assembly Language Programming With Ubuntu by Ed Jorgensen (Chapters 1-8 & 14-25),
;  Holliday Floyd During Section-01 Lab Hours, and the nasm.us/doc for information on the NASM Assembler
;
;Purpose
;  This program demonstrates how to receive, return, store, and floats, tics, and radians.
;  The intention is to teach readers the ins and outs of pure assembly so that they may recreate their own software.
;
;This file
;  File name: input.asm
;  Language: X86 using NASM Assembler and Intel syntax
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Compiling and Linking this program and file:
;File: run.sh
;All assembling, compiling, and linking has been condensed for the user into a single file the following is a user-tutorial.
;
;Instructions: Enter the following in your linux terminal
;
;chmod +x run.sh 
;./run.sh 
;  
;
;===== Begin code area ========================================================================================================
extern showstring
global input

;========================= Initializing constants =========================
stdin equ 0 
stdout equ 1
sys_read equ 0
sys_write equ 1
max_length equ 20
sys_time equ 201 ; get time 
strnlen equ max_length + 1

LF equ 10
NULL equ 0
pointer_to_line_len equ 1
success equ 0
exit equ 60

section .data
newline db 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0xa, 0        ;Declare an array of 8 bytes where each byte is initialize with ascii value 10 (newline)                                   
inputPhrase db "Please enter an angle in degrees and press enter: ", 0
enteredPhrase db "You entered: ", 0
PTLF db LF, 10, 0


section .bss
align 16
char resb 1
user_name resb strnlen

section .text
input:
;========================= Backing up all 64 bit registers =========================
push rbp
mov  rbp,rsp
push rdi                                                    
push rsi                                                    
push rdx                                                   
push rcx                                                    
push r8                                                     
push r9                                                     
push r10                                                    
push r11                                                  
push r12                                                   
push r13                                                   
push r14                                                   
push r15                                                    
push rbx                                                    
pushf   


;========================= Receiving String =========================
mov rdi, inputPhrase
mov rsi, 0
call showstring

;========================= Receiving String =========================
mov rax, sys_read
mov rdi, stdin 
mov rsi, user_name
mov rdx, max_length
syscall

mov r15, rax ; Holds # of chars inputted

cmp r15, max_length
jl keep_going

mov [user_name + max_length], byte NULL
inc r15

clear_input_buffer:
    mov rax, sys_read
    mov rdi, stdin
    mov rsi, char
    mov rdx, 1
    syscall 
    mov al, byte [char]
    cmp al, byte LF
    jne clear_input_buffer

jmp keep_going

keep_going:
    mov [user_name+ r15 - 1], byte NULL

mov rdi, enteredPhrase
mov rsi, 0
call showstring


print:
    ;print the char
    mov rax, sys_write
    mov rdi, stdout
    mov rsi, user_name
    mov rdx, r15
    syscall

    mov rax, sys_write
    mov rdi, stdout 
    mov rsi, pointer_to_line_len
    mov rdx, PTLF
    syscall

    mov rax, sys_write
    mov rdi, stdout 
    mov rsi, newline
    mov rdx, 1
    syscall 

    mov rax, user_name ; string
    mov rdi, r15 ; stringlength

;========================= Restoring all 64 bit registers for stability and peace among the stack =========================
popf                                                        
pop rbx                                                    
pop r15                                                    
pop r14                                                    
pop r13                                                   
pop r12                                                     
pop r11                                                   
pop r10                                                     
pop r9                                                     
pop r8                                                     
pop rcx                                                     
pop rdx                                                   
pop rsi                                                    
pop rdi                                                     
pop rbp    
                                                 
ret