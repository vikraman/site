---
comments: true
date: 2011-08-23 02:33:12
layout: post
slug: gsoc-final-report
title: GSoC final report
wordpressid: 171
categories: gentoo,gsoc,planet-gentoo
---

Hello everyone,

This is the final report for the _**[Package statistics](http://www.google-melange.com/gsoc/project/google/gsoc2011/vh4x0r/26001)**_ project.

**Homepage : **[https://soc.dev.gentoo.org/gentoostats/](https://soc.dev.gentoo.org/gentoostats/)

**Repository : **[http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git)


## Summary


The goal of this project is to implement a client-server architecture for reporting and querying package statistics of Gentoo based machines. The client program will be used to collect package statistics from Gentoo installations and submit them to a central server. The server will calculate useful statistics based on the global dataset, that developers as well as end users have access to, via an intuitive web interface.


## Detailed summary


The gentoostats project consists mainly of three components:



	
  * **[https://soc.dev.gentoo.org/gentoostats/](https://soc.dev.gentoo.org/gentoostats/) :** The webapp which collects data submitted by clients and renders the required stats.

	
  * **gentoostats-send :** The script which reads portage and package data and submits them to the server.

	
  * **gentoostats-cli :** The script which talks to the gentoostats webapp via a RESTful api, and reads and displays stats.


As of the "pencils down" date, all of the above components are working, and quite a lot of [stats](http://vh4x0r.wordpress.com/2011/07/14/gsoc-midterm-report/) are rendered successfully. Of course, I have dropped some features from my [original proposal](http://vh4x0r.wordpress.com/2011/04/08/ideas-for-gsoc-with-gentoo/), but also added some. Besides this, I also wrote some patches to [packages.gentoo.org](http://packages.gentoo.org), though they haven't been merged yet.


## Future plans


I am looking forward to continue working on and improving this project. Besides, I would very much like to join the community as a gentoo dev.

Some possible future goals are :

* The [webUI](https://soc.dev.gentoo.org/gentoostats/) is fugly at this point, mostly because I suck at web designing. It could be improved a lot, using the underlying json api.

* Portage [gui apps](http://learn.clemsonlinux.org/wiki/Gentoo:Portage_in_GUI) could be patched to use stats from the webapp.

* A popular request for stats is adding ["installed files"](http://www.portagefilelist.de/index.php/Main_Page) to the stats. This requires an ingenious solution since the dataset is huge.


## Thanks


Out of the top of my head, I would like to thank antarus, dberkholz, robbat2, the infra team, #gentoo-portage, #gentoo-dev-help, #gentoo-soc, without whom this SoC wouldn't have been a success.
