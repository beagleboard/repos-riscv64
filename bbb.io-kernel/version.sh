#!/bin/bash -e

package_name="bbb.io-kernel"
debian_pkg_name="${package_name}"
package_version="1.20241107.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path=""

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

clear_changelog="enable"

trixie_version="~trixie+20241107"
lunar_version="~lunar+20241107"
mantic_version="~mantic+20241107"
noble_version="~noble+20241107"
