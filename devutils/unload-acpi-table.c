/*
 * cc devutils/unload-acpi-table.c -o devutils/unload-acpi-table
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

int main(int argc, char **argv) {
	if (!argv[1] || argc > 2) {
		fprintf(stdout, "Usage Example:\n");
		fprintf(stdout, "\t%s /sys/kernel/config/acpi/table/mec1705\n", argv[0]);
		return -1;
	}

	if (rmdir(argv[1]) == -1) {
		fprintf(stdout, "[x] rmdir: %s\n", strerror(errno));
		return -1;
	}

	fprintf(stdout, "Unloaded table at %s\n", argv[1]);

	return 0;
}
