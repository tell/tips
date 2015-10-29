#!/bin/bash

set -e

function compile() {
    toolset=$1
    version=$2

    gittag="boost-$version"
    git checkout -b $gittag $gittag && git submodule update && git submodule foreach 'git checkout . && git clean -fd'
    ./b2 headers
    ./b2 -j 3 --stagedir="stage/$version/$toolset/debug" toolset=$toolset threading=multi variant=debug address-model=64 link=static,shared
    ./b2 -j 3 --stagedir="stage/$version/$toolset/release" toolset=$toolset threading=multi variant=release address-model=64 link=static,shared
}

compile gcc 1.59.0
