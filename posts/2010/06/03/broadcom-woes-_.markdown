---
comments: true
date: 2010-06-03 17:17:20
layout: post
slug: broadcom-woes-_
title: Broadcom woes >_<
wordpressid: 54
---

Using 2.6.33-zen2 and b43 in pio mode, I tested my Broadcom wireless card yesterday, and it locked up after some data transfer (on a ssh session from my Pocket PC ). Thus, I spent the day hacking around on the chip, first using several b43-firmware versions, even [openfwwf](http://www.ing.unibs.it/openfwwf/) . I tried broadcom-sta first, and I couldn't even get iwconfig to work :'( Then I went for ndiswrapper, and it was a PITA searching for a windows XP driver. Even then, ndiswrapper worked in managed mode only, wtf ! As a last resort, I tried using 2.6.35-rc1 from sys-kernel/git-sources (I had read that a lot of work was done on b43 there), but even then using b43 in pio mode locked up the card after some time, and dma caused controller restart periodically. So my wifi is currently totally borked, and I'm keeping my fingers crossed for a fix soon :-(
