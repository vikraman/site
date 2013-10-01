---
comments: true
date: 2011-05-18 21:40:56
layout: post
slug: gsoc-weekly-report-1
title: 'GSoC weekly report #1'
wordpressid: 103
categories: gentoo,gsoc,planet-gentoo
---

This will be my first post in a series for weekly reports on my GSoC'11 project, ["Client-server model for reporting and querying package statistics"](http://www.google-melange.com/gsoc/proposal/review/google/gsoc2011/vh4x0r/1). This project aims to implement a client program to gather package information from gentoo hosts and submit them to a server, which will calculate useful statistics based on the data, rendered using a webapp.

Over the past 2-3 weeks, I have been communicating with my mentor, Alec, and have already written a proof-of-concept client and server, that is ready to be deployed and collect data, thanks to code reviews and excellent ideas from Alec.

A short summary of my progress:




* Created [project repository](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=summary) on [git.overlays.gentoo.org](http://git.overlays.gentoo.org/)


* Read up on RESTful Web Services (from the [O'reilly book](http://oreilly.com/catalog/9780596529260))


* ~~~Improved~~~ Tried to improve my python coding style, thanks to the excellent [guide](http://google-styleguide.googlecode.com/svn/trunk/pyguide.html) from google, suggested by Alec


* Wrote a simple [client](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=tree;f=client;h=46f228e9ef8b6ead1d2a027e0cb38b7f12958f9b;hb=HEAD) in python to collect a few environment variables from portage, list of installed packages with useflags, encode the data in JSON, with proper authentication and issue a POST to the server


* Wrote a simple [webapp](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=tree;f=server;h=5a5cf33b50473a313ca5eedef2650e872d33266a;hb=HEAD) using web.py to handle requests from the above client and save the data to MySQL tables


* Wrote some [documentation](http://git.overlays.gentoo.org/gitweb/?p=proj/gentoostats.git;a=tree;f=docs;h=114fbe546a91a62ca05805d884d8cae68f125b4b;hb=HEAD) to deploy the webapp


Issues encountered during development:


* Choice of portage api vs gentoolkit api : The gentoolkit api is very easy to use but [quite slow](http://vh4x0r.wordpress.com/2011/04/12/portage-dbapi-vs-gentoolkit-api/) compared to the portage api. In the end, Alec asked me to use both of them as necessary, but provide an easy way to swap out one in favor of the other at a later time.


* Choice of web framework, [Turbogears](http://turbogears.org/) vs [others](http://wiki.python.org/moin/WebFrameworks) : I ended up using [web.py](http://webpy.org/) for the server, rather than Turbogears (as promised in my proposal), since I found it easier to implement RESTful services using web.py rather than Turbogears. Also, web.py is lightweight, provides more control, and has enough features for implementing this webapp. However, should if I hit a snag using web.py, it probably wouldn't take more than a day or two of coding to replace it with Turbogears.


The project repository currently provides a working client and server, and it'll be deployed soon on [soc.dev.gentoo.org](http://soc.dev.gentoo.org/), once Alec sets me up with shell access.

Plans for the upcoming weeks:




* Get updates from the community on what data should be collected from hosts


* Try to add more fields to the client/server and modify the SQL tables accordingly


* Learn more about the portage api and discuss them on #gentoo-portage


My semester exams are currently in progress, and they'll last till the end of May. So, I'll not be able to work during these 2 weeks. However, I do look forward to get back in June, and continue with my project.
