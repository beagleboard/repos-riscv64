#!/bin/bash -e

#https://packages.debian.org/source/bookworm/directx-headers
mirror="https://deb.debian.org/debian"

package_name="bc"
debian_pkg_name="${package_name}"
package_version="1.07.1"

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-3"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""

dist="debian"
suite="sid"
deb_arch="riscv64"
