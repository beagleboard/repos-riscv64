#!/bin/bash -e

VERSION="BVF-0.5.1-50-g00f6c5d"
DATEC="1.20250701.0"

package_name="bbb.io-gateware"
debian_pkg_name="${package_name}"
package_version="1.20250701.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

debian_dl_1="http://forgejo.gfnd.rcn-ee.org:3000/BeagleBoard.org/gateware-snapshots/raw/branch/main/${VERSION}/bbb.io-gateware_${DATEC}-0~noble_all.deb"

clear_changelog="enable"

trixie_version="~trixie+20250701"
noble_version="~noble+20250701"
