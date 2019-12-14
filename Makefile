# $@ - target file
# $< - first dependency
# $^ - all dependencies

# Generate list of files
C_SOURCES = $(wildcard kernel/*.c)
OBJ = ${C_SOURCES:.c=.o}

all: os-image

# Actual disk image that bochs loads
os-image: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > os-image

# Kernel binary
kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Compiling C sources
%.o: %.c
	gcc -ffreestanding -c $< -o $@

# Assemble kernel_entry
%.o: %.asm
	nasm $< -f elf -o $@

# Assemble normal asm files
%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm kernel/*.o boot/*.bin os-image
