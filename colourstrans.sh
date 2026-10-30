#!/system/bin/sh

RED_LED="/sys/class/leds/red/brightness"
GREEN_LED="/sys/class/leds/green/brightness"
BLUE_LED="/sys/class/leds/blue/brightness"
red=(255 255 255 91)
green=(94 255 94 172)
blue=(192 255 192 255)
golR=
golG=
golB=

set_rgb() {
    echo "$1" > "$RED_LED"
    echo "$2" > "$GREEN_LED"
    echo "$3" > "$BLUE_LED"
}

lessormorecalcR() {
    for i in "${red[@]}"; do
        if [ $((${red[@]} - ${red[-1]})) -le -1 ];  then  golR=L
        elif [ $((${red[@]} - ${red[-1]})) -ge 1 ];  then golR=G
    fi
done 
}

lessormoreR() {
    if  golR=L;  then echo "(($1 - i))"
    elif golR=G;  then echo "(($1 + i))"
fi 
}

Rstopper() {
    if [ "$1" -gt "${red[*]}" ]; then echo "${red[@]}"; 
    elif [ "$1" -lt "${red[*]}" ]; then echo "${red[@]}"; 
    else echo "$1"
fi
}

lessormorecalcG() {
    for i in "${green[@]}"; do
if [ $(( ${green[@]} - ${green[-1]})) -le -1 ];  then  golG=L
elif [ $((${green[@]} - ${green[-1]})) -ge 1 ];  then golG=G
fi
done }

lessormoreG() {
if  golG=L;  then echo "(($1 - i))"
elif golG=G;  then echo "(($1 + i))"
fi }

Gstopper() {
    if [ "$1" -gt "${green[*]}" ]; then echo "${green[@]}"; 
    elif [ "$1" -lt "${green[*]}" ]; then echo "${green[@]}"; 
    else echo "$1"
    fi
}

 lessormorecalcB() {
    for i in "${blue[@]}"; do
if [ $((${blue[@]} - ${blue[-1]})) -le -1 ];  then  golB=L
elif [ $((${blue[@]} - ${blue[-1]})) -ge 1 ];  then golB=G
fi
done }

lessormoreB() {
    if  golB=L;  then echo "(($1 - i))"
   elif golB=G;  then echo "(($1 + i))"
fi }

Bstopper() {
    if [ "$1" -gt "${blue[*]}" ]; then echo "${blue[@]}"; 
    elif [ "$1" -lt "${blue[*]}" ]; then echo "${blue[@]}"; 
    else echo "$1"
    fi
}


clamp() {
    if [ "$1" -lt 0 ]; then echo 0
    elif [ "$1" -gt 255 ]; then echo 255
    else echo "$1"
    fi
}

# light blue 91 172 255

# pink 255 94 192

# white 255 255 255

while true; do
    lessormorecalcR
    lessormorecalcG
    lessormorecalcB
        for i in $(seq 0 5 255); do
            set_rgb "$(Rstopper "$(lessormoreR $(()))")" "$(Gstopper "$(lessormoreG $(()))")" "$(Bstopper "$(lessormoreR $(()))")"
            sleep 0.005
        done
done 
