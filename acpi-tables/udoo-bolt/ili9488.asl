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
 *   GPIO_KSO0             13                   DC/RS (Data Command)
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
	Device (TFTD)
	{
		Name (_HID, "ILI9488")  // _HID: Hardware ID
		Name (_CID, "ILI9488")  // _CID: Compatible ID
		Name (_UID, One)        // _UID: Unique ID

		Name (_DSD, Package() { // Device Specific Data - used to return EC static resources (Defined in _CRS) to the driver.
			/*
			 * Known as the Device Properties UUID
			 * A generic UUID recognized by the ACPI subsystem in the Linux kernel which automatically
			 * processes the data packages associated with it and makes data available to device driver
			 * as "device properties".
			 */
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package()
			{
				// Define compatible property (Not actually used CONFIG_OF not set)
				Package () { "compatible", Package () { "garosa,garosanvkr25fawd" } },
				Package () { "size", 1024 },
				Package () { "pagesize", 32 },
				Package () { "address-width", 16 },
			}
		})

		Method (_CRS, 0, Serialized) {
			local0 = ResourceTemplate() { // Current Resource Settings (ACPI Resource to Buffer function)
				SpiSerialBus(
					0,                    // Chip Select
					PolarityLow,          // Chip Select is Active Low
					FourWireMode,         // Full Duplex Mode (MISO Unused)
					8,                    // 8-bits per word (1 byte)
					ControllerInitiated,  // Slave Mode
					32000000,             // 32 MHz
					ClockPolarityLow,     // SPI Mode 0
					ClockPhaseFirst,      // SPI Mode 0
					"\\EC17.SPI0",        // SPI bus host controller name (unconfirmed)
					0                     // Resource Index. Should be 0
				)
				// _SB.GPIO: GPIO bus host controller (unconfirmed)
				GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly, "\\_SB.GPI0", 0, ResourceConsumer, , ) { 40 } // Pin 13
				GpioIo (Exclusive, PullUp,   0, 0, IoRestrictionOutputOnly, "\\_SB.GPI0", 0, ResourceConsumer, , ) { 45 } // Pin 15
			}
			Return(local0)
		}
	}
}
