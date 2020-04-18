# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="golang"
PKG_VERSION="1.13.5"
PKG_SHA256="27d356e2a0b30d9983b60a788cf225da5f914066b37a6b4f69d457ba55a626ff"
PKG_LICENSE="OSS"
PKG_SITE="http://www.golang.org/"
PKG_URL="https://dl.google.com/go/go${PKG_VERSION}.src.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Golang"
PKG_TOOLCHAIN="manual"

make_target() {
  cd src
  ./all.bash
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_BUILD/bin/go $INSTALL/usr/bin
}
