#!/usr/bin/python
import subprocess
import sys

def runCommand( command ):
    process = subprocess.Popen( command, shell=True, stdout=subprocess.PIPE )
    return process.stdout.read().replace( "\n", "" )


#updates = runCommand( "brew outdated | wc | awk '{ print $1 }'" )
processes = runCommand( "ps aux | wc | awk '{ print $1-6}'" )
date = runCommand( "date" )
load = runCommand( "sysctl -n vm.loadavg | awk '{ print $2, $3, $4 }'" ).replace( " ", ", " )
strg = runCommand( "df | grep ' /$' | awk '{ printf \"%s of %.2fGB\", $5, $2*512/1000000000 }'" )
freeMem = float( runCommand( "vm_stat | grep 'Pages free:' | awk '{ print $3*4096/1024^3 }'" ) )
ttlMem = float( runCommand( "sysctl -a | grep memmap.Conventional | awk '{ print $2/1024^3 }'" ) )


print( "\n  System information as of {}\n".format( date ) )
print( "  System load:\t{}\tProcesses:\t{}".format( load, processes ) )
print( "  Usage of /:\t{0}\t\tMemory Usage:\t{1:.2f}%".format( strg,  freeMem / ttlMem * 100  ) )
