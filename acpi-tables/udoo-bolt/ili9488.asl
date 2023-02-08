/*
 * Adds support for RESET and DC/RS Pins on the UDOO Bolt
 * for ili9488 based TFT 3.5" LCD. Configured to work
 * with UDOO Bolt Embedded Controller Pins 13 & 15.
 *
 *
 * Original Table Headers: ili9488 TFT 3.5" LCD Table
 *	Generated AML File	"ili9488.aml"
 *	Table Signature		"SSDT"    (Secondary System Descriptor Table)
 *	Compliance Revision     "5"       (2+ enables 64-bit arithmetic & determines size of ASL integer)
 *	OEM ID			""        (Original Equipment Manufacturer ID)
 *	OEM Table ID            "ILI9488" (Original Equipment Manufacturer Table ID)
 *	OEM Revision            "1"       (Original Equipment Manufacturer Revision)
 */
DefinitionBlock ("ili9488.aml", "SSDT", 5, "", "ILI9488", 0x1)
{
	Device (TFTD)
	{
		Name (DESC, "ili9488 Driver Chip Based TFT LCD Scope")
		Name (_ADR, 1)
		Name (_CID, Package() {
			"ili9488",
			"ILI9488",
		})
	}
}
