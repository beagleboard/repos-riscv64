#!/bin/bash

dl_src () {
	if [ -d ./src/ ] ; then
		rm -rf ./src/
	fi

	git clone git@git.beagleboard.org:beaglev-ahead/beaglev-ahead-factory.git ./src/
}

copy_all () {
	cp -v ./src/beagle-* ./suite/lunar/debian/
	cp -v ./src/test_* ./suite/lunar/debian/
	cp -v ./src/beagle-* ./suite/sid/debian/
	cp -v ./src/test_* ./suite/sid/debian/
}

dl_src

copy_all
