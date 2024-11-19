#!/usr/bin/env bash

LUA_VER="5.4.4"
LUA_FOLDER="lua-bin"

cd .config
curl -L -R -O "https://www.lua.org/ftp/lua-$LUA_VER.tar.gz"
tar zxf "lua-$LUA_VER.tar.gz"
cd "lua-$LUA_VER"
make linux local
cd ..
mv "lua-$LUA_VER" "$LUA_FOLDER"
rm -f "lua-$LUA_VER.tar.gz"

# install lfs
curl -L -R -O "https://github.com/lunarmodules/luafilesystem/archive/refs/tags/v1_8_0.tar.gz"
tar zxf v1_8_0.tar.gz
rm -f v1_8_0.tar.gz
mv luafilesystem-1_8_0 $LUA_FOLDER/lfs
cd ..