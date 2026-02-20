ASM=nasm
QEMU=qemu-system-i386

all: gniddos.img

gniddos.img: boot.asm
	$(ASM) -f bin boot.asm -o gniddos.img

run: gniddos.img
	$(QEMU) -drive format=raw,file=gniddos.img

clean:
	rm -f gniddos.img
