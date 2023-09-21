#!/bin/bash -e

package_name="bb-wlan0-defaults"
debian_pkg_name="${package_name}"
package_version="1.20230921.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

clear_changelog="enable"

sid_version="~sid+20230921"
lunar_version="~lunar+20230921"
mantic_version="~mantic+20230921"
