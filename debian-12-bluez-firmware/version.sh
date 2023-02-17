#!/bin/bash -e

#https://tracker.debian.org/pkg/wpa

mirror="http://archive.ubuntu.com/ubuntu"

package_name="bluez-firmware"
debian_pkg_name="${package_name}"
package_version="1.2"
package_source="${debian_pkg_name}_${package_version}.orig.tar.gz"
src_dir="${package_name}-${package_version}"

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/multiverse/${reprepro_dir}/"

debian_version="${package_version}-9"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio1"

sid_version="~sid+20230217"
lunar_version="~lunar+20230217"
