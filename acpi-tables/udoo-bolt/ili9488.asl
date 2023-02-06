/*
 * Adds support for RESET and DC/RS Pins on the
 * ili9488 based TFT 3.5" LCD. Configured to work
 * with UDOO Bolt Embedded Controller Pins 13 & 15.
 *
 *
 *
 * ili9488 TFT 3.5" LCD Table
 * 1. Name of AML file to generate
 * 2. Table Signature - secondary system descriptor table
 * 3. Compliance Revision - 2+ enables 64-bit arithmetic
 * 4. OEMID
 * 5. Table Identifier
 * 6. OEM Revision Number 
 */
DefinitionBlock ("ili9488.aml", "SSDT", 5, "", "ILI9488", 1)
{
	Name (OBJ1, 0x1234)
	Name (OBJ2, "HELLO WORLD")
}
