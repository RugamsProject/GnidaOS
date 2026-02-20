org 0x7C00
bits 16

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mov si, msg_hi
    call ps

loop:
    mov si, msg_p
    call ps
    call key
    call up
    cmp al, 'H'
    je sh
    cmp al, 'L'
    je cls
    cmp al, 'B'
    je sbr
    cmp al, 'G'
    je sbe
    cmp al, 'T'
    je sht
    cmp al, 'C'
    je sca
    mov si, msg_no
    jmp out

sh: mov si, msg_h
    jmp out
sbr: mov si, e1
     jmp out
sbe: mov si, e2
     jmp out
sht: mov si, e3
     jmp out
sca: mov si, e4
     jmp out
cls:
    mov ax, 3
    int 0x10
    jmp loop

out:
    call ps
    jmp loop

key:
    xor ah, ah
    int 0x16
    mov ah, 0x0E
    int 0x10
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

up:
    cmp al, 'a'
    jb .d
    cmp al, 'z'
    ja .d
    sub al, 32
.d: ret

ps:
    lodsb
    or al, al
    jz .r
    mov ah, 0x0E
    int 0x10
    jmp ps
.r: ret

msg_hi db 'GnidDOS: H-help',13,10,0
msg_p  db 'A> ',0
msg_no db '?',13,10,0
msg_h  db 'H/L/B/G/T/C',13,10,0
e1 db 'br br patapim',13,10,0
e2 db 'bengal cat online',13,10,0
e3 db 'history boss mode',13,10,0
e4 db 'canon zoom lens',13,10,0

times 510-($-$$) db 0
dw 0xAA55
