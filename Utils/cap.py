#!/usr/bin/env py

import sys
new = ""
for arg in sys.argv[1: ]:
    new += arg
    new += " "

print new.upper().strip()
