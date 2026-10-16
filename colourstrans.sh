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
if [ "$1" -gt 245 ]; then echo 245
else echo "$1"
fi
}
G1_stopper() {
if [ "$1" -lt 169 ]; then echo 169
else echo "$1"
fi
}
B1_stopper() {
if [ "$1" -lt 184 ]; then echo 184
else echo "$1"
fi
}        
C2_stopper() {                       # second transition
if [ "$1" -gt 255 ]; then echo 255
else echo "$1"
fi
}         
R3_stopper() {                       # third transition
if [ "$1" -lt 245 ]; then echo 245
else echo "$1"
fi
}
G3_stopper() {
if [ "$1" -lt 169 ]; then echo 169
else echo "$1"
fi
}
B3_stopper() {
if [ "$1" -lt 184 ]; then echo 184
else echo "$1"
fi
}            
R4_stopper() {                      # fourth and last transition
if [ "$1" -lt 91 ]; then echo 91
else echo "$1"
fi
}
G4_stopper() {
if [ "$1" -gt 206 ]; then echo 206
else echo "$1"
fi
}
B4_stopper() {
if [ "$1" -gt 250 ]; then echo 250
else echo "$1"
fi
}              

# light blue 91 206 250

# pink 245 169 184

# white 255 255 255

while true; do
    for i in $(seq 0 1 255); do
        set_rgb $(R1_stopper $((91 + i))) $(G1_stopper $((206 - i))) $(B1_stopper $((250 - i)))        #light blue to pink
        sleep 0.5
    done

    for i in $(seq 0 1 255); do
        set_rgb $(C2_stopper $((245 + i))) $(C2_stopper $((169 + i))) $(C2_stopper $((184 + i)))       # pink to white
        sleep 0.5
    done

    for i in $(seq 0 1 255); do
        set_rgb $(R3_stopper $((255 - i))) $(R3_stopper $((255 - i))) $(R3_stopper $((255 - i)))       # white to pink
        sleep 0.5
    done

    for i in $(seq 0 1 255); do
        set_rgb $(R4_stopper $((245 - i))) $(R4_stopper $((169 + i))) $(R4_stopper $((184 + i)))       # pink to light blue
        sleep 0.5
    done
done 
