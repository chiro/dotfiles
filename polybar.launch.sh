#!/bin/bash

set -eu

find_power_supply() {
    local requested_type="$1"
    local device

    for device in /sys/class/power_supply/*; do
        [[ -r "${device}/type" ]] || continue
        if [[ "$(<"${device}/type")" == "${requested_type}" ]]; then
            basename "${device}"
            return 0
        fi
    done
    return 1
}

find_backlight() {
    local device

    for device in /sys/class/backlight/*; do
        [[ -d "${device}" ]] || continue
        basename "${device}"
        return 0
    done
    return 1
}

POLYBAR_BATTERY="${POLYBAR_BATTERY:-$(find_power_supply Battery || true)}"
POLYBAR_ADAPTER="${POLYBAR_ADAPTER:-$(find_power_supply Mains || true)}"
POLYBAR_BACKLIGHT="${POLYBAR_BACKLIGHT:-$(find_backlight || true)}"

polybar_modules_right=()
[[ -n "${POLYBAR_BATTERY}" && -n "${POLYBAR_ADAPTER}" ]] \
    && polybar_modules_right+=(battery)
polybar_modules_right+=(filesystem)
[[ -n "${POLYBAR_BACKLIGHT}" ]] && polybar_modules_right+=(backlight)
polybar_modules_right+=(pulseaudio memory cpu wlan eth date systray)
POLYBAR_MODULES_RIGHT="${polybar_modules_right[*]}"

export POLYBAR_ADAPTER POLYBAR_BACKLIGHT POLYBAR_BATTERY POLYBAR_MODULES_RIGHT

if [[ "${1:-}" == "--print-env" ]]; then
    printf 'POLYBAR_BATTERY=%s\n' "${POLYBAR_BATTERY}"
    printf 'POLYBAR_ADAPTER=%s\n' "${POLYBAR_ADAPTER}"
    printf 'POLYBAR_BACKLIGHT=%s\n' "${POLYBAR_BACKLIGHT}"
    printf 'POLYBAR_MODULES_RIGHT=%s\n' "${POLYBAR_MODULES_RIGHT}"
    exit 0
fi

exec polybar main
