#!/bin/bash

DEVUTILS_DIR=$(dirname "${BASH_SOURCE[0]}")

alias compile_ili9488_aml="make -C ${DEVUTILS_DIR}/../ aml"
alias load_ili9488_aml="mkdir -p /sys/kernel/config/acpi/table/ili9488; cat ${DEVUTILS_DIR}/../ili9488.aml > /sys/kernel/config/acpi/table/ili9488/aml"
alias unload_ili9488_aml="${DEVUTILS_DIR}/unload-acpi-table /sys/kernel/config/acpi/table/ili9488"
