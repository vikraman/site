---
comments: true
date: 2010-05-23 13:57:52
layout: post
slug: four-penguins-on-my-console
title: Four penguins on my console o_O
wordpressid: 31
---

So here's the hardware specs of my new laptop ...
`
+7:01% cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i3 CPU M 330@ 2.13GHz
stepping	: 2
cpu MHz		: 933.000
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm arat tpr_shadow vnmi flexpriority ept vpid
bogomips	: 4257.22
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
`
The processor is an [Arrandale](http://en.wikipedia.org/wiki/Arrandale_%28microprocessor%29), which has 2 cores with HT, so, I get a total of 4 cores, hence 4 [meditating penguins](http://www.zen-kernel.org) while booting ;-)
`
+7:09% free -m 
 total used free sharedbuffers cached
Mem:3755590 31640 37263
`
That's 4 GiB of DDR3 RAM @ 1066 MHz :-o
`
+7:11% sudo parted -l 
Model: ATA ST9500420AS (scsi)
Disk /dev/sda: 500GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
`
A 500 GiB 7200 RPM hard disk !!
`
+7:11% sudo lsusb
Bus 001 Device 008: ID 413c:8160 Dell Computer Corp. 
Bus 001 Device 007: ID 413c:8162 Dell Computer Corp. 
Bus 001 Device 006: ID 413c:8161 Dell Computer Corp. 
Bus 001 Device 005: ID 0bda:0158 Realtek Semiconductor Corp. Mass Storage Device
Bus 001 Device 004: ID 0c45:641d Microdia 
Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
Bus 001 Device 002: ID 8087:0020
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 002: ID 8087:0020
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
+7:12% sudo lspci
00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 12)
00:02.0 VGA compatible controller: Intel Corporation Core Processor Integrated Graphics Controller (rev 12)
00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series Chipset HECI Controller (rev 06)
00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 06)
00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 1 (rev 06)
00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 2 (rev 06)
00:1c.5 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 6 (rev 06)
00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 06)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a6)
00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC Interface Controller (rev 06)
00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset 4 port SATA AHCI Controller (rev 06)
00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus Controller (rev 06)
00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400 Series Chipset Thermal Subsystem (rev 06)
03:00.0 Network controller: Broadcom Corporation BCM4312 802.11b/g (rev 01)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 02)
ff:00.0 Host bridge: Intel Corporation Core Processor QuickPath Architecture Generic Non-core Registers (rev 02)
ff:00.1 Host bridge: Intel Corporation Core Processor QuickPath Architecture System Address Decoder (rev 02)
ff:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 02)
ff:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 02)
ff:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
ff:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
`
The integrated wireless is a Broadcom Corporation BCM4312 802.11b/g (14e4:4315). It does work with the propietary broadcom-sta driver, but that's really a PITA, so I decided to experiment with the b43 driver. Finally after some help from the ubuntu forums, I got it to work stably by passing the options 'pio=1 qos=0' (though it limits the data rate to around 5 Mbps :-( ), and with the firmware version 4.178.10.4. The bluetooth stack works after using hid2hci.
`
hid2hci -v 413c -p 8162 -r hci -m dell 
`
KMS, framebuffer work right away using i915 in the kernel, the touchpad has got some nice tricks like circular scrolling and palm detection, which work well with the synaptics driver, but I haven't yet gotten suspend/resume to work ! No wonder, hardware rates are falling exponentially these days :-)
