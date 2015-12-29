# docker-firefox-ubuntu

Firefox with Flash and nVidia graphics driver.



## Usage

Start firefox like this:

    $ docker run --name firefox -e DISPLAY=$DISPLAY --device /dev/snd -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v $XAUTHORITY:/tmp/.host_Xauthority:ro -dti openhs/firefox-ubuntu

and run it again, after it was closed:

    $ docker start firefox

For accelerated graphics start the container with following additional parameters: `-e NVIDIA_DRIVER_VERSION=352
--device /dev/nvidiactl --device /dev/nvidia0`.  Replace `352` in `NVIDIA_DRIVER_VERSION` with the same nVidia driver
version as on the host.

Following plugins are pre-installed: NoScript Security Suite, CS Lite Mod, Disconnect, Proxy Switcher.  They have
to be enabled in the standard Add-ons management page in Firefox.
