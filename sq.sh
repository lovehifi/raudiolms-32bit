#!/bin/bash

# Extract the card number from rAudio
card=$(grep -oP '(?<=defaults.pcm.card ).*' /etc/asound.conf)
echo "Card number: $card"

/opt/sq/squeezelite32 -o hw:$card -n SQ32-rAudio -s 127.0.0.1 -m 00:00:00:00:00:00 -a 4096:4

