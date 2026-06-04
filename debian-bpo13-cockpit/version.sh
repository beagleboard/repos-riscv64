#!/bin/bash -e

mirror="https://deb.debian.org/debian"

package_name="cockpit"
debian_pkg_name="${package_name}"
package_version="362"

reprepro_dir="c/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-1~bpo13+1"

dist="debian-trixie-riscv64"
suite="trixie"
deb_arch="riscv64"

sbuild_options="nocheck"
