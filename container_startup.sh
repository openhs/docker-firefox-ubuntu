#!/bin/bash

# container_startup.sh
#
# Startup script for the container.
#
# Project: docker-firefox-ubuntu
# License: GNU GPLv3
#
# Copyright (C) 2015 - 2016 Robert Cernansky



if [ "-h" == "${1}" ] || [ "--help" == "${1}" ]; then
    cat <<EOF
Usage:
  docker -e DISPLAY=\${DISPLAY} [-e NVIDIA_DRIVER_VERSION=<host_driver_version>] [--device /dev/<gpu_device> [...]] [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v \${XAUTHORITY}:${HOST_XAUTHORITY}:ro openhs/firefox-ubuntu [param [...]]

  Devices for nVidia GPU with proprietary driver:
    /dev/nvidiactl, /dev/nvidia0

  Devices for an Alsa sound card:
    /dev/snd
  or (required minimum for sound card 0)
    /dev/snd/controlC0, /dev/snd/pcmC0D0p
EOF
  exit 0
fi

/opt/docker-ubuntu-nvidia_startup.sh /usr/bin/firefox --no-remote "${@}"
