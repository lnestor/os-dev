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
kernel/kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# Compiling C sources
%.o: %.c
	gcc -m32 -fno-pie -ffreestanding -c $< -o $@

# Assemble kernel_entry
%.o: %.asm
	nasm $< -f elf32 -o $@

# Assemble normal asm files
%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm boot/*.o boot/*.bin
	rm kernel/*.o kernel/*.bin
	rm os-image
