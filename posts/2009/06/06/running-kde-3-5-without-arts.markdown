---
comments: true
date: 2009-06-06 14:35:00
layout: post
slug: running-kde-3-5-without-arts
title: Running KDE 3.5 without arts
wordpressid: 17
categories: gentoo,programming
---

I compiled KDE on my gentoo install with -arts USE flag. So I needed an alternative for playing the KDE sound notifications. So I wrote a program in C to launch the appropriate player for each type of audio file, in a forked process.  
  


> #include <unistd.h>  
#include <stdio.h>  
#include <string.h>  
int main(int argc, char **argv)  
{  
if (argc != 2) {  
 printf("Exactly one argument expected.\n");  
 return 0;  
}  
char *ext = strrchr(argv[1], '.');  
ext++;  
if (ext == NULL) {  
 return 1;  
}  
if (fork() == 0) {  
 if (strcmp(ext, "wav") == 0)  
   execl("/usr/bin/aplay", "/usr/bin/aplay", "-q", argv[1], NULL);  
 else if (strcmp(ext, "ogg") == 0)  
   execl("/usr/bin/ogg123", "/usr/bin/ogg123", "-q", argv[1], NULL);  
 else if (strcmp(ext, "mp3") == 0)  
   execl("/usr/bin/mpg123", "/usr/bin/mpg123", "-q", argv[1], NULL);  
 else  
   execl("/usr/bin/mplayer", "/usr/bin/mplayer", "-vo", "null", "-really-quiet", argv[1], NULL);  
}  
return 0;  
}  


  
References: [http://www.gentoo-wiki.info/TIP_Audio_notifications_in_KDE_3_without_aRts](http://www.gentoo-wiki.info/TIP_Audio_notifications_in_KDE_3_without_aRts)  
(Actually there is a mistake in the program on the gentoo wiki which I corrected)
