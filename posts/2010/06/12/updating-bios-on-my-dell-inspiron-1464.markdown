---
comments: true
date: 2010-06-12 18:39:27
layout: post
slug: updating-bios-on-my-dell-inspiron-1464
title: Updating bios on my Dell Inspiron 1464
wordpressid: 60
categories: gentoo
---

Though Dell claims to support bios updates in Linux via their [libsmbios](http://linux.dell.com/wiki/index.php/Tech/libsmbios) project, it  doesn't work with recent laptops. It is impossible to get a hdr file since the bios updates come only in a WinPhlash format, which requires a Windows installation. After digging the internet for some time, I finally came across this [post](http://www.ruzee.com/blog/2010/01/dell-studio-15-bios-update-with-linux), and this is how I upgraded my Inspiron 1464 bios from A04 to A08 :-)



	
  * Get bios from [dell support site](http://support.dell.com), in my case 1464A08_win.exe

	
  * Extract WPH bios image from the exe file by running it with wine or in a windows virtual machine
`wine 1464A08_win.exe`

	
  * Get the dell patched plash16.exe utility, the original utility from [biosman](http://www.biosman.com/bios-flash.html) doesn't work. Poke around [dell's ftp site](http://ftp.dell.com) for bios installers with DOS in the filename, and run the exe in dosbox. It will display an error but spit out the plash16.exe, requires a bit of trial and error (I used 1747A06_DOS.exe) ;-)

	
  * Create a bootable [freedos](http://www.freedos.org) usb flash drive, using the [freedos base cd](http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.0/fdbasecd.iso)

	
  * Copy the BIOS.WPH and plash16.exe files to the flash drive

	
  * Boot the flash drive in single stepping mode, making sure to skip loading HIMEM

	
  * Keeping your fingers crossed, execute
`plash16.exe BIOS.WPH`


