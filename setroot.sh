#!/bin/bash
while true;do

    ram=$(free -h | awk '{print $3}' | grep "i")
    ladowanie1=$(cat /sys/class/power_supply/BAT0/status)
    dzwiek=$(amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]')
    capture=$(amixer get Capture | grep 'Left:' | awk '$0~/%/{print $5}' | tr -d '[]')
    cpu=$(sensors | grep -oP '(?<=CPU).*?(?=C)')
    bateria=$(cat /sys/class/power_supply/BAT0/capacity)
    jasnosc=$(brightnessctl | grep   '('  | cut -d\   -f4)

    #czy się ładuje
    if [ $ladowanie1 == "Discharging" ];then
        icon2=""
    else
        icon2=""
    fi

    # % baterii
    if (($bateria > 75));then   #4/4
        icon1=""
    elif (($bateria > 50));then #3/4
        icon1=""
    elif (($bateria > 25));then #2/4
        icon1=""
    elif (($bateria > 10));then #1/4
        icon1=""
    else                                     #0/4
        icon1=""
    fi

    #czy jest mut na master audio 
    if [ $(amixer get Master | grep % | cut -d\   -f8) == "[off]" ];then
        icon3=""
    else
        icon3=""
    fi

    #czy jest mut na mikrofon
    if [ $(amixer get Capture | grep -m 1 % | cut -d\   -f9) == "[off]" ];then
        icon4=""
    else
        icon4=""
    fi

    xsetroot -name "$( date +"|%H:%M %d-%m-%y|") $icon4$capture $icon3$dzwiek ${jasnosc:1:-1} ${cpu:12}C $ram $icon2$icon1$bateria%"
    sleep 2
done
## ☀
## 🌣🔈
# ladowanie 
# rox ladowanie 
# bateria 4/4 
# bateria 3/4 
# bateria 2/4 
# bateria 1/4 
# bateria 0/4 
#cpu 
#ram 
#dzwiek 
#mute 

#mic 
#mute 
