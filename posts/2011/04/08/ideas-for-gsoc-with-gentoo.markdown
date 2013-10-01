---
comments: true
date: 2011-04-08 20:02:03
layout: post
slug: ideas-for-gsoc-with-gentoo
title: Ideas for GSoC with Gentoo
wordpressid: 70
categories: gentoo
---

This is a summary of my project idea for applying to Google Summer of Code 2011 with Gentoo. I've decided to work on a package statistics reporting and query tool, which is currently lacking in Gentoo.

Similar projects :



	
* Smolt : Smolt was initially supposed to be a hardware reporting tool to track status of working or non-working hardware items. Sebastian Pipping (sping) worked on smolt to include package statistics for Gentoo, and it could generate several useful stats based on installed, masked, unmasked packages, use flags, cflags etc. Initially, I had thought about adding features to smolt as a part of my project, but as sping pointed out, the smolt codebase is not clean, and adding such features to it would be unmanageable. Besides, in the current release, the Gentoo code is broken and unmaintained.

	
* Gstats : Gstats was a project by Alec Turner (antarus) to collect package stats in 2006. It uses colubrid which is not in development at present and hence needs a complete rewrite.


Motivation :

	
* Since Gentoo is about building your own distro, most new users don't have a clue what packages to install for a typical desktop, and often switch to a fully blown Gnome/KDE desktop (Happened to me a lot during my first Gentoo installs).

	
* Sometimes a package gets stuck on ~arch, and developers don't pay much attention to it although it is popular, so most users have to unmask to use it, which is a difficult issue for new users.

	
* Unused packages can be trimmed down from the tree if they can be found out automatically.

	
* Popularly installed packages from overlays an be added to the tree.

	
* Having used Debian earlier before converting to Gentoo, I was missing out on the package popularity contest idea of Debian.


I was inspired by the way Smolt works, and would like to base my project on a similar design. Firstly, there's a client software that runs on the user's machine (as a cronjob, portage hook, or on demand) and sends list of installed packages, masked/unmasked status, use flags to the stats server. Each user has his own UUID which is generated at the time of installation. Also, when the server encounters a new UUID, it identifies a new user, and generates a password for him.

Once the user has submitted his stats for the first time, he can log on to the web application using his UUID to search/view his installed packages, use flags etc. Also, on selecting a package, he gets a list of packages, usually installed along-with, sorted by ratings.  If the user wishes to add a rating/review for a package, he needs to use his password provided earlier.

A dev can log on using a passkey, and search packages by maintainer/herd, no. of bugs, no. of tinderbox-related bugs, no. of users.

Any anonymous user can see a sorted list of most popular packages, most rated packages and package reviews.

I'm looking to use a RESTful web API for the client-server communication.

UPDATE : I've submitted my proposal, find it [here](http://www.google-melange.com/gsoc/proposal/review/google/gsoc2011/vh4x0r/1)
