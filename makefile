SRCDIR := src
BUILDDIR := bin

CC := i686-elf-gcc
CFLAGS := -Wall -Wextra -ffreestanding -masm=intel
C_FILES := $(shell find $(SRCDIR) -type f -name "*.c")
C_OBJS := $(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(C_FILES))

AC := nasm
AFLAGS := -f elf32
BOOT_OBJ := $(BUILDDIR)/boot.o

OBJS := $(BOOT_OBJ) $(C_OBJS)

LD := i686-elf-ld
LD_FILE := linker.ld
LIBGCC := $(shell $(CC) -print-libgcc-file-name)

BIN := $(BUILDDIR)/LuzOS.bin
IMG := LuzOS.img

.PHONY: all run clean
all: $(IMG)

$(BOOT_OBJ): $(SRCDIR)/boot.asm
	@mkdir -p $(dir $@)
	@echo "Assembling boot loader"
	@$(AC) $(AFLAGS) -o $@ $(SRCDIR)/boot.asm
	
$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BIN): $(OBJS) $(LD_FILE)
	@echo "Linking object files"
	@$(LD) -T $(LD_FILE) -o $@ $(OBJS) $(LIBGCC)

$(IMG): $(BIN)
	@echo "Writing final binary to image file"
	@dd if=/dev/zero of=$(IMG) bs=1M count=10 2>/dev/null
	@dd if=$(BIN) of=$(IMG) conv=notrunc 2>/dev/null

run: $(IMG)
	@qemu-system-i386 -drive file=$(IMG),format=raw

clean:
	@rm -rf $(BUILDDIR)/*
	@rm -rf $(IMG)