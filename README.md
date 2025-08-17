# SPI TFT ILI9488

Out Of Tree DRM Driver for ILI9488 Driver Chip Based TFT 3.5" 480x320 LCDs that utilize the SPI protocol.

**NOTE:** There is already a kernel driver that was being moved upstream
[by Kamlesh Gurudasani](https://lore.kernel.org/all/cover.1592055494.git.kamlesh.gurudasani@gmail.com/T/#t).

This is just my implementation.

### Setup

```sh
$ export KSRC="/lib/modules/$(uname -r)/build"
```

### Building

**Compile Kernel Module**

```sh
$ make -j $(nproc)
```

**Compile DTS/ASL**

```sh
# Compile Device Tree Source to Device Tree Blob
$ make dtb

# Compile ACPI Source Language to ACPI Machine Language
$ make aml
```

**Testing AML file**

```sh
# First Gather, Extract, & Disassemble ACPI Tables
$ acpidump > acpi.log
$ acpixtract acpi.log

# To get source of all DSDT/SSDT
$ iasl -d *.dat > /dev/null 2>&1

# Execute
$ acpiexec *.{dat,aml}
```

SSDT overlays: Run-time ConfigFS approach

```sh
# If desire alias for loading and unloading ACPI SSDT
$ source devutils/compile-load-alias

# Mount ConfigFS
$ mount -t configfs none /sys/kernel/config

# Load ACPI ConfigFS support (if it’s a module)
$ modprobe acpi-configfs

# Load SSDT
$ mkdir -p /sys/kernel/config/acpi/table/ili9488
$ cat "ili9488.aml" > "/sys/kernel/config/acpi/table/ili9488/aml"
# OR
$ load_ili9488_aml

# Unload SSDT
$ ./devutils/unload-acpi-table /sys/kernel/config/acpi/table/ili9488
# OR
$ unload_ili9488_aml
```
