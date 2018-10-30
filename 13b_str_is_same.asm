Print macro x
	mov dx, offset x
	mov ah, 09
	int 21h
endm

get_string macro x
	mov dx, offset x
	mov ah, 09
	lea dx, x
	int 21h
endm

data segment
	str1 db 7 dup(0)
	str2 db 7 dup(0)
	msg1 db, 10, "Enter string 1: $"
	msg2 db, 10, "Enter string 2: $"
	msg3 db, 10, "Same$"
	msg4 db, 10, "Not Same$"
data ends

code segment
assume cs:code, ds:data

start: mov ax, data
	   mov ds, ax
	   mov es, ax

	   Print msg1
	   get_string str1
	   Print msg2
	   get_string str2

	   xor cx, cx

	   cmp cx, 07
	   jnz inv

	   lea si, str1
	   lea di, str2
	   repe cmpsb
	   jnz inv

	   Print msg1

	   jmp last

	inv: Print msg2

	last: mov ah, 4ch
	      int 21h

code ends
end start



