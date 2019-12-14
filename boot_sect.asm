[org 0x7c00]
  mov bp, 0x9000 ; Set the stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string_rm

  call switch_to_pm
  jmp $

%include "rm/print_string_rm.asm"
%include "gdt.asm"
%include "pm/switch_to_pm.asm"
%include "pm/print_string_pm.asm"

[bits 32]
begin_pm:
  mov ebx, MSG_PROT_MODE
  call print_string_pm

  jmp $

MSG_REAL_MODE: db "Started in 16-bit real mode", 0
MSG_PROT_MODE: db "Started 32 bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55
