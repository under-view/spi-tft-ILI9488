// SPDX-License-Identifier: GPL-2.0

#include <linux/init.h>
#include <linux/module.h>
#include <linux/spi/spi.h>

static int ili9488_probe(struct spi_device *spidev)
{
	return 0;
}


static void ili9488_remove(struct spi_device *spidev)
{
	return;
}

/* Driver declaration */
static struct spi_driver ili9488_driver = {
	.driver = {
		.name = "ili9488",
		.owner = THIS_MODULE,
	},
	.probe = ili9488_probe,
	.remove = ili9488_remove,
};

module_spi_driver(ili9488_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Underview");
