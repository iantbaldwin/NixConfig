import subprocess
import sys

processes = subprocess.check_output( "ps aux | wc | awk '{ print $1-4}'", shell=True ).replace( "\n", "" )
date = subprocess.check_output( "date", shell=True ).replace( "\n", "" )
load = subprocess.check_output( "sysctl -n vm.loadavg | awk '{ print $2 }'", shell=True ).replace( "\n", "" )
print( "\n  System information as of {}\n".format( date ) )
print( "  System load:\t{}\t\tProcesses: {}".format( load, processes ) )
