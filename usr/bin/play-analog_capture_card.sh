#!/usr/bin/env bash

# defaut target device
DEVICE="/dev/video0"

# Default target source
TARGET_INPUT="0"

# additional mpv options
MPV_ADD_OPTION=''

echo "Setting up device"
if [ -e /tmp/v4l2-setup ]; then
    echo "Warning: It appears to have already been set up. Skipping"
else
    v4l2-ctl -d ${DEVICE} --set-standard=ntsc --set-fmt-video=width=720,height=480,pixelformat=UYVY --set-parm=30000/1001
    v4l2-ctl -d ${DEVICE}  -i ${TARGET_INPUT}
    touch /tmp/v4l2-setup
fi

echo "Starting playback"
mpv av://v4l2:${DEVICE} \
    --no-cache \
    --profile=low-latency \
    --untimed \
    ${MPV_ADD_OPTION}

exit 0
