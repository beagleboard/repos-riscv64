#!/bin/bash -e

VERSION="BVF-0.4.0-27-g7078de9"
DATEC="1.20231228.0"

package_name="bbb.io-gateware"
debian_pkg_name="${package_name}"
package_version="1.20231229.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

debian_dl_1="https://git.beagleboard.org/beaglev-fire/gateware-snapshots/-/raw/main/${VERSION}/bbb.io-gateware_${DATEC}-0~lunar_all.deb"

clear_changelog="enable"

sid_version="~sid+20231229"
lunar_version="~lunar+20231229"
mantic_version="~mantic+20231229"
noble_version="~noble+20231229"
