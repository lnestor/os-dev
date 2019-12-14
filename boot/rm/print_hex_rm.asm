; print_hex_rm
;
; Prints a hex string in real mode.
; Expects the number to be in dx

print_hex_rm:
  pusha ; push all registers onto the stack

  mov ax, 0x0 ; ax will count how many iterations we've had
  mov bx, HEX_OUT ; load the address of the template string
  add bx, 0x05 ; get to the final address of the string

print_hex_rm_loop:
  mov cx, 0xF ; cx will hold a single hex digit
  and cx, dx ; get the lowest hex digit

  cmp cx, 0xa ; check if the digit is a number or letter
  jl print_hex_rm_convert_num
  jmp print_hex_rm_convert_letter

print_hex_rm_done_convert:
  mov byte [bx], cl ; change the byte on the template string
  sub bx, 0x1 ; reduce the offset by 1

  cmp ax, 0x3 ; jump to the end of the loop if we've
  je print_hex_rm_end ; done all 4 digits

  shr dx, 0x4 ; shift the hex number over 4 bits to get the next digit

  add ax, 0x1 ; increment counter
  jmp print_hex_rm_loop

print_hex_rm_convert_num:
  add cx, 0x30 ; add 30 to get the ASCII digit
  jmp print_hex_rm_done_convert

print_hex_rm_convert_letter:
  add cx, 0x57 ; add 57 to get the ASCII digit
  jmp print_hex_rm_done_convert

print_hex_rm_end:
  sub bx, 0x1 ; retreat address to start of hex string
  call print_string_rm
  popa ; pop registers back into their values
  ret

HEX_OUT: db '0x0000',0
