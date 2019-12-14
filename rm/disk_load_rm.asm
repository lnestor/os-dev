; disk_load_rm
;
; Read from disk in real mode.
; DH: # sectors to read
; DL: Drive to read from
; BX: Offset to read to

disk_load_rm:
  push dx ; Save # sectors to read

  mov ah, 0x02 ; BIOS read sector
  mov al, dh   ; Read DH sectors
  mov ch, 0x00 ; Cylinder 0
  mov dh, 0x00 ; Head 0
  mov cl, 0x02 ; Read starting at 2nd sector
               ; (since bootloader is first sector)

  int 0x13 ; BIOS interrupt

  jc disk_error_rm ; carry bit indicates error

  pop dx ; restore DH
  cmp dh, al ; check that # read is expected
  jne disk_error_rm
  ret

disk_error_rm:
  mov bx, MSG_DISK_ERROR
  call print_string_rm
  jmp $

MSG_DISK_ERROR: db "Error reading disk",0
