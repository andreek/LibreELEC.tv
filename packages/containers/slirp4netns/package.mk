PKG_NAME="slirp4netns"
PKG_VERSION="0.4.3"
PKG_SHA256="d699bc28a031512ed4fe13ca5a812dbc00415a61d7444a41bac2da6b62f9c53a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rootless-containers/$PKG_NAME"
PKG_URL="https://github.com/rootless-containers/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib glibc libcap libseccomp"
PKG_LONGDESC="TODO"
PKG_TOOLCHAIN="autotools"

pre_make_target() {
	export LDFLAGS="-static"
}
