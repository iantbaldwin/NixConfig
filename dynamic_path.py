#!/usr/bin/python

import os
import string

home = os.environ[ 'HOME' ]
currentDirectory = os.environ[ 'PWD' ]

if ( home in currentDirectory ):
    currentDirectory = currentDirectory.replace( home, "~" )

for c in currentDirectory:
