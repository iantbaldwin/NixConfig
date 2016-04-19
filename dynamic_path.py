#!/usr/bin/python

import os
import string
import sys

home = os.environ[ 'HOME' ]
currentDirectory = os.environ[ 'PWD' ]

if ( home in currentDirectory ):
    currentDirectory = currentDirectory.replace( home, "~" )

for i,c in enumerate( currentDirectory ):
    if ( c == '/' ):
        # Print the seperator and the directory abbereviation
        if ( currentDirectory.find( "/", i + 1 ) != -1 ):
            sys.stdout.write( c )
            sys.stdout.write( currentDirectory[ i + 1 ] )
            if ( currentDirectory[ i + 1 ] == '.' ):
                sys.stdout.write( currentDirectory[ i + 2 ] )
        else:
            while ( i < len( currentDirectory ) ):
                sys.stdout.write( currentDirectory[ i ] )
                i = i + 1
            break
    elif ( c == '~' ):
        sys.stdout.write( c )
