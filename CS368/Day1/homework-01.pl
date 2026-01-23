#Homework for CS 368 - Intro to Perl
#January 22, 2026
#Written by Rob Pacey

#!/usr/bin/perl

use strict;
use warnings;
use Sys::Hostname;
use POSIX 'strftime';

print "CS 368 Homework 01\n";
print "time	= '" . strftime('%Y-%m-%d (%a) %H:%M:%S %Z', localtime()) . "'\n";
print "hostname	= '" . hostname . "'\n";
print "progam	= '$0'\n";
print "exec	= '$^X'\n";
print "version	= '$]'\n";
print "username	= '" . (getpwuid($,))[0] . "'\n";
