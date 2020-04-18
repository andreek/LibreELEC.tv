PKG_NAME="ostree"
PKG_VERSION="2019.6"
PKG_SHA256="1c487f38dc108b91eff1eecd1a27fe6de4a8d88202f65e9a36cd1fa312cd0975"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ostreedev/ostree"
PKG_URL="https://github.com/ostreedev/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain avahi gpgme libarchive openssl libseccomp glib zlib fuse e2fsprogs bzip2"
PKG_LONGDESC="TODO"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  echo "COPY libglnx"
  rm -rf $PKG_BUILD/libglnx
  rm -rf $PKG_BUILD/bsdiff
  cp -r $PKG_DIR/libglnx $PKG_BUILD/libglnx
  cp -r $PKG_DIR/bsdiff $PKG_BUILD/bsdiff
  NOCONFIGURE=1 ./autogen.sh
  ./configure --host=arm \
	--prefix=/usr \
	--with-mkinitcpio \
	--with-openssl \
	--with-builtin-grub2-mkconfig \
	--enable-experimental-api \
	--disable-man \
        --disable-static
}

make_target() {
	make
}

post_make_target() {
	make install DESTDIR=$INSTALL/
}
