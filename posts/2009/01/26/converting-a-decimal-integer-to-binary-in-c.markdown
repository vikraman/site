---
comments: true
date: 2009-01-26 19:19:00
layout: post
slug: converting-a-decimal-integer-to-binary-in-c
title: Converting a decimal integer to binary in C
wordpressid: 15
categories: programming
---

This is some C code that I wrote to convert a decimal integer to its binary equivalent. Most programs written to do so convert the decimal to a string, or an array, of the consecutive remainders modulo 2, which is then printed out in reverse order to get the binary equivalent. However I wanted an integer output of the binary equivalent. So this is what I did.



> #include<stdio.h>
int power(int power)
{
 int i,p=1;
 for(i=0;i<power;i++)
 p*=10;
 return p;
}
int dectobin(int dec)
{
 int bin=0,s[15],i=0,j;
 while(dec!=0)
 {
 s[i]=dec%2;
 dec/=2;
 i++;
 }
 for(j=i-1;j>=0;j--)
 bin+=s[j]*power(j);
 return bin;
}
int main()
{
 int num=114;
 printf("The binary equivalent of %d is %d\n",num,dectobin(num));
 return 0;
}
