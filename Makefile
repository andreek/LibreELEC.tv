BUILD_DIRS=build.*

export PROJECT=RPi
export DEVICE=RPi2
export ARCH=arm
export DISTRO=custom

all: release

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

info:
	./scripts/info

noobs:
	./scripts/image noobs

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps

distclean:
	rm -rf ./.ccache ./$(BUILD_DIRS)

src-pkg:
	tar cvJf sources.tar.xz sources
