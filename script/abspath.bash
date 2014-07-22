#!/bin/bash

abspath () {
        local d=$1
        [[ -z "${d}" ]] && d='.'
        echo $(cd $(dirname ${d}) && pwd)/$(basename ${d})
}

