; GDT - Global Descriptor Table
;
; Defines the segments our memory has
; A segment descriptor is 8 bytes specifying
; the address, size, and flags for it

gdt_start:

gdt_null: ; first element of GDT is a null descriptor
  dd 0x0  ; double word (4 bytes)
  dd 0x0

; base = 0, limit = 0xfffff
; 1st flags: present(1) priviledge(00) descriptor type(1) -> 1001b
; type flags: code(1) conforming(0) readable(1) accessed(0) -> 1010b
; 2nd flags: granulator(1) 32-bit default(1) 64-bit(0) AVL(0) -> 1100b
gdt_code: ; code section of gdt
  dw 0xffff    ; Limit (bits 0-15), 2 bytes
  dw 0x0       ; Base (bits 0-15), 2 bytes
  db 0x0       ; Base (bits 16-23), 1 byte
  db 10011010b ; 1st flags, type flags, 1 byte
  db 11001111b ; 2nd flags, limit (bits 16-19), 1 byte
  db 0x0       ; Base (bits 23-31), 1 byte

; Same as code segment with following changes:
; type flags: code(0) expand down(0) writable(1) accessed(0) -> 0010b
gdt_data: ; data section of gdt
  dw 0xffff ; Limit (bits 0-15), 2 bytes
  dw 0x0       ; Base (bits 0-15), 2 bytes
  db 0x0       ; Base (bits 16-23), 1 byte
  db 10010010b ; 1st flags, type flags, 1 byte
  db 11001111b ; 2nd flags, limit (bits 16-19), 1 byte
  db 0x0       ; Base (bits 23-31), 1 byte

gdt_end: ; put so assembler can calculate size of gdt

gdt_descriptor: ; Specifies size and address of gdt
  dw gdt_end - gdt_start - 1 ; Size of gdt minus 1 (why?)
  dd gdt_start               ; start address

; Constants for easy access of gdt elements
CODE_SEG equ gdt_code - gdt_start ; 0x08, 8 bytes
DATA_SEG equ gdt_data - gdt_start ; 0x10, 16 bytes
