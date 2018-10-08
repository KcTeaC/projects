#!/bin/bash

# Common settings and programs
start_common() {
        
        # load Xresources
        xrdb -merge $_userresources

        # load custom keymaps
        xmodmap $_usermodmap

        # load fonts
        xset +fp $userfonts
        xset fp rehash

        # fix keyboard rate
        xset r rate 200 25

        # set cursor
        xsetroot -cursor_name left_ptr &

        # start the screensaver
        xscreenaaver &

}

# xmonad stuff
start_xmonad() {
        
        export LANG=en_US.UTF-8

        # load common settings and programs
        start_common

        # start compton
        compton -b &
        
        exec xmonad
}

# xfce stuff
start_xfce() {

        # load common settings and programs
        start_common
        
        exec startxfce4
}

case "$1" in
        xmonad)
                start_xmonad
                ;;
        xfce)
                start_xfce
                ;;
        *)
                echo -n "Usage: <xfce|xfce4>"
                echo -n ""
esac

