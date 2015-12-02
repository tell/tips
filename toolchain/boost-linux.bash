#!/bin/bash

set -e

dont='' # '-n'

function compile() {
    set -x
    toolset=$1
    toolset_name=$2
    boost_version=$3
    prefix="$4"

    ! [ -d "$prefix" ] && echo "error $prefix : Not found" && exit 1

    gittag="boost-$boost_version"
    git checkout -fb local/$gittag $gittag && :
    git submodule update
    git submodule foreach 'git checkout . && git clean -fd'

    common_options="toolset=$toolset threading=multi address-model=64 link=static,shared"
    common_path="$boost_version/$toolset_name"
    set +x

    ./b2 headers
    variants=('debug' 'release')
    for v in ${variants[@]}; do
        cpath_full="$common_path/$v"
        stagedir="stage/$cpath_full"
        prefixdir="$prefix/$cpath_full"
        ./b2 $dont -j 3 install \
            --stagedir="$stagedir" \
            --prefix="$prefixdir" \
            variant=$v \
            $common_options
    done
}

compile gcc gcc-4.8 1.59.0 "/opt/local/boost"
