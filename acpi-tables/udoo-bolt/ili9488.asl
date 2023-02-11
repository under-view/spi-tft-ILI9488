/*
 * Adds support for RESET and DC/RS Pins on the UDOO Bolt
 * for ili9488 based TFT 3.5" LCD. Configured to work
 * with UDOO Bolt Embedded Controller MEC1705.
 * pins:
 *
 *   pin name           pin number         TFT display pin name
 *   ----------------------------------------------------------
 *   GPIO_SPI_CS           2                    CS
 *   GPIO_SPI_MISO         1                    Not Connected
 *   GPIO_SPI_MOSI         3                    SDI (MOSI)
 *   GPIO_SPI_CLK          4                    SCK
 *   GPIO_KSO0             13                   DC/RS
 *   GPIO_KSO1             15                   Reset
 *
 * Original Table Headers: ili9488 TFT 3.5" LCD Table
 *      Generated AML File          "ili9488.aml"
 *      Table Signature             "SSDT"        (Secondary System Descriptor Table)
 *      Compliance Revision         "5"           (2+ enables 64-bit arithmetic & determines size of ASL integer)
 *      OEM ID                      ""            (Original Equipment Manufacturer ID)
 *      OEM Table ID                "ILI9488"     (Original Equipment Manufacturer Table ID)
 *      OEM Revision                "1"           (Original Equipment Manufacturer Revision)
 */
DefinitionBlock ("ili9488.aml", "SSDT", 5, "", "ILI9488", 0x1)
{
	External(\_SB.PCI0, DeviceObj)

	Scope (\_SB.PCI0)
	{
		Device (TFTD)
		{
			Name (DESC, "ili9488 Driver Chip Based TFT LCD ACPI Device Scope")
			Name (_ADR, Zero)           // Device address on parent bus. This bus is SPI so no address.
			Name (_CID, Package() {     // Compatible ID (Array of ASL objects. These Objects being strings.)
				"ILI9488",
				"ili9488",
			})
			Name (_CRS, ResourceTemplate() { // Current Resource Settings (ACPI Resource to Buffer function)
				SpiSerialBus(
					0,                    // Chip Select
					PolarityLow,          // Chip Select is Active Low
					FourWireMode,         // Full Duplex Mode (MISO Unused)
					8,                    // 8-bits per word (1 byte)
					ControllerInitiated,  // Slave Mode
					32000000,             // 32 MHz
					ClockPolarityLow,     // SPI Mode 0
					ClockPhaseFirst,      // SPI Mode 0
					"\\_SB.PCI0.SPI1",    // SPI bus host controller name (unconfirmed)
					0                     // Resource Index. Should be 0
				)
				// _SB.GPIO: GPIO bus host controller (unconfirmed)
				GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly, "\\_SB.GPI0", 0, ResourceConsumer, , ) { 13 }
				GpioIo (Exclusive, PullUp,   0, 0, IoRestrictionOutputOnly, "\\_SB.GPI0", 0, ResourceConsumer, , ) { 15 }
			})
			// https://docs.kernel.org/firmware-guide/acpi/gpio-properties.html
			Name (_DSD, Package() {
				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), // Not actual
				Package()
				{
					// Label Pins: <Device Reference>, <index in _CRS Buff>, <pin index GpioIO Resource>, <GPIO line status>
					Package() { "dc-rs-pin", Package() { ^TFTD, 1, 0, 0 } },
					Package() { "reset-pin", Package() { ^TFTD, 2, 0, 0 } }
				}
			})
		}
	}
}
