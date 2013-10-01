---
comments: true
date: 2011-06-08 19:04:49
layout: post
slug: gsoc-weekly-report-2
title: 'GSoC weekly report #2'
wordpressid: 117
categories: gentoo,gsoc,planet-gentoo
---

Hello,

This is my second weekly report on the progress of my GSoC project. I was busy with my exams for two weeks, and it's been a week since I resumed work.

Progress during the past week:



	
* Requested packages to be installed on [soc.dev.gentoo.org](http://soc.dev.gentoo.org) for deploying webapp ([369679](http://bugs.gentoo.org/show_bug.cgi?id=369679))

	
* Rewrote the client code to be modular

	
* Added more fields to the client, including stuff from `emerge --info` and package metadata

	
* Updated the server code to handle the updated client data

	
* Fixed bugs in the sql code

	
* Started writing exception handling code for the client and server


Commit URL : [http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=commit;h=1b9697a090515d2a373e83b1094d6e08ec405c02](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=commit;h=1b9697a090515d2a373e83b1094d6e08ec405c02)

Goals for the next week(s):



	
* Implement stats pages for the WebUI

	
* Write ebuilds to deploy the client/server

	
* Continue fixing bugs, handling exceptions


