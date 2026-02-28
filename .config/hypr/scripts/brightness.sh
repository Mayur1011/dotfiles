#!/bin/bash

get_brightness() {
    brightness=$(brightnessctl get)
    max_brightness=$(brightnessctl max)
    value_scaled=$(printf "%.0f" "$(echo "$brightness / $max_brightness * 100" | bc -l)")
    echo "$value_scaled %"
}

notify_user() {
    notify-send -e -h int:value:"$(get_brightness | sed 's/%//')" -h string:x-canonical-private-synchronous:brightness_notif -u low "Brightness: $(get_brightness)"
}

inc_brightness() {
    brightnessctl set 5%+ && notify_user
}

dec_brightness() {
    brightnessctl set 5%- && notify_user
}

if [[ "$1" == "--inc" ]]; then
    inc_brightness
elif [[ "$1" == "--dec" ]]; then
    dec_brightness
fi
