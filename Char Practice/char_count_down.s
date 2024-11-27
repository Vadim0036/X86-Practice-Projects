.section .data
numbers:    .asciz "9876543210"
label:      .asciz "Race has started!"

.section .text
.globl _start

_start:
    movl $4, %eax        ; sys_write system call number (4)
    movl $1, %ebx        ; file descriptor (stdout = 1)
    
    movl $0, %esi        ; loop counter (index for the string)
    
loop_start:
    movb numbers(,%esi,1), %al  ; load the current character into %al
    testb %al, %al              ; check if it's the null terminator
    jz loop_end                 ; jump to loop_end if null terminator is reached
    
    movl $1, %edx        ; number of bytes to write (1 byte)
    movl $1, %ecx        ; pointer to the character (stored in %al)
    int $0x80            ; invoke sys_write to print the character
    
    addl $1, %esi        ; increment loop counter
    jmp loop_start       ; repeat the loop

loop_end:
    ; Exit program
    movl $1, %eax        ; sys_exit system call number (1)
    xorl %ebx, %ebx      ; status code 0
    int $0x80            ; invoke sys_exit
