#!/bin/bash -e

VERSION="2025.10-2-g4e16f48"
DATEC="1.20260107.0"

package_name="bbb.io-gateware"
debian_pkg_name="${package_name}"
package_version="1.20260116.0"
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

trixie_version="~trixie+20260116"
forky_version="~forky+20260116"
noble_version="~noble+20260116"
