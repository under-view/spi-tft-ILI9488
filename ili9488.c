// SPDX-License-Identifier: GPL-2.0

#include <linux/init.h>
#include <linux/module.h>
#include <linux/spi/spi.h>

#define SPI_BUS_NUM 0
#define SPI_SLAVE_SELECT_NUM 0

static struct spi_board_info ili9488_device_info = {
	.modalias      = "underview-tft-spi-ili9488-driver", /* Driver Identifier */
	.max_speed_hz  = 32000000,                           /* speed your device (slave) can handle */
	.bus_num       = SPI_BUS_NUM,                        /* SPI: 0 */
	.chip_select   = SPI_SLAVE_SELECT_NUM,               /* CS/SS: 0 */
	.mode          = SPI_MODE_0,                         /* SPI MODE 0 CPOL (Clock Polarity) -> low & CPHA (Clock Phase) -> low */
	.platform_data = NULL,                               /* No spi_driver specific config */
};


static int ili9488_probe(struct spi_device *spidev)
{
	struct spi_master *master = NULL;
	struct spi_device *slave = NULL;
	struct device *device = NULL;
	int ret;

	device = &spidev->dev;

	master = devm_spi_alloc_slave(device, sizeof(*master));
	if (!master) {
		dev_err(device, "devm_spi_alloc_slave: master allocation failed\n");
		return -ENOMEM;
	}

	slave = spi_new_device(master, &ili9488_device_info);
	if (!slave) {
		dev_err(device, "spi_new_device: failed to create slave");
		return -ENODEV;
	}

	ret = spi_setup(slave);
	if (ret < 0) {
		dev_err(device, "spi_setup: failed to setup slave");
		return ret;
	}

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
