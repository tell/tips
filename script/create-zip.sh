#!/usr/bin/env bash

set -x
set -f

while getopts "ht:o:" flag;
do
case $flag in
	h) echo $0 -t TARGET -o OUTPUT
	exit 0;;
	t) targetdir="$OPTARG";;
	o) archivename="$OPTARG";;
    x) excludes="$OPTARG";;
esac
done

zipcmd="zip -qr"
zipflags="-x *~ -x *.gitignore -x *.DS_Store -x *.blg -x .omakedb* -x *.omc -x *.log -x *.swp -x *.pyc"

if [ -n "${targetdir}" -a -n "${archivename}" ]; then
	cd ./${targetdir} || exit 1
	${zipcmd} ${zipflags} -o "../"${archivename} .
else
	exit 1;
fi

