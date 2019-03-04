/* Global data section starts */
.data

N:
    .byte  5 

sum: 
    .long                 # 4 bytes

store:
    .byte
    .byte
    .byte
    .byte
    .byte

.align 8 

message:
    .ascii "\ncomputation over\n"


/* Code section starts */

.text
square:   #expects parameter in %ebx 
   movl %ebx, %ecx
   imul %ecx, %ecx  
   ret
.global main
main:
    movl  $0, %eax        # sum <-> %eax
    mov   N@GOTPCREL(%rip), %rbx        
    movzbl  (%rbx), %ebx    # N <-> %ebx
    mov   store@GOTPCREL(%rip), %r10
.Lback:
    cmpl  $0, %ebx
    je .Lloopexit
    call square
    addl  %ecx, %eax         # sum = sum + i*i 
    mov   %eax, (%r10)
    dec   %ebx 
    inc   %r10
    jmp   .Lback
.Lloopexit:
    mov sum@GOTPCREL(%rip), %rbx # reuse register %rbx
    mov %eax, (%rbx)

   #printing string
    mov     $1, %rax                # system call 1 is write
    mov     $1, %rdi                # file handle 1 is stdout
    mov     message@GOTPCREL(%rip), %rsi          # address of string to output
    mov     $17, %rdx               # number of bytes
    syscall                         # invoke operating system to do the write
    ret
