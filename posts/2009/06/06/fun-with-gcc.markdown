---
comments: true
date: 2009-06-06 14:58:00
layout: post
slug: fun-with-gcc
title: Fun with gcc
wordpressid: 18
categories: gentoo,programming
---

Had some fun with gcc today! I once wrote a program that reads words from a file, creates a linked list of the words, and then sorts them alphabetically! For a large text file, the memory overhead is pretty large. So, I used this to benchmark some gcc optimization flags, using all available parameters for the -march= flag!

```bash
> vikraman@charon ~/scripts/gcc-benchmark $ cat cpu-type-32
native
i386
i486
i586
pentium-mmx
pentiumpro
i686
pentium2
pentium3
pentium-m
pentium4
prescott
nocona
core2
k6
k6-2
athlon
athlon-4
k8
k8-sse3
amdfam10
winchip-c6
winchip2
c3
c3-2
geode
```

I needed a hufe text file, so I took some issues of [phrack](http://www.phrack.com), and ended up with a text file containing 1783 words. So, the bash script was:

```bash
> vikraman@charon ~/scripts/gcc-benchmark $ cat benchmark.sh
#!/bin/bash
for cpu in `cat cpu-type-64`
do
 echo $cpu >>benchmark.out
 echo "">>benchmark.out
 printf "\a"
 gcc -march=$cpu -m64 -O3 -pipe -o sortwords sortwords.c
 sleep 3
 printf "\a"
 /usr/bin/time -ao benchmark.out ./sortwords text >/dev/null
 printf "\a"
 sleep 10
 echo "">>benchmark.out
done
```
And the results:


```bash
> vikraman@charon ~/scripts/gcc-benchmark $ cat benchmark.out
native

294.93user 1.30system 4:56.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
1712inputs+0outputs (9major+389047minor)pagefaults 0swaps

i386

295.30user 1.34system 4:57.03elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

i486

294.86user 1.34system 4:57.13elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

i586

295.21user 1.33system 4:57.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

pentium-mmx

295.13user 1.37system 4:58.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

pentiumpro

294.33user 1.28system 4:56.29elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

i686

295.29user 1.56system 5:01.18elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

pentium2

294.67user 1.23system 4:58.56elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

pentium3

297.29user 1.36system 5:00.79elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

pentium-m

294.18user 1.29system 4:58.19elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

pentium4

294.99user 1.49system 4:58.48elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

prescott

294.87user 1.56system 4:58.06elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

nocona

295.71user 1.45system 4:59.41elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

core2

295.35user 1.46system 4:59.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

k6

295.04user 1.44system 4:57.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

k6-2

295.45user 1.48system 4:58.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

athlon

294.66user 1.37system 4:58.69elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

athlon-4

295.32user 1.49system 4:58.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

k8

295.48user 1.46system 4:59.84elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

k8-sse3

295.42user 1.52system 4:58.32elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

amdfam10

295.34user 1.49system 4:57.75elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

winchip-c6

298.74user 1.60system 5:02.45elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

winchip2

296.82user 1.29system 4:58.51elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389055minor)pagefaults 0swaps

c3

294.99user 1.39system 4:58.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps

c3-2

294.38user 1.32system 4:56.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389057minor)pagefaults 0swaps

geode

294.53user 1.43system 4:58.47elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+389056minor)pagefaults 0swaps
```

Clearly, `-march=pentiumpro` wins.
Also, a screenshot from KSysGuard, with the benchmark running!

[![](http://3.bp.blogspot.com/_SkacHZPjbHk/SiqsIbL9tgI/AAAAAAAAACE/cojHuJXngKM/s400/snapshot14.png)](http://3.bp.blogspot.com/_SkacHZPjbHk/SiqsIbL9tgI/AAAAAAAAACE/cojHuJXngKM/s1600/snapshot14.png)

Yet another reason why we should ditch binary based distributions for source based distributions! Gentoo rocks!

[](http://vh4x0r.files.wordpress.com/2009/06/snapshot14.png)
