#!/system/bin/sh

RED_LED="/sys/class/leds/red/brightness"
GREEN_LED="/sys/class/leds/green/brightness"
BLUE_LED="/sys/class/leds/blue/brightness"

set_rgb() {
    echo "$1" > "$RED_LED"
    echo "$2" > "$GREEN_LED"
    echo "$3" > "$BLUE_LED"
}

clamp() {
    if [ "$1" -lt 0 ]; then echo 0
    elif [ "$1" -gt 255 ]; then echo 255
    else echo "$1"
    fi
}

R1_stopper() {                        # first transition
if [ "$1" -gt 255 ]; then echo 255
else echo "$1"
fi
}

G1_stopper() {
if [ "$1" -lt 94 ]; then echo 94
else echo "$1"
fi
}

B1_stopper() {
if [ "$1" -lt 192 ]; then echo 192
else echo "$1"
fi
}

C2_stopper() {                       # second transition
if [ "$1" -gt 255 ]; then echo 255
else echo "$1"
fi
}

R3_stopper() {                       # third transition
if [ "$1" -lt 255 ]; then echo 255
else echo "$1"
fi
}

G3_stopper() {
if [ "$1" -lt 169 ]; then echo 169
else echo "$1"
fi
}

B3_stopper() {
if [ "$1" -lt 192 ]; then echo 192
fi
}

R4_stopper() {                      # fourth and last transition
if [ "$1" -lt 78 ]; then echo 76
else echo "$1"
fi
}

G4_stopper() {
if [ "$1" -gt 219 ]; then echo 219
else echo "$1"
fi
}

B4_stopper() {
if [ "$1" -gt 255 ]; then echo 255
else echo "$1"
fi
}              

# light blue 76 219 255

# pink 255 94 192

# white 255 255 255

while true; do
    for i in $(seq 0 5 255); do
        set_rgb $(R1_stopper $((76 + i))) $(G1_stopper $((219 - i))) $(B1_stopper $((255 - i)))        #light blue to pink
        sleep 0.005
    done

    for i in $(seq 0 5 255); do
        set_rgb $(C2_stopper $((255))) $(C2_stopper $((94 + i))) $(C2_stopper $((192 + i)))       # pink to white
        sleep 0.005
    done

    for i in $(seq 0 5 255); do
        set_rgb $(R3_stopper $((255))) $(R3_stopper $((255 - i))) $(R3_stopper $((255 - i)))       # white to pink
        sleep 0.005
    done

    for i in $(seq 0 5 255); do
        set_rgb $(R4_stopper $((255 - i))) $(G4_stopper $((94 + i))) $(B4_stopper $((192 + i)))       # pink to light blue
        sleep 0.005
    done
done 
