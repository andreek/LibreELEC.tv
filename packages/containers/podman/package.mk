# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="podman"
PKG_VERSION="1.6.3"
PKG_SHA256="61b44b739c485125f179044f7aa7dc58c820f771bce4ce495fa555a38dc68b57"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/containers/libpod/"
PKG_URL="https://github.com/containers/libpod/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host iptables libseccomp cni-plugins conmon crun ostree slirp4netns btrfs-progs"
PKG_LONGDESC="todo"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export GOARCH=arm
  export BUILDTAGS='seccomp ostree varlink containers_image_ostree_stub systemd'
  export CGO_LDFLAGS=$LDFLAGS
  export GOFLAGS="-trimpath"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin
  sed -i '/^LDFLAGS_PODMAN ?=/s/$(LDFLAGS)//' Makefile
}

make_target() {
  make podman
}

makeinstall_target() {
  make install PREFIX=$INSTALL/usr
}
