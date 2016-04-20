#!/usr/bin/python
"""
Prints system information based

  - Gets the count of processes
  - Gets the current date
  - Gets the load averages
  - Get storage information as a percentage
  - Get memory usage as a percentage


Author:     Ian Baldwin (iantbaldwin@elektrikfish.com)
Version:    1.0
Date:       4/19/2016

Changes:
--------
Original version

"""
import subprocess
import os

def runCommand( command ):
    process = subprocess.Popen( command, shell=True, stdout=subprocess.PIPE )
    return process.stdout.read().replace( "\n", "" )

home = os.environ[ 'HOME' ]
#updates = runCommand( "cat " + home + "/.brewstatus | wc | awk '{ print $1 }'" )
updates = runCommand( "brew outdated | wc | awk '{ print $1 }'" )
processes = runCommand( "ps aux | wc | awk '{ print $1-6}'" )
date = runCommand( "date" )
load = runCommand( "sysctl -n vm.loadavg | awk '{ print $2, $3, $4 }'" ).replace( " ", ", " )
strg = runCommand( "df | grep ' /$' | awk '{ printf \"%s of %.2fGB\", $5, $2*512/1000000000 }'" )
aMem = float( runCommand( "memory_pressure | grep 'Pages active:' | awk '{ print $3*4096/1024^3 }'" ) )
wMem = float( runCommand( "memory_pressure | grep 'Pages wired down' | awk '{ print $4*4096/1024^3 }'" ) )
cMem = float( runCommand( "memory_pressure | grep 'Pages used by compressor:' | awk '{ print $5*4096/1024^3 }'" ) )
tMem = float( runCommand( "sysctl -a | grep memmap.Conventional | awk '{ print $2/1024^3 }'" ) )
uptime = runCommand( "uptime | awk -F'[:, ]' '{ printf \"%s days, %sh%sm\", $5, $8, $9 }'" );
#network = runCommand( "ping -c 1 google.com | grep -c '1 packets received' | awk '{ gsub( \"1\", \"Up\", $1 ); gsub( \"0\", \"Down\"); print $1 }'" )


print( "\n  System information as of {}\n".format( date ) )
print( "  System load:\t{}\tProcesses:\t{}".format( load, processes ) )
print( "  Usage of /:\t{0}\t\tMemory Usage:\t{1:.2f}%".format( strg,  (aMem + wMem + cMem )/ tMem * 100  ) )
print( "  Uptime:\t{}\t\t\n".format( uptime) )
print( "  {} packages can be updated.\n".format( updates ) )
