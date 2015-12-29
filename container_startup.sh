#!/bin/bash

# container_startup.sh
#
# Startup script for the container.
#
# Project: docker-firefox-ubuntu
# License: GNU GPLv3
#
# Copyright (C) 2015 Robert Cernansky



USER=firefox



if [ "-h" == "$1" ] || [ "--help" == "$1" ]; then
    cat <<EOF
Usage:
  docker -e DISPLAY=\${DISPLAY} -e NVIDIA_DRIVER_VERSION=<host_driver_version> [--device /dev/<gpu_device> [...]] [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v \${XAUTHORITY}:${HOST_XAUTHORITY}:ro

  Devices for nVidia GPU with proprietary driver:
    /dev/nvidiactl, /dev/nvidia0

  Devices for an Alsa sound card:
    /dev/snd
  or
    /dev/snd/controlC0, /dev/snd/pcmC0D0p
EOF
  exit 0
fi

echo "ensuring nVidia driver is installed"
/opt/select_nvidia_driver.sh

echo "adding authorization token for X server"
/opt/setup_access_to_host_display.sh ${USER}

echo "ensuring that the user is in the video group"
/opt/add_user_to_video_group.sh ${USER}

if ls /dev/snd/pcm* > /dev/null 2>&1; then
    echo "ensuring that the user is in the audio group"

    audioGroupId=$(stat -c %g /dev/snd/pcm* | head -n 1)
    if ! grep -q :${audioGroupId}: /etc/group; then
        groupadd --gid ${audioGroupId} audio_${USER}
    fi
    audioGroup=$(stat -c %G /dev/snd/pcm* | head -n 1)
    if ! id -G ${USER} | grep -qw ${audioGroupId}; then
        usermod -a -G ${audioGroupId} ${USER}
    fi
fi

echo "starting firefox"
su - --shell /bin/sh --command "/usr/bin/firefox --no-remote" ${USER}
