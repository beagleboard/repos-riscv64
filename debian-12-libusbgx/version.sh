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

debian_version="${package_version}-2"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="bbbio0"

sid_version="~sid+20230817"
lunar_version="~lunar+20230817"
mantic_version="~mantic+20230817"
