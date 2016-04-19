#!/usr/bin/python

"""
Prints an abbreviated version of PWD

    - All directories in the path other than the current are
      abbreviated to one letter. If the directory is hidden,
      then the directory is abbreviated to a period and a
      single letter.
    - If the user is a in a directory within their home, then
       the path of their home is abbreviated to '~'.

Author:     Ian Baldwin
Version:    1.0
Date:       4/19/2016
Changes
------
    Original version
"""
import os
import string
import sys

# Get the user's home and current directory
home = os.environ[ 'HOME' ]
currentDirectory = os.environ[ 'PWD' ]

# Replace the path of home with '~'
if ( home in currentDirectory ):
    currentDirectory = currentDirectory.replace( home, "~" )

# Parse the current directory, abbreviating subdirectories,
# preserving the ~ special character, and printing the final directory
# in its entirety
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
