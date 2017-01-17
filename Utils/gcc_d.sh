#!/bin/sh
docker run --rm -v $(pwd):/work/ iantbaldwin/gcc-val:latest gcc $@
