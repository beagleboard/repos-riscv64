#!/bin/bash -e

#https://github.com/linux-usb-gadgets/libusbgx

package_name="libusbgx"
debian_pkg_name="${package_name}"
package_version="0.2.0-git20210811.1"
package_source="${package_name}-${package_version}.orig.tar.xz"
src_dir="${package_name}-${package_version}"

git_repo="https://github.com/linux-usb-gadgets/libusbgx"
git_sha="fa4e7e92260e33f78b72e7796b3df28c4c84b8e2"
reprepro_dir="libu/${package_name}"
dl_path=""

debian_version="${package_version}-0"
debian_patch=""
debian_diff=""

bullseye_version="~bullseye+20210812"
sid_version="~sid+20210818"
