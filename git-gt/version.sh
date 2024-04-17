#!/bin/bash -e

#https://github.com/linux-usb-gadgets/gt

package_name="gt"
debian_pkg_name="${package_name}"
package_version="0.0.0-git20240228.2"
package_source="${package_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}_${package_version}"

git_repo="https://github.com/linux-usb-gadgets/gt"
git_sha="01243da097374fea3668751d7ee2129a7e312f24"
reprepro_dir="g/${package_name}"
dl_path=""

debian_version="${package_version}-0"
debian_patch=""
debian_diff=""

clear_changelog="enable"

sid_version="~sid+20240417"
lunar_version="~lunar+20240417"
mantic_version="~mantic+20240417"
noble_version="~noble+20240417"
