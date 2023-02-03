MODULE_NAME = ili9488
DTS_FNAME = $(MODULE_NAME).dts
DTS_TEMP_FNAME = $(MODULE_NAME).tmp.dts
DTB_FNAME = $(MODULE_NAME).dtb
DTC ?= dtc

# CFLAGS_$(MODULE_NAME).o += -I$(PWD)

ifneq ($(KERNELRELEASE),)
	obj-m := $(MODULE_NAME).o
else
	KSRC ?= $(PWD)
endif

# Bootlin Explanation
# The module Makefile is initially interpreted with KERNELRELEASE undefined, so
# it calls the kernel Makefile, passing the module directory in the M variable
# The kernel Makefile knows how to compile a module, and thanks to the M
# variable, knows where the Makefile for our module is. This module Makefile is
# then interpreted with KERNELRELEASE defined, so the kernel sees the obj-m
# definition.

all: dtb
	$(MAKE) -C $(KSRC) M=$$PWD

# https://linux-sunxi.org/Device_Tree#Compiling_the_Device_Tree
dtb:
	$(CPP) -nostdinc -I include -undef -x assembler-with-cpp -I$(KSRC)/include $(PWD)/$(DTS_FNAME) > $(PWD)/$(DTS_TEMP_FNAME)
	$(DTC) -O dtb -b 0 -o $(PWD)/$(DTB_FNAME) $(PWD)/$(DTS_TEMP_FNAME)
	$(RM) $(PWD)/$(DTS_TEMP_FNAME)

clean:
	$(RM) $(PWD)/*.o
	$(RM) $(PWD)/*.ko
	$(RM) $(PWD)/*.order
	$(RM) $(PWD)/*.symvers
	$(RM) $(PWD)/*.mod*
	$(RM) $(PWD)/.mod*
	$(RM) $(PWD)/.Mod*
	$(RM) $(PWD)/.$(MODULE_NAME)*
