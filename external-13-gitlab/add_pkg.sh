#!/bin/bash

base="/var/www/html/repos/"
outgoing="/var/www/html/farm/outgoing"

run () {
	#latest=$(apt-cache madison gitlab-runner | grep packages.gitlab.com | awk '{print $3}' | sort -V | tail -1)
	#echo "latest: ${latest}"
	#apt-get download gitlab-runner:${deb_arch}=${latest} || true
	#apt-get download gitlab-runner-helper-images=${latest} || true

	if [ -f ./gitlab-runner-helper-images.deb ] ; then
		rm ./gitlab-runner-helper-images.deb || true
	fi

	if [ -f ./gitlab-runner_riscv64.deb ] ; then
		rm ./gitlab-runner_riscv64.deb || true
	fi

	wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner-helper-images.deb
	wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_riscv64.deb

	sync
	if [ -f ./gitlab-runner_${deb_arch}.deb ] ; then
		if [ -f ./gitlab-runner-helper-images.deb ] ; then
			reprepro -b ${repo} -C main includedeb ${suite} ./gitlab-runner_${deb_arch}.deb
			reprepro -b ${repo} -C main includedeb ${suite} ./gitlab-runner-helper-images.deb
		fi
	fi
}

runner () {
	repo="${base}${dist}/"
	echo ${suite}
	run
}

start_run () {
	deb_arch="riscv64"

	dist="debian-trixie-riscv64"
	suite="trixie" ; runner
}

if [ ! -f /tmp/cron.lock ] ; then
	start_run
else
	echo "reprepro running"
fi
#
