#At the end of the program,
#%rsi stores the maximum value in the array
#%rcx stores the sum of all array elements
.data
arr:
	.long 4,6,3,8,9,1
.text
.globl main
main:
	mov arr@GOTPCREL(%rip),%rbx
	mov $5,%rdi
	mov $5,%rdx
	movzbl (%rbx),%rcx
	movzbl (%rbx),%rsi
	mov %rbx,%r10
	
.max:
	cmp $0,%rdi
	je .sumloop
	lea (%rbx,%rdi,4),%r10
	movzbl (%r10),%r10
	cmp %r10,%rsi
	jl .newrsi
	dec %rdi
	jmp .max
.newrsi:
	mov %r10,%rsi
	dec %rdi
	jmp .max

.sumloop:
	cmp $0,%rdx
	je .exit
	lea (%rbx,%rdx,4),%r10
	movzbl (%r10),%r10
	add %r10,%rcx
	dec %rdx
	jmp .sumloop
.exit:
	ret

