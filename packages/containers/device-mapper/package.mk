PKG_NAME="device-mapper"
PKG_VERSION="2_03_07"
PKG_SHA256="87fa097faea3080cec2cdd9aa137a36c11e3e77639d7772234bb362e27ad2b43"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lvmteam/lvm2"
PKG_URL="https://github.com/lvmteam/lvm2/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TODO"
PKG_TOOLCHAIN="make"

pre_make_target() {
    export LIB_SUFFIX=so
  export LDFLAGS="-extld $C"
    cd $PKG_BUILD/
    ./configure --host=arm
}

make_target() {
	cd $PKG_BUILD
	#LDFLAGS="$LDFLAGS -l$PKG_BUILD/libdm/libdevmapper.so.1.02" make device-mapper
	make device-mapper
}
