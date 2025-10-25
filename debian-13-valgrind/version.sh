#!/bin/bash -e

#https://packages.debian.org/source/sid/valgrind

mirror="http://http.debian.net/debian"

package_name="valgrind"
debian_pkg_name="${package_name}"
epoch="1"
package_version="3.25.1"
package_source="${debian_pkg_name}_${package_version}.orig.tar.bz2"
src_dir="${package_name}-${package_version}"

git_repo=""
git_sha=""
reprepro_dir="v/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-3"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio0"

trixie_version="~trixie+20251025"
