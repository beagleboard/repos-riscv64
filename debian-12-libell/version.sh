#!/bin/bash -e

#https://tracker.debian.org/pkg/wpa
#https://packages.debian.org/source/trixie/ell

mirror="http://http.debian.net/debian"

package_name="ell"
debian_pkg_name="${package_name}"
package_version="0.68"
package_source="${debian_pkg_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}-${package_version}"

git_repo=""
git_sha=""
reprepro_dir="e/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-1"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio0"

lunar_version="~lunar+20240903"
mantic_version="~mantic+20240903"
noble_version="~noble+20240903"
