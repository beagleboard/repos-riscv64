#!/bin/bash

dl_src () {
	if [ -d ./src/ ] ; then
		rm -rf ./src/
	fi

	git clone https://git.beagleboard.org/beagleboard/usr-customizations.git ./src/
}

copy_dir () {
	cp -rv ./src${wdir}/* ./suite/sid/debian/
	cp -rv ./src${wdir}/* ./suite/lunar/debian/
	cp -rv ./src${wdir}/* ./suite/mantic/debian/
}

dl_src

wdir="/common/etc/bbb.io/templates/dev/bone/" ; copy_dir
