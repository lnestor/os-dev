[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; Kernel is stored here in memory

  mov [BOOT_DRIVE], dl ; Save drive to read from

  mov bp, 0x9000 ; Set the stack
  mov sp, bp

  mov bx, MSG_REAL_MODE
  call print_string_rm

  call load_kernel
  call switch_to_pm
  jmp $

%include "boot/rm/print_string_rm.asm"
%include "boot/rm/disk_load_rm.asm"
%include "boot/gdt.asm"
%include "boot/pm/switch_to_pm.asm"
%include "boot/pm/print_string_pm.asm"

[bits 16]
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string_rm

  mov bx, KERNEL_OFFSET ; Address to load to
  mov dh, 15 ; Load 15 sectors
  mov dl, [BOOT_DRIVE] ; Drive to read from
  call disk_load_rm

  ret

[bits 32]
begin_pm:
  mov ebx, MSG_PROT_MODE
  call print_string_pm

  call KERNEL_OFFSET

  jmp $

BOOT_DRIVE: db 0
MSG_REAL_MODE: db "Started in 16-bit real mode", 0
MSG_PROT_MODE: db "Started 32 bit protected mode", 0
MSG_LOAD_KERNEL: db "Loading kernel into memory", 0

times 510-($-$$) db 0
dw 0xaa55
