// SPDX-License-Identifier: GPL-2.0

#include <linux/backlight.h>
#include <linux/delay.h>
#include <linux/gpio/consumer.h>
#include <linux/module.h>
#include <linux/property.h>
#include <linux/spi/spi.h>

#include <video/mipi_display.h>

#include <drm/drm_atomic_helper.h>
#include <drm/drm_drv.h>
#include <drm/drm_fb_helper.h>
#include <drm/drm_gem_atomic_helper.h>
#include <drm/drm_managed.h>
#include <drm/drm_mipi_dbi.h>
#include <drm/drm_modeset_helper.h>

static int ili9488_probe(struct spi_device *spidev)
{
	struct device *device;
	struct drm_device *drm;
	struct mipi_dbi *dbi; // (MIPI) Mobile Industry Processor Interface - (DPI) Display Bus Interface
	struct mipi_dbi_dev *dbidev;
	struct gpio_desc *dc;
	u32 rotation = 0;
	int ret;

	device = &spidev->dev;

	return 0;
}

static void ili9488_remove(struct spi_device *spidev)
{
	return;
}

/* Device Tree Node to be compatible with */
static const struct of_device_id ili9488_of_match[] = {
	{ .compatible = "garosa,garosanvkr25fawd" },
	{},
};

MODULE_DEVICE_TABLE(of, ili9488_of_match);

/*
 * Make compatible with ACPI SSDT via the
 * Compatible ID (_CID) name object
 */
static const struct acpi_device_id ili9488_acpi_match[] = {
	{ "ili9488", 0 },
	{ "ILI9488", 0 },
	{ }
};

MODULE_DEVICE_TABLE(acpi, ili9488_acpi_match);


static const struct spi_device_id ili9488_spi_id[] = {
	{ "ili9488", 0 },
	{ }
};

MODULE_DEVICE_TABLE(spi, ili9488_spi_id);

/* Driver declaration */
static struct spi_driver ili9488_spi_driver = {
	.driver = {
		.name = "ili9488",
		.owner = THIS_MODULE,
#ifdef ACPI_DEVICE_ENUM
		.acpi_match_table = ili9488_acpi_match,
#else
		.of_match_table = ili9488_of_match,
#endif
	},
	.id_table = ili9488_spi_id,
	.probe = ili9488_probe,
	.remove = ili9488_remove,
};

module_spi_driver(ili9488_spi_driver);


MODULE_LICENSE("GPL");
MODULE_AUTHOR("Underview");
MODULE_DESCRIPTION("Ilitek ILI9488 DRM driver");
