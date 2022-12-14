; Author: Eduardo Nunez
; Author email: eduardonunez@csu.fullerton.edu

extern printf, fill_array, array_displayer, get_frequency
extern clock_speed, scanf, sortFloats, sortedarray_displayer

global manager


INPUT_LEN equ 256
max_size equ 10000000

section .data
    inputPrompt db "Please input the count of number of data items to be placed into the array (with maximum 10 million): ", 10,10, 0
    inputConfirm db 10, "The array has been filled with non-deterministic random 64-bit float numbers.", 10, 0
    tenBeginning db "Here are 10 numbers of the array at the beginning: ", 10, 0
    intFormat db "%d", 0
    text2 db "The time is now %lu tics. Sorting will begin.", 10, 0
    text5 db "The time is now %lu tics. Sorting has finished.", 10, 10, 0
    text6 db "Total sort time is %lu tics.", 10, 10, 0
    text7 db "Your processor frequency in GHz is %.2lf.", 10, 10, 0
    text8 db "The elapsed time equals %.9lf seconds.", 10, 10, 0
    text9 db "The sum will be returned to the caller module.", 10, 10, 0
    frequency db "An AMD processor was detected. Please enter your processor frequency in GHz: ", 0

    ld db "%ld", 0
    lf db "%lf", 0
section .bss
    arr resq max_size

section .text
manager:

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

;************************* Print Out Input Prompt ************************* 
mov rax, 0
mov rdi, inputPrompt
call printf

;************************* Call fill_array And Pass In The Size ************************* 
push qword 0
mov rax, 0
mov rdi, arr        ; array 
call fill_array
mov r13, rax        ; Placing the amount of times fill_array iterated "arr" into r13 

;************************* Confirmation line ************************* 
mov rax, 0
mov rdi, inputConfirm
call printf

;************************* Calling Test Function ************************* 
push qword 0
mov rax, 0
mov rdi, arr
mov rsi, r13
call array_displayer 

pop rax
pop rax

call get_frequency
movsd xmm2, xmm0
movsd xmm0, xmm2
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