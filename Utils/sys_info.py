#!/usr/bin/python
"""
Prints system information

  - Number of Processes
  - Current date
  - Load averages
  - Storage information as a percentage
  - Memory usage as a percentage
  - System uptime
  - IP Address
  - Number of Package updates available

Author:     Ian Baldwin (iantbaldwin@elektrikfish.com)
Version:    1.0
Date:       4/19/2016

Changes:
--------
Original version

To Do:
------
- Color code (IP Address based on WAN) [ ]
- Linux support [ ]
- Speed improvements [ ]
"""
import subprocess
import os

def runCommand( command ):
    process = subprocess.Popen( command, shell=True, stdout=subprocess.PIPE )
    return process.stdout.read().replace( "\n", "" )

updates = runCommand( "wc ~/.brewoutdated | awk '{ print $1 }'" )
processes = runCommand( "ps aux | wc | awk '{ print $1-6}'" )
date = runCommand( "date" )
load = runCommand( "sysctl -n vm.loadavg | awk '{ print $2, $3, $4 }'" ).replace( " ", ", " )
strg = runCommand( "df | grep ' /$' | awk '{ printf \"%s of %.2fGB\", $5, $2*512/1000000000 }'" )
aMem = float( runCommand( "memory_pressure | grep 'Pages active:' | awk '{ print $3*4096/1024^3 }'" ) )
wMem = float( runCommand( "memory_pressure | grep 'Pages wired down' | awk '{ print $4*4096/1024^3 }'" ) )
cMem = float( runCommand( "memory_pressure | grep 'Pages used by compressor:' | awk '{ print $5*4096/1024^3 }'" ) )
tMem = float( runCommand( "sysctl -a | grep memmap.Conventional | awk '{ print $2/1024^3 }'" ) )
uptime = runCommand( "uptime | awk -F'[:, ]' '{ printf \"%s days, %sh%sm\", $5, $8, $9 }'" );
network = runCommand( "ifconfig | grep 'inet 1[097]' | awk 'FNR==1 { print $2 }'" )


print( "\n  System information as of {}\n".format( date ) )
print( "  System load:\t{}\tProcesses:\t{}".format( load, processes ) )
print( "  Usage of /:\t{0}\t\tMemory Usage:\t{1:.2f}%".format( strg,  (aMem + wMem + cMem )/ tMem * 100  ) )
print( "  Uptime:\t{}\t\tIP Address:\t{}\n".format( uptime, network) )
print( "  {} packages can be updated.\n".format( updates ) )
