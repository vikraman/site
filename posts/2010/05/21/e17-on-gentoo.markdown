---
comments: true
date: 2010-05-21 20:40:14
layout: post
slug: e17-on-gentoo
title: e17 on gentoo
wordpressid: 7
categories: gentoo
---

So, I just emerged enlightenment on my laptop from the official overlay maintained by the Enlightenment developers.

[http://trac.enlightenment.org/e/wiki/Gentoo](http://trac.enlightenment.org/e/wiki/Gentoo)

```bash
layman -o http://svn.enlightenment.org/svn/e/trunk/packaging/gentoo/Documentation/layman/overlays.xml -f -a efl
emerge -av @enlightenment
```

However, while compiling `dev-libs/embryo-9999`, portage got stuck, which I solved by disabling the graphite loop optimizations from my CFLAGS. After logging into e17, just enable the composite extension, and drool over the cool desktop effects in enlightenment ;-)
