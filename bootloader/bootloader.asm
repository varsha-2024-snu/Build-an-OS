[BITS 16]        ; 16-bit mode
[ORG 0x7C00]    ; Bootloader starts at memory address 0x7C00

start:
    mov ax, 0x07C0  ; Set up data segment
    mov ds, ax
    mov es, ax

    ; Print a message
    mov si, msg     ; Load address of the message into SI
    call print_string

    ; Load the kernel into memory
    mov ah, 0x02    ; BIOS read sector function
    mov al, 1       ; Number of sectors to read
    mov ch, 0       ; Cylinder number
    mov cl, 2       ; Sector number (starts from 1)
    mov dh, 0       ; Head number
    mov bx, 0x1000  ; Memory address to load the kernel (0x1000:0x0000)
    mov es, bx
    mov bx, 0x0000
    int 0x13        ; Call BIOS interrupt

    ; Jump to the kernel
    jmp 0x1000:0x0000

print_string:
    lodsb           ; Load next character from SI into AL
    or al, al       ; Check if AL is 0 (end of string)
    jz done         ; If AL is 0, jump to 'done'
    mov ah, 0x0E    ; BIOS teletype function
    int 0x10        ; Call BIOS interrupt
    jmp print_string ; Repeat for next character
done:
    ret             ; Return from function

msg db 'Loading OS...', 0  ; Message to display

times 510-($-$$) db 0  ; Fill the rest of the bootloader with zeros
dw 0xAA55              ; Boot signature (magic number)