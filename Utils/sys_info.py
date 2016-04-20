#!/usr/bin/python
"""
Prints system information based

  - Gets the count of processes
  - Gets the current date
  - Gets the load averages
  - Get storage information
  - Get memory usage


Author:     Ian Baldwin (iantbaldwin@elektrikfish.com)
Version:    1.0
Date:       4/19/2016

Changes:
--------
Original version

"""
import subprocess
import sys
import os

def runCommand( command ):
    process = subprocess.Popen( command, shell=True, stdout=subprocess.PIPE )
    return process.stdout.read().replace( "\n", "" )

home = os.environ[ 'HOME' ]
updates = runCommand( "cat " + home + "/.brewstatus | wc | awk '{ print $1 }'" )
processes = runCommand( "ps aux | wc | awk '{ print $1-6}'" )
date = runCommand( "date" )
load = runCommand( "sysctl -n vm.loadavg | awk '{ print $2, $3, $4 }'" ).replace( " ", ", " )
strg = runCommand( "df | grep ' /$' | awk '{ printf \"%s of %.2fGB\", $5, $2*512/1000000000 }'" )
freeMem = float( runCommand( "vm_stat | grep 'Pages active:' | awk '{ print $3*4096/1024^3 }'" ) )
ttlMem = float( runCommand( "sysctl -a | grep memmap.Conventional | awk '{ print $2/1024^3 }'" ) )

print( "\n  System information as of {}\n".format( date ) )
print( "  System load:\t{}\tProcesses:\t{}".format( load, processes ) )
print( "  Usage of /:\t{0}\t\tMemory Usage:\t{1:.2f}%".format( strg,  freeMem / ttlMem * 100  ) )
