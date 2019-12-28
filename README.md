# docker-firefox-ubuntu

Firefox with Flash and some privacy addons.



## Usage

Start firefox like this:

    $ docker run --name firefox -e DISPLAY=$DISPLAY --device /dev/snd/controlC0 \
      --device /dev/snd/pcmC0D0p --device /dev/snd/timer \
      -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTHORITY:/tmp/.host_Xauthority:ro \
      -dti openhs/firefox-ubuntu

and run it again, after it was closed:

    $ docker start firefox

Following plugins are pre-installed: NoScript Security Suite, Cookie AutoDelete, Disconnect, Foxy Proxy
# Standard.  They have to be enabled manually in the standard Add-ons management page in Firefox.
