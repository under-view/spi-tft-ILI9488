MODULE_NAME = ili9488
DTS_FNAME = $(MODULE_NAME).dts
DTS_TEMP_FNAME = .$(MODULE_NAME).dtb.dts.tmp
DTB_PRE_TEMP_FNAME = .$(MODULE_NAME).dtb.d.pre.tmp
DTB_FNAME = $(MODULE_NAME).dtb

DTC ?= dtc
DTC_FLAGS ?=

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

dtb:
	$(CPP) -E -Wp,-MMD,$(PWD)/$(DTB_PRE_TEMP_FNAME) \
	       -undef -D__DTS__ -x assembler-with-cpp -nostdinc \
	       -I$(KSRC)/scripts/dtc/include-prefixes \
	       -I$(KSRC)/arch/$(ARCH)/boot/dts \
	       -o $(PWD)/$(DTS_TEMP_FNAME) \
	       $(PWD)/$(DTS_FNAME)

	$(DTC) -o $(PWD)/$(DTB_FNAME) -O dtb -b 0 \
	       -i$(KSRC)/arch/$(ARCH)/boot/dts \
	       -i$(KSRC)/scripts/dtc/include-prefixes \
	       -Wno-interrupt_provider -Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size \
	       -Wno-alias_paths -Wno-graph_child_address -Wno-simple_bus_reg -Wno-unique_unit_address \
	       $(DTC_FLAGS) $(PWD)/$(DTS_TEMP_FNAME)

	$(RM) $(PWD)/$(DTS_TEMP_FNAME)
	$(RM) $(PWD)/$(DTB_PRE_TEMP_FNAME)

clean:
	$(RM) $(PWD)/*.o
	$(RM) $(PWD)/*.ko
	$(RM) $(PWD)/*.order
	$(RM) $(PWD)/*.symvers
	$(RM) $(PWD)/*.mod*
	$(RM) $(PWD)/.mod*
	$(RM) $(PWD)/.Mod*
	$(RM) $(PWD)/.$(MODULE_NAME)*
	$(RM) $(PWD)/*.dtb
