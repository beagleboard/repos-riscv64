#!/bin/bash -e

#https://tracker.debian.org/pkg/wpa

mirror="http://http.debian.net/debian"

package_name="libusbgx"
debian_pkg_name="${package_name}"
package_version="0.2.0"
package_source="${debian_pkg_name}_${package_version}.orig.tar.gz"
src_dir="${package_name}-libusbgx-v${package_version}"

git_repo=""
git_sha=""
reprepro_dir="libu/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-3.1"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio2"

sid_version="~sid+20240417"
lunar_version="~lunar+20240417"
mantic_version="~mantic+20240417"
noble_version="~noble+20240417"
