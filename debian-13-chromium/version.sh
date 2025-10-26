#!/bin/bash -e

#http://192.168.1.10/debian/pool/main/c/chromium/
#https://packages.debian.org/source/trixie/chromium

mirror="http://192.168.1.10/debian"

package_name="chromium"
debian_pkg_name="${package_name}"
package_version="141.0.7390.107"
package_source="${debian_pkg_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}-${package_version}"

git_repo=""
git_sha=""
reprepro_dir="c/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-1~deb13u1"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio3"

trixie_version="~trixie+20251026"
