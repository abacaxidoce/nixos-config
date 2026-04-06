#!/bin/sh

echo '{"version":1}'
echo '['
echo '[]'

iface="wlp0s20f3"
count=0

prev_bt_status=""
prev_wifi_status=""
prev_bat_low=false

while :; do

    # --- CPU ---
    read -r _ u n s i io ir q fi st g gn < /proc/stat
    total=$((u + n + s + i + io + ir + q + fi + st))
    idle=$((i + io))
    
    if [[ -z "$prev_total" ]]; then 
        cpu=0
    else
        diff_total=$((total - prev_total))
        diff_idle=$((idle - prev_idle))
        cpu=$((100 * (diff_total - diff_idle) / diff_total))
    fi
    prev_total=$total; prev_idle=$idle
    cpu_info="<span color='#949494'>CPU/</span><span color='#abe9b3'>$cpu%</span>"


    # --- RAM ---
    while read -r name value _; do
        case "$name" in
            MemTotal:) t_kb=$value ;;
            MemAvailable:) a_kb=$value ;;
        esac
    done < /proc/meminfo
    u_mb=$(((t_kb - a_kb) / 1024))
    ram_info="<span color='#949494'>RAM/</span><span color='#abe9b3'>$((u_mb / 1024)).$(( (u_mb * 10 / 1024) % 10 ))G</span>"


    # --- MICROPHONE ---
    mic_raw=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null || echo "0.00")
    if [[ "$mic_raw" == *"[MUTED]"* ]]; then
        mic_info="<span color='#949494'>MIC:</span> <span color='#f28fad'>OFF</span>"
    else
        mic_info="<span color='#949494'>MIC:</span> <span color='#abe9b3'>ON</span>"
    fi


    # --- BLUETOOTH & VOLUME ---
    if (( count % 5 == 0 )); then
        bt_full=$(bluetoothctl info 2>/dev/null)
        if [[ "$bt_full" == *"Connected: yes"* ]]; then
            bt_name=${bt_full##*Alias: }
            bt_name=${bt_name%%$'\n'*}
            
            [[ "$prev_bt_status" != "on" ]] && notify-send "Bluetooth" "Connected: $bt_name" -i bluetooth
            prev_bt_status="on"; bt_icon="<span color='#949494'>BLT:</span>"
        else
            [[ "$prev_bt_status" == "on" ]] && notify-send "Bluetooth" "Disconnected" -i bluetooth
            prev_bt_status="off"; bt_icon="<span color='#949494'>VOL:</span>"
        fi
    fi

    vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null || echo "0.00")
    vol_val=${vol_raw//Volume: /}
    vol_val=${vol_val// [MUTED]/}
    
    if [[ "$vol_val" == "1.00" ]]; then 
        vol="100"
    else
        vol=${vol_val#0.}
        vol=${vol#0}
        [[ -z "$vol" ]] && vol="0"
    fi
    [[ "$vol_raw" == *"[MUTED]"* ]] && vol_info="<span color='#f28fad'>MUTE</span>" || vol_info="$bt_icon <span color='#abe9b3'>$vol%</span>"


    # --- WIFI ---
    if (( count % 5 == 0 )); then
        wifi=$(nmcli -t -f DEVICE,NAME connection show --active | grep "$iface" | cut -d: -f2)
        if [[ "$wifi" != "$prev_wifi_status" ]]; then
            [[ -z "$wifi" ]] && notify-send "WiFi" "Disconnected" -u critical || notify-send "WiFi" "Connected: $wifi"
            prev_wifi_status="$wifi"
        fi
        [[ -z "$wifi" ]] && wifi_info="<span color='#949494'>WIFI:</span> <span color='#f28fad'>OFF</span>" || wifi_info="<span color='#949494'>WIFI:</span> <span color='#abe9b3'>ON</span>"
    fi


    # --- BATTERY ---
    if [[ -d /sys/class/power_supply/BAT0 ]]; then
        read -r bat < /sys/class/power_supply/BAT0/capacity
        read -r status < /sys/class/power_supply/BAT0/status
        
        if (( bat <= 40 )) && [[ "$status" == "Discharging" ]]; then
            if [[ "$prev_bat_low" == false ]]; then
                notify-send "Battery" "Low battery: $bat%" -u critical
                prev_bat_low=true
            fi
            bat_info="<span color='#949494'>BAT:</span> <span color='#f28fad'>[$bat%]</span>"
        else
            (( bat > 40 )) && prev_bat_low=false
            [[ "$status" != "Discharging" ]] && bat_info="<span color='#949494'>BAT:</span> <span color='#abe9b3'>Charged</span>" || bat_info="<span color='#949494'>BAT:</span> <span color='#fae3b0'>[$bat%]</span>"
        fi
    else
        bat_info="<span color='#f28fad'>BAT: NOT FOUND</span>"
    fi


    # --- CLOCK ---
    date_info="<span color='#BDBDBD'>$(date '+%d/%m %H:%M')</span>"
    

    # --- JSON OUTPUT ---
    echo -n ","
    jq -nc \
       --arg cpu " $cpu_info " \
       --arg ram " $ram_info " \
       --arg mic " $mic_info" \
       --arg vol "$vol_info " \
       --arg wifi " $wifi_info " \
       --arg bat " $bat_info " \
       --arg date " $date_info " \
       '[
           {full_text: $cpu, markup: "pango"},
           {full_text: $ram, markup: "pango"},
           {full_text: $mic, markup: "pango"},
           {full_text: $vol, markup: "pango"},
           {full_text: $wifi, markup: "pango"},
           {full_text: $bat, markup: "pango"},
           {full_text: $date, markup: "pango"}
       ]'


    count=$((count + 1))
    sleep 2
done
