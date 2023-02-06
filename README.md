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
```sh
$ source openembedded-core/oe-init-build-env $(pwd)/build
$ bitbake ili9488
```

Or you can

```sh
# cd into working directory + git folder
# May look something like bellow
$ cd tmp/work/udoo_bolt_emmc-northstar-linux/ili9488/0.0.1-git+b9d43fbe2a6a05a29bfa13d244a8573a3ade20c3-r0/git
$ ../temp/run.do_compile
```

**Compile DTS/ASL**
```sh
# Compile Device Tree Source to Device Tree Blob
$ KSRC="/usr/src/kernel" make dtb

# Compile ACPI Source Language to ACPI Machine Language
$ make aml
```
