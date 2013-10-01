---
comments: true
date: 2011-06-08 19:40:29
layout: post
slug: package-statistcs-data-collected
title: 'Package statistcs : data collected'
wordpressid: 120
categories: gentoo,gsoc,planet-gentoo
---

As a followup to my previous post, the current code collects the following data from hosts :



	
  * Uname of host

	
  * Portage profile

	
  * Time stamp of portage tree (last sync time)

	
  * The following portage variables :


	
    * ARCH

	
    * CHOST

	
    * CFLAGS

	
    * CXXFLAGS

	
    * FFLAGS

	
    * LDFLAGS

	
    * MAKEOPTS

	
    * ACCEPT_KEYWORDS

	
    * FEATURES

	
    * USE

	
    * LANG

	
    * SYNC

	
    * GENTOO_MIRRORS


	
  * The following metadata for each installed package :


	
    * Repository name

	
    * Keyword used to install package (for example, x86, ~x86 or -x86)

	
    * Useflags (plus, minus, unset) for installation

	
    * Counter to indicate the relative ordering of package installs

	
    * Installed size

	
    * Build time



