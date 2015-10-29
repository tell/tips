#!/bin/bash

set -e

function compile() {
    toolset=$1
    version=$2
    prefix="$3"

    ! [ -d "$prefix" ] && echo "$prefix : Not found" && exit 1

    gittag="boost-$version"
    git checkout -b $gittag $gittag && :
    git submodule update
    git submodule foreach 'git checkout . && git clean -fd'

    ./b2 headers
    temp="$version/$toolset/debug"
    ./b2 -j 3 --stagedir="stage/$temp" toolset=$toolset threading=multi variant=debug address-model=64 link=static,shared
    ./b2 -j 3 install --stagedir="stage/$temp" --prefix="$prefix/$temp"
    temp="$version/$toolset/release"
    ./b2 -j 3 --stagedir="stage/$temp" toolset=$toolset threading=multi variant=release address-model=64 link=static,shared
    ./b2 -j 3 install --stagedir="stage/$temp" --prefix="$prefix/$temp"
}

compile gcc 1.59.0 "/opt/local/boost"
