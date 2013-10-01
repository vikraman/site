---
comments: true
date: 2011-04-28 20:44:23
layout: post
slug: using-gtk3-apps-in-xfce
title: Using gtk3 apps in Xfce
wordpressid: 98
---

If you are like me and don't really like the new Gnome 3.0 UI, but do want to use the gtk3 apps on your Xfce (other DE) setup, here's a way to set the default theme for gtk3 apps, rather than use the ugly default Raleigh theme. All you need to do is symlink the gtk-3.0 directory from the theme inside your ${XDG_CONFIG_HOME} directory (usually ~/.config).


<code>% ln -s /usr/share/themes/Adwaita/gtk-3.0 ~/.config</code>
