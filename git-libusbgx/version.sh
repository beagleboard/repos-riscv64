#!/bin/bash -e

#https://github.com/linux-usb-gadgets/libusbgx

package_name="libusbgx"
debian_pkg_name="${package_name}"
package_version="0.2.0-git20230728.0"
package_source="${package_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}_${package_version}"

git_repo="https://github.com/linux-usb-gadgets/libusbgx"
git_sha="3cc5af771cb049bbaf3d0a0ebf5d843b932ec9f8"
reprepro_dir="libu/${package_name}"
dl_path=""

debian_version="${package_version}-0"
debian_patch=""
debian_diff=""

clear_changelog="enable"

sid_version="~sid+20230817"
lunar_version="~lunar+20230817"
mantic_version="~mantic+20230817"
