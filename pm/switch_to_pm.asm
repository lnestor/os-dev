[bits 16]
switch_to_pm:
  cli ; disable interrupts

  lgdt [gdt_descriptor] ; load gdt table

  mov eax, cr0 ; Set the first bit of CR0
  or eax, 0x1  ; to 1 to switch to protected mode
  mov cr0, eax

  jmp CODE_SEG:init_pm ; Make a far jump to flush pipeline

[bits 32]
init_pm:
  mov ax, DATA_SEG ; Set all segment registers to the data segment
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x9000 ; Update stack position to use 32 bit registers
  mov esp, ebp

  call begin_pm
