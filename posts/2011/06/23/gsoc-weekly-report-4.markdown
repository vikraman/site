---
comments: true
date: 2011-06-23 21:32:54
layout: post
slug: gsoc-weekly-report-4
title: 'GSoC weekly report #4'
wordpressid: 133
categories: gentoo,gsoc,planet-gentoo
---




Hi everyone,




This is my fourth weekly report on the progress of my GSoC project. It's been a little slow last week since I had been travelling.




Progress during the last week:






	
* Wrote ebuild for the client

	
* Auth info for the host is read from a config file now

	
* Implemented a config file feature for the user to mask reported fields

	
* Worked on pages for per-package and per-arch stats




Issues:






	
* Payload compression : The client data sent could be compressed to improve post time. This could be done by gzip compression of the payload (authentication info should be separated from the payload then), or by using a transparent gzip reverse proxy with apache.

	
* HTTPS : It was suggested to send the data over HTTPS for better security. This too, could be implemented using reverse proxies.




Blockers:






	
* Still blocked on [bug 369679](http://bugs.gentoo.org/show_bug.cgi?id=369679) to deploy the webapp




Goals for next week(s):






	
* Work on the above issues

	
* Continue work on the WebUI

	
* Write some tests for the client



