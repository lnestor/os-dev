; print_string_rm
;
; Print string in real mode.
; Expects string to be in bx

print_string_rm:
  pusha ; push all registers onto the stack
  mov ah, 0x0e ; scrolling tele-type for BIOS printing routine
  mov al, [bx] ; move next byte into al register

print_string_rm_loop:
  int 0x10 ; print interrupt

  add bx, 0x1 ; increment address to next character

  mov al, [bx] ; move next byte into al register

  cmp al, 0x0 ; if byte is 0, stop printing
  je print_string_rm_end

  jmp print_string_rm_loop ; loop to next character

print_string_rm_end:
  popa ; pop registers back into their values
  ret
