# SPI TFT ILI9488

Out Of Tree DRM Driver for ILI9488 Driver Chip Based TFT 3.5" 480x320 LCDs that utilize the SPI protocol.

**NOTE:** There is already a kernel driver that was being moved upstream
[by Kamlesh Gurudasani](https://lore.kernel.org/all/cover.1592055494.git.kamlesh.gurudasani@gmail.com/T/#t).
This is just my implementation that works with the udoo-bolt.

Development is done with kernel version 5.19.17. Utilizing the yocto project and a BitBake recipe called
[ili9488.bb](https://github.com/under-view/meta-underview/blob/master/recipes-kernel/drivers/ili9488.bb). One
can build the driver via.

### Building
**Compile Kernel Module**
```
# On target
$ KSRC="/lib/modules/$(uname -r)/build" make
```
```sh
$ source openembedded-core/oe-init-build-env $(pwd)/build
$ bitbake ili9488
```
```sh
# cd into working directory + git folder
# May look something like bellow
$ cd tmp/work/udoo_bolt_emmc-northstar-linux/ili9488/0.0.1-git+b9d43fbe2a6a05a29bfa13d244a8573a3ade20c3-r0/git
$ ../temp/run.do_compile
```

**Compile DTS/ASL**
```sh
# Compile Device Tree Source to Device Tree Blob
$ KSRC="/lib/modules/$(uname -r)/build" make dtb

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
# Mount ConfigFS
$ mount -t configfs none /sys/kernel/config

# Load ACPI ConfigFS support (if it’s a module)
$ modprobe acpi-configfs

# Allocate a new SSDT
$ mkdir -p /sys/kernel/config/acpi/table/ili9488
$ cat "ili9488.aml" > "/sys/kernel/config/acpi/table/ili9488/aml"
```
