---
comments: true
date: 2010-08-17 16:38:14
layout: post
slug: installing-oracle-11g-on-linux-amd64
title: Installing Oracle 11g on linux amd64
wordpressid: 63
categories: gentoo
---

This week I managed to get Oracle 11gr2 up and running on my computer. Here are some notes which might be helpful for users installing on any distribution. The difficulty being the fact that the installer supports RedHat based distributions only, the challenge is to make one's system as redhat-ish as possible prior to the installation.



	
* Enable AIO (async I/O) in the kernel

`CONFIG_AIO=y`

	
* Install dependencies including build tools, compilers, and specifically rpm and ksh. On a gentoo system

`emerge -av dev-libs/libaio app-arch/rpm app-shells/pdksh virtual/libstdc++`

	
* Create symlinks for libstdc++.so.6 in both lib32 and lib64 directories

`cd /usr/lib64`

`ln -s `gcc-config -L | cut -f1 -d:`/libstdc++.so.6 libstdc++.so.6`

`cd /usr/lib32`

`ln -s `gcc-config -L | cut -f2 -d:`/libstdc++.so.6 libstdc++.so.6`

	
* Create users, groups and directories

`groupadd oinstall`

`groupadd dba`

`useradd -c "Oracle Software Owner" -g oinstall -G dba -m oracle`

`passwd oracle`

`mkdir -p /opt/oracle /etc/oracle /opt/oraInventory`

`chown -R oracle:oinstall /opt/oracle /opt/oraInventory /etc/oracle`

	
* Setup a more RedHat-ish layout (/bin/basename, /bin/awk, /bin/rpm symlinks), for a gentoo system only the following is needed

`ln -s /usr/bin/rpm /bin/rpm`

	
* Modify kernel parameters and security limits



> /etc/sysctl.conf
`
# Kernel parameters for Oracle 11g
kernel.shmmax=2147483648
kernel.sem=250 32000 100 128
fs.file-max=6815744
fs.aio-max-nr=1048576
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048576
net.ipv4.ip_local_port_range=9000 65500`




> /etc/security/limits.conf
`
# Increase shell limits for Oracle 11.2
oracle		 soft	 nofile		 4096
oracle		 hard	 nofile		 65536
oracle		 soft	 nproc		 2047
oracle		 hard	 nproc		 16384
`


`sysctl -p`

	
* Pre-installation



> /etc/profile.d/oracle.sh
`if [ "$USER" = "oracle" ]; then
if [ $SHELL = "/bin/ksh" ]; then
ulimit -u 16384
ulimit -n 65536
else
ulimit -u 16384 -n 65536
fi
fi`




> /bin/gcc
`
#!/bin/bash
if [ "$1" = "-m32" ]; then
/usr/bin/gcc -L/usr/lib32 $*
else
/usr/bin/gcc $*
fi`




	
* Installation

`xhost+
./runInstaller
`

	
* At linker errors



> ${ORACLE_HOME}/lib/sysliblist
`
- -ldl -lm -lpthread -lnsl -lirc -lipgo -lsvml
+ -ldl -lm -lpthread -lnsl -lirc -lipgo -lsvml -lrt
`




	
* Post installation



> /etc/env.d/99oracle
`ORACLE_BASE=/opt/oracle
ORACLE_HOME=/opt/oracle/product/11.2.0/dbhome
ORACLE_OWNER=oracle
ORACLE_SID=orcl
ORACLE_UNQNAME=orcl
ORACLE_TERM=xterm
LD_LIBRARY_PATH=/opt/oracle/product/11.2.0/dbhome/lib
PATH=/opt/oracle/product/11.2.0/dbhome/bin
ROOTPATH=/opt/oracle/product/11.2.0/dbhome/bin
`




> /etc/oratab
`
- orcl:/opt/oracle/product/11.2.0/dbhome:N
+ orcl:/opt/oracle/product/11.2.0/dbhome:Y
`




	
* Create initscripts



> /etc/init.d/ora.console
`#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $`

depend() {
need net
after ora.listener
}

start() {
ebegin "Starting Oracle Enterprise Manager DB Console"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/emctl start dbconsole"
eend $?
}

stop() {
ebegin "Stopping Oracle Enterprise Manager DB Console"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/emctl stop dbconsole"
eend $?
}




> /etc/init.d/ora.database
`#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $`

depend() {
need net logger hostname clock ora.listener
}

start() {
ebegin "Starting Oracle"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/dbstart $ORACLE_HOME"
eend $?
}

stop() {
ebegin "Stopping Oracle"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/dbshut $ORACLE_HOME"
eend $?
}




> /etc/init.d/ora.listener
`#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $`

depend() {
need net
}

start() {
ebegin "Start Oracle Listeners"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/lsnrctl start LISTENER"
eend $?
}

stop() {
ebegin "Stopping Oracle Listeners"
/bin/su -m - $ORACLE_OWNER -c "$ORACLE_HOME/bin/lsnrctl stop LISTENER"
eend $?
}



Everything seems to be working fine as of now, though I might have missed something while noting it down. The initscripts do require a bit of polish, and I'll blog about them once I've gotten myself around.
