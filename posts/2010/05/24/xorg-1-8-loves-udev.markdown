---
comments: true
date: 2010-05-24 08:07:11
layout: post
slug: xorg-1-8-loves-udev
title: Xorg 1.8 loves udev
wordpressid: 35
categories: gentoo
---

I just unmasked and installed `x11-base/xorg-server-1.8.1-r1` with `sys-fs/udev-151`.



> New input hotplug and configuration system, including:
>
>   - HAL Replacement - udev support for Linux integrated, other OS'es TBD
>   - xorg.conf.d




I set up a new configuration for my ALPS GlidePoint touchpad :



```bash
+1:34% cat /etc/X11/xorg.conf.d/20-synaptics.conf
Section "InputClass"
Identifier "touchpad catchall"
MatchIsTouchpad "on"
MatchDevicePath "/dev/input/event*"
Driver "synaptics"
Option "SHMConfig" "on"
Option "TapButton1" "1"
Option "TapButton2" "3"
Option "TapButton3" "2"
Option "MaxTapTime" "180"
Option "MaxTapMove" "110"
Option "EmulateMidButtonTime" "75"
Option "MinSpeed" "0.25"
Option "MaxSpeed" "1.00"
Option "AccelFactor" "0.050"
Option "EdgeMotionMinSpeed" "200"
Option "EdgeMotionMaxSpeed" "200"
Option "VertEdgeScroll" "on"
Option "VertTwoFingerScroll" "on"
Option "VertScrollDelta" "20"
Option "HorizEdgeScroll" "on"
Option "HorizTwoFingerScroll" "on"
Option "HorizScrollDelta" "20"
Option "CircularScrolling" "on"
Option "CircScrollTrigger" "0"
Option "EmulateTwoFingerMinZ" "0"
EndSection
```


Goodbye hal, welcome udev ;-)
