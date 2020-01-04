# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wireguard"
PKG_VERSION="0.0.20191012"
PKG_SHA256="93573193c9c1c22fde31eb1729ad428ca39da77a603a3d81561a9816ccecfa8e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.wireguard.com"
PKG_URL="https://git.zx2c4.com/WireGuard/snapshot/WireGuard-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux libmnl"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="The WireGuard VPN kernel module and tools"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KERNELDIR=$(kernel_path) -C src/ module tools
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_BUILD/src/tools/wg $INSTALL/usr/bin

  mkdir -p $INSTALL/usr

  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp src/*.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
