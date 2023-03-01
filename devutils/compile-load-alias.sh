#!/bin/bash

ILI9488_DEVUTILS_DIR=$(dirname $(realpath "${BASH_SOURCE[0]}"))

alias mount_enable_acpi_configfs="mount -t configfs none /sys/kernel/config 2>/dev/null && modprobe acpi-configfs"
alias compile_ili9488_aml="make -C ${ILI9488_DEVUTILS_DIR}/../ aml"
alias load_ili9488_aml="mkdir -p /sys/kernel/config/acpi/table/ili9488; cat ${ILI9488_DEVUTILS_DIR}/../ili9488.aml > /sys/kernel/config/acpi/table/ili9488/aml"
alias unload_ili9488_aml="${ILI9488_DEVUTILS_DIR}/unload-acpi-table /sys/kernel/config/acpi/table/ili9488"
