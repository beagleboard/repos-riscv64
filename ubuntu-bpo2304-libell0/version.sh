#!/bin/bash -e

mirror="http://archive.ubuntu.com/ubuntu"

package_name="ell"
debian_pkg_name="${package_name}"
package_version="0.58"

git_repo=""
git_sha=""
reprepro_dir="e/${package_name}"
dl_path="pool/universe/${reprepro_dir}/"

debian_version="${package_version}-2"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""

dist="debian"
suite="lunar"
deb_arch="riscv64"
