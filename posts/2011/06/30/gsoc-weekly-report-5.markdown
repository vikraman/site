---
comments: true
date: 2011-06-30 21:14:19
layout: post
slug: gsoc-weekly-report-5
title: 'GSoC weekly report #5'
wordpressid: 136
categories: gentoo,gsoc,planet-gentoo
---

Hi everyone,

This is my fifth weekly report on the progress of my GSoC [project](http://www.google-melange.com/gsoc/project/google/gsoc2011/vh4x0r/26001).

Progress during the last week:

I'm getting the webapp ready to be deployed on [vulture](http://soc.dev.gentoo.org).



	
  * Wrote tests for the server

	
  * Update the code to use HTTPS rather than HTTP

	
  * Deployed the webapp locally using apache and mod_wsgi, configs are attached on [bugzilla](http://bugs.gentoo.org/show_bug.cgi?id=369679)


Issues:

	
  * I had mentioned compression as one of my goals in my last progress report. But after discussion, I'm postponing this goal until a beta server is up and running (since it could be done internally, or using mod_deflate on apache).


Goals for next week(s):

I'm going to concentrate mostly on the webUI now, adding more features, fixing up the webpages etc.

	
  * Improve/fix the stats pages

	
  * Allow user login/session management etc.


