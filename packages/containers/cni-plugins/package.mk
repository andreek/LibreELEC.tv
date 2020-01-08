# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cni-plugins"
PKG_VERSION="0.8.3"
PKG_SHA256="17dc1f2bf287506f38600fef78b44862fdc606316d296542461e7521f8c77f76"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/containernetworking/plugins"
PKG_URL="https://github.com/containernetworking/plugins/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="todo"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  case $TARGET_ARCH in
    x86_64)
      export GOARCH=amd64
      ;;
    arm)
      export GOARCH=arm

      case $TARGET_CPU in
        arm1176jzf-s)
          export GOARM=6
          ;;
        *)
          export GOARM=7
          ;;
      esac
      ;;
    aarch64)
      export GOARCH=arm64
      ;;
  esac

  export GOOS=linux
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  mkdir -p $PKG_BUILD/.gopath
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor $PKG_BUILD/.gopath/src
  fi

  ln -fs $PKG_BUILD $PKG_BUILD/.gopath/src/github.com/containernetworking/plugins
}

make_target() {
  mkdir -p bin
  echo "Building plugins ${GOOS}"
  PLUGINS="plugins/meta/* plugins/main/* plugins/ipam/*"
  for d in $PLUGINS; do
   if [ -d "$d" ]; then
    plugin="$(basename "$d")"
    if [ $plugin != "windows" ]; then
     echo "  $plugin"
     $GOLANG build -o "bin/$plugin" "$@" ./$d
    fi
   fi
  done
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  PLUGINS="plugins/meta/* plugins/main/* plugins/ipam/*"
  for d in $PLUGINS; do
   if [ -d "$d" ]; then
    plugin="$(basename "$d")"
    if [ $plugin != "windows" ]; then
     echo "  $plugin"
     cp $PKG_BUILD/bin/$plugin $INSTALL/usr/bin
    fi
   fi
  done
}

