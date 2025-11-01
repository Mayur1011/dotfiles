#!/bin/bash

get_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        value_scaled=0
        echo "Muted"
    else
        value=$(echo "$volume" | grep -oP '\d+\.\d+')
        value_scaled=$(printf "%.0f" "$(echo "$value * 100" | bc -l)")
        echo "$value_scaled %"
    fi
}

notify_user() {
    if [[ "$(get_volume)" == "Muted" ]]; then
        notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low "Volume: Muted"
    else
        notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low "Volume: $(get_volume)"
    fi
}

inc_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        toggle_mute
    else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify_user
    fi
}

dec_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        toggle_mute
    else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_user
    fi
}

toggle_mute() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -e -u low "Volume: Switched ON"
    else
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -e -u low "Volume: Muted"
    fi
}

toggle_mic() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send -e -u low "Microphone: Switched ON"
    else
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send -e -u low "Microphone: Muted"
    fi
}

get_mic_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ "$volume" == *"MUTED"* ]]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

notify_mic_user() {
    volume=$(get_mic_volume)
    notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low "Mic Level: $volume"
}

inc_mic_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        toggle_mic
    else
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+ && notify_user
    fi
}

dec_mic_volume() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ "$volume" == *"[MUTED]"* ]]; then
        toggle_mic
    else
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%- && notify_user
    fi
}


if [[ "$1" == "--get" ]]; then
    get_volume
elif [[ "$1" == "--inc" ]]; then
    inc_volume
elif [[ "$1" == "--dec" ]]; then
    dec_volume
elif [[ "$1" == "--toggle" ]]; then
    toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
    toggle_mic
elif [[ "$1" == "--mic-inc" ]]; then
    inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
    dec_mic_volume
else
    get_volume
fi
