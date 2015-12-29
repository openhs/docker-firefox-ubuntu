# Dockerfile
#
# Project: docker-firefox-ubuntu
# License: GNU GPLv3
#
# Copyright (C) 2015 Robert Cernansky



FROM openhs/ubuntu-nvidia



MAINTAINER openhs
LABEL version = "0.2.0" \
      description = "Firefox with Flash and nVidia graphics driver."



RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    firefox \
    flashplugin-installer \
    unzip \
    ca-certificates

# IDs of Firefox addons which shall be installed (NoScript Security Suite, CS Lite Mod, Disconnect, Proxy Switcher)
ARG addons="722 327795 464050 654096"

RUN useradd --shell /bin/false --create-home firefox && \

    profile=docker.default && \
    addonsDir=/home/firefox/.mozilla/firefox/${profile}/extensions && \

    mkdir -p ${addonsDir} && \

    /bin/echo -e \
      "[General]\n\
       StartWithLastProfile=1\n\
       \n\
       [Profile0]\n\
       Name=default\n\
       IsRelative=1\n\
       Path=${profile}\n\
       Default=1" >> /home/firefox/.mozilla/firefox/profiles.ini && \
   
    getAddon() { \
      wget https://addons.mozilla.org/firefox/downloads/latest/${1}/addon-${1}-latest.xpi; \
    } && \

    addonId() { \
      unzip -p ${1} install.rdf | grep -m 1 -e em:id | sed 's/<\/\?em:id>//g' | tr -d '[:blank:]'; \
    } && \

    for addonNum in $addons; do \
      getAddon ${addonNum} && \
      mv addon-${addonNum}-latest.xpi ${addonsDir}/$(addonId addon-${addonNum}-latest.xpi).xpi; \
    done && \
    chown -R firefox:firefox /home/firefox/.mozilla

COPY container_startup.sh /opt/container_startup.sh
RUN chmod +x /opt/container_startup.sh

ENTRYPOINT ["/opt/container_startup.sh"]
