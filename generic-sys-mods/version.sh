#!/bin/bash -e

package_name="generic-sys-mods"
debian_pkg_name="${package_name}"
package_version="1.20240706.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="g/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

clear_changelog="enable"

sid_version="~sid+20240706"
lunar_version="~lunar+20240706"
mantic_version="~mantic+20240706"
noble_version="~noble+20240706"
