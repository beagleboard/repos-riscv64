#!/bin/bash -e

package_name="bbb.io-keyring"
debian_pkg_name="${package_name}"
package_version="1.20240926.0"
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

trixie_version="~trixie+20240926"
sid_version="~sid+20240926"
lunar_version="~lunar+20240926"
mantic_version="~mantic+20240926"
noble_version="~noble+20240926"
oracular_version="~oracular+20240926"
