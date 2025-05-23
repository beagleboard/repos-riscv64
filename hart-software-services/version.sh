#!/bin/bash -e

package_name="hart-software-services"
debian_pkg_name="${package_name}"
package_version="2023.02"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="h/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""
local_patch="bbbio1"

clear_changelog="enable"

sid_version="~sid+20231227"
lunar_version="~lunar+20231227"
mantic_version="~mantic+20231227"
noble_version="~noble+20231227"
