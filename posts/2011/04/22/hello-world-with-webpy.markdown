---
comments: true
date: 2011-04-22 01:49:23
layout: post
slug: hello-world-with-webpy
title: Hello world with webpy
wordpressid: 84
categories: programming
---

Here's some hello world code to get started with [webpy](http://webpy.org).



```python
#!/usr/bin/env python

import web
render_html = lambda message: '<html><body>%s</body></html>'%message
urls = (
'/(.*)', 'hello'
)
app = web.application(urls, globals())

class hello:
def GET(self, name):
if not name:
name = 'world'
return render_html('Hello, ' + name + '!')

if __name__ == "__main__":
app.run()
```

```bash
% ./webpydemo.py
http://0.0.0.0:8080/
% curl localhost:8080
<html><body>Hello, world!</body></html>
% curl localhost:8080/vh4x0r
<html><body>Hello, vh4x0r!</body></html>
</code>
```
