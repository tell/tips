#!/bin/bash

./b2 -j 3 --stagedir=stage/1.59.0/gcc/debug toolset=gcc threading=multi variant=debug address-model=64 link=static,shared
./b2 -j 3 --stagedir=stage/1.59.0/gcc/release toolset=gcc threading=multi variant=release address-model=64 link=static,shared
