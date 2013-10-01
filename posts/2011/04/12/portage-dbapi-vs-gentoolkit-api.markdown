---
comments: true
date: 2011-04-12 02:15:01
layout: post
slug: portage-dbapi-vs-gentoolkit-api
title: Portage dbapi vs Gentoolkit api
wordpressid: 81
categories: gentoo,programming
---

Wrote  some code to read list of installed packages (CPV - category, package, version) using the Gentoolkit api, as well as the Portage dbapi. Here's the results !

```python
#!/usr/bin/env python

from time import time

startg = time ()
from gentoolkit.helpers import get_installed_cpvs
for cpv in sorted (get_installed_cpvs ()):
print cpv
endg = time ()

startp = time ()
from portage.dbapi.vartree import vartree
vt = vartree ()
for cpv in sorted (vt.getallcpv ()):
print cpv
endp = time ()

print "Gentoolkit", endg - startg
print "Portage", endp - startp
```
```
...
...
xfce-extra/xfce4-power-manager-1.0.10
xfce-extra/xfce4-sensors-plugin-1.0.0-r1
xfce-extra/xfce4-taskmanager-1.0.0
Gentoolkit 2.60817313194
Portage 0.0787289142609
```

Portage dbapi is way faster than Gentoolkit :)
