; print_string_pm
;
; Prints a string in protected mode.
; Expects string to be in ebx

[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
  pusha ; save current state of registers
  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  mov al, [ebx] ; Store next character of string
  mov ah, WHITE_ON_BLACK ; Store attributes of character

  cmp al, 0 ; Check for null byte
  je print_string_pm_exit

  mov [edx], ax ; store character and attributes

  add ebx, 1 ; Increment to next character
  add edx, 2 ; Increment to next 2 byte character slot in memory

  jmp print_string_pm_loop

print_string_pm_exit:
  popa
  ret
