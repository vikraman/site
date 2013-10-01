---
comments: true
date: 2011-07-14 00:17:32
layout: post
slug: gsoc-midterm-report
title: GSoC midterm report
wordpressid: 142
categories: gentoo,gsoc,planet-gentoo
---

Hi all,

Welcome to the midterm report of the 'Package statistics' [project](http://www.google-melange.com/gsoc/project/google/gsoc2011/vh4x0r/26001).


## Summary


The goal of this project is to implement a client-server architecture

for reporting and querying package statistics of Gentoo based machines.
The client program will be used to collect package statistics from
Gentoo installations and submit them to a central server. The server
will calculate useful statistics based on the global dataset, that
developers as well as end users have access to, via an intuitive web
interface.

For the past few days, I've been working on the webUI, adding pages for stats.
We've also managed to get the [webapp running](https://soc.dev.gentoo.org/gentoostats) (finally :D) on [vulture](http://soc.dev.gentoo.org). Thanks
to my mentor antarus, robbat2, and the rest of the infra team for helping out.
We hit a few snags, but managed to ease them out in the end. Also, apologies for
making a stupid mistake of committing my mysql password to git (:P).


## What works





	
  * Submitting host stats using a client script

	
  * Accessing host stats at /host/≤uuid>

	
  * Arch stats: /arch

	
  * Package stats:

	
    * /package/<category>

	
    * /package/<category>/<pkgname>

	
    * /package/<category>/<pkgname>-<version>
(An optional ?top=N can be added to the url for the no. of top items)




	
  * Repository stats: /repo

	
  * Keyword stats: /keyword

	
  * Useflag stats:

	
    * /use

	
    * /use/≤useflag>




	
  * Portage FEATURES stats: /feature

	
  * Language stats: /lang

	
  * Mirror stats: /mirror

	
  * Profile stats: /profile




## What doesn't work (yet)





	
  * Package search

	
  * Rating of packages

	
  * Graphs

	
  * Bugzilla, tinderbox integration

	
  * Export the stats to JSON




## What needs work





	
  * The webUI should be prettier

	
  * The repository and useflag stats could be improved


I think I can finish the remaining goals in another 2-3 weeks. After that, I'll consider working on some of my stretch goals.

I'm also working on improving the [packages.gentoo.org](http://packages.gentoo.org) api, so that there's an easy way to access the portage tree state, and enrich the package stats.

Help me out by submitting your stats to the server. An ebuild for the client is available in the [repo](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=summary). Please report bugs, exceptions etc.

Got any feature suggestions/ideas ?
