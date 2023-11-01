#!/bin/bash -e

package_name="bbb.io-gateware"
debian_pkg_name="${package_name}"
package_version="1.20231101.0"
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

sid_version="~sid+20231101"
lunar_version="~lunar+20231101"
mantic_version="~mantic+20231101"
