#!/usr/bin/env bash

curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz
tar zxf lua-5.4.7.tar.gz
cd lua-5.4.7
make local
cd ..
mv -T lua-5.4.7 lua
rm -f lua-5.4.2_Linux54_64_bin.tar.gz