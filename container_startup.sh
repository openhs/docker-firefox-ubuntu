#!/bin/bash

# container_startup.sh
#
# Startup script for the container.
#
# Project: docker-firefox-ubuntu
# License: GNU GPLv3
#
# Copyright (C) 2015 - 2020 Robert Cernansky



if [ "-h" == "${1}" ] || [ "--help" == "${1}" ]; then
    cat <<EOF
Usage:
  docker run --shm-size=256m -e DISPLAY=\${DISPLAY} [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v \${XAUTHORITY}:${HOST_XAUTHORITY}:ro openhs/firefox-ubuntu [param [...]]

  Devices for an Alsa sound card:
    /dev/snd
  or (required minimum for sound card 0)
    /dev/snd/controlC0, /dev/snd/pcmC0D0p, /dev/snd/timer
EOF
  exit 0
fi

/opt/docker-ubuntu-x_startup.sh apulse /usr/bin/firefox --no-remote -P default "${@}"
