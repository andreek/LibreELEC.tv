# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="conmon"
PKG_VERSION="2.0.7"
PKG_SHA256="abe4e1cc02505c81857c1eeced008a24b4dd41659d42a1e3395754fb063aef36"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/containers/conmon"
PKG_URL="https://github.com/containers/conmon/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="todo"
PKG_TOOLCHAIN="manual"

make_target() {
  cd $PKG_BUILD
  make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/local/libexec/podman
  cp $PKG_BUILD/bin/conmon $INSTALL/usr/local/libexec/podman
}
