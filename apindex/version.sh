#!/bin/bash -e

package_name="apindex"
debian_pkg_name="${package_name}"
package_version="2.2-1.20231128.1"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="a/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

clear_changelog="enable"

trixie_version="~trixie+20241205"
sid_version="~sid+20241205"
noble_version="~noble+20241205"
