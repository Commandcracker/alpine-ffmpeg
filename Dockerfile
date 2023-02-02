# ffmpeg - https://ffmpeg.org/download.html
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#

FROM alpine:3.17.1 AS base

RUN set -eux; \
        apk add --no-cache --update \
        libgcc \
        libstdc++ \
        ca-certificates \
        libcrypto1.1 \
        libssl1.1 \
        libgomp \
        expat \
        git

FROM base AS build

WORKDIR /tmp/workdir

ENV FFMPEG_VERSION=5.1.2 \
        AOM_VERSION=v3.5.0 \
        CHROMAPRINT_VERSION=1.5.1 \
        FDKAAC_VERSION=2.0.2 \
        FONTCONFIG_VERSION=2.12.4 \
        FREETYPE_VERSION=2.12.1 \
        FRIBIDI_VERSION=0.19.7 \
        KVAZAAR_VERSION=2.2.0 \
        LAME_VERSION=3.100 \
        # TODO: Update and build HarfBuzz
        LIBASS_VERSION=0.14.0 \
        LIBPTHREAD_STUBS_VERSION=0.4 \
        LIBVIDSTAB_VERSION=1.1.0 \
        LIBXCB_VERSION=1.15 \
        XCBPROTO_VERSION=1.15.2 \
        OGG_VERSION=1.3.4 \
        OPENCOREAMR_VERSION=0.1.6 \
        OPUS_VERSION=1.3.1 \
        OPENJPEG_VERSION=2.5.0 \
        THEORA_VERSION=1.1.1 \
        VORBIS_VERSION=1.3.7 \
        VPX_VERSION=1.12.0 \
        WEBP_VERSION=1.3.0 \
        X264_VERSION=baee400fa9ced6f5481a728138fed6e867b0ff7f \
        X265_VERSION=3.4 \
        XAU_VERSION=1.0.11 \
        XORG_MACROS_VERSION=1.19.3 \
        XPROTO_VERSION=7.0.31 \
        XVID_VERSION=1.3.7 \
        LIBXML2_VERSION=2.10.3 \
        LIBBLURAY_VERSION=1.3.4 \
        LIBZMQ_VERSION=4.3.4 \
        LIBSRT_VERSION=1.5.1 \
        LIBARIBB24_VERSION=1.0.3 \
        LIBPNG_VERSION=1.6.39 \
        LIBVMAF_VERSION=2.3.1 \
        SRC=/usr/local

ARG \
        FREETYPE_SHA512SUM="4f923c82121940e866022c1ee6afb97f447b83ab8b54188df169029f37589e3bad0768a3bfb3095982804db1eec582f05aa846dfb32639697e231af8d52676cc *.tar.gz" \
        FRIBIDI_SHA512SUM="c947b3154fa39543dda4d6b450de5ffc2f49a0404f38e48ee6fd31e0823b46c3c83d1538fdcbaefa729101598c877c9b3d9041b42a8665037753cb22c12049c4 *.tar.gz" \
        LIBASS_SHA512SUM="65c215127c2dea21b0be071fc205de9e3515eed707a737912cb12f07cfea2ed38aff8f58c131003fa1463e736d2ef56fc3b76d43213a22267c538a5aa4f4d9d7 *.tar.gz" \
        LIBVIDSTAB_SHA512SUM="e82a4b6dd854b8415952cc0a8bdea06c01ff40a497c8e98177831e29031ec535b9f47cc30d5444c47bfd91871615a1662e3991185e9eb179acf37ea601073cdf *.tar.gz" \
        OGG_SHA512SUM="aabe5de063a1963729ce0c055d538612d242b360d13f032d1508f0e82ad23f61d89d0b00386b358a87aba43317bb7a67b8e52361a41a079a1fc2bc6df61917d9 *.tar.gz" \
        OPUS_SHA512SUM="6cd5e4d8a0551ed5fb59488c07a5cc18a241d1fde5f9eb9f16cd4e77abcdb4134dd51ad1d737be1e6039bfa56912510b8648152f2478a1f21c7c1d9ce32933cd *.tar.gz" \
        THEORA_SHA512SUM="f20dda4b03f5e9c2eda0bf85dbc78046fa55227f81ee82ffde096ff07cd8a5b47ba42041c6958eb184b51f1c0c6ba763e1861601e10cfb918444a5a06bfea798 *.tar.gz" \
        VORBIS_SHA512SUM="8a83ac9e9197f32fad4430946dba3927921320492f9e96cda546e8eb3981e2664da97f77e43cb197577ec056437785168ca7c4138f8bf7f2ba93899846932eb2 *.tar.gz" \
        XVID_SHA512SUM="b66b1b0c9ddf4cc48fddd3afc1a8382b21e8bc7dc8a50220bcf1a86e6a2dab9abdcbd3dc64e27a054087f6770a4731468c301351d166c1a19e7f419b04ba7b9b *.tar.gz" \
        LIBBLURAY_SHA512SUM="94dbf3b68d1c23fe4648c153cc2f0c251886fac0a6b6bbe3a77caabaa5322682f712afe4a7b6b16ca3f06744fbc0e1ca872209a32898dcf0ae182055d335aec1 *.tar.bz2" \
        LIBZMQ_SHA512SUM="e198ef9f82d392754caadd547537666d4fba0afd7d027749b3adae450516bcf284d241d4616cad3cb4ad9af8c10373d456de92dc6d115b037941659f141e7c0e *.tar.gz" \
        LIBARIBB24_SHA512SUM="622cc0c3928fd6db0b5ab3921f27348c956af20f8c0133ad5d9bf4de3d199077d9f23cc86ae149a9f0d13c7ee5906ec95de3fb8388207160cebd1f0c59078c8f *.tar.gz" \
        LD_LIBRARY_PATH="/opt/ffmpeg/lib" \
        MAKEFLAGS="-j2" \
        PKG_CONFIG_PATH="/opt/ffmpeg/share/pkgconfig:/opt/ffmpeg/lib/pkgconfig:/opt/ffmpeg/lib64/pkgconfig" \
        PREFIX="/opt/ffmpeg" \
        LD_LIBRARY_PATH="/opt/ffmpeg/lib:/opt/ffmpeg/lib64" \
        # TODO: sha512sum all
        # _SHA512SUM=" *.tar.gz"
        VMAF_SHA512SUM="4854247bba4b323d08fa9ef4a082a08ed9ab1763dffbe0a1af2b594205e908f47dfb919d03a32e0bce77a40e33e4b2a2594e5d1e8e081379640d6abf279a129b *.tar.gz" \
        OPENCORE_AMR_SHA512SUM="8955169954b09d2d5e2190888602c75771b72455290db131ab7f40b587df32ea6a60f205126b09193b90064d0fd82b7d678032e2b4c684189788e175b83d0aa7 *.tar.gz" \
        X264_SHA512SUM="63ca9ee5f9fb4b39afc0d7ea682ec75c2e5332c2bac26fc6269d14f0e1f7f7b3e3c7b5664bb66247384c5eba1d7e1b8c5e8e2a547fbe2d81408dee345797e855 *.tar.bz2" \
        X265_SHA512SUM="17639324c9428087cda9cfa5b57bcb82403226ec5b4fc0da46028e0700452f7bb12df0f4f3a8fd5d70ebdd912ba7589bd99b01c9b7e0d4fa00424e1502580090 *.tar.gz"

RUN set -eux; \
        buildDeps="autoconf \
        automake \
        bash \
        binutils \
        bzip2 \
        cmake \
        coreutils \
        curl \
        diffutils \
        expat-dev \
        file \
        g++ \
        gcc \
        gperf \
        libtool \
        make \
        nasm \
        openssl-dev \
        python3 \
        tar \
        xcb-proto \
        yasm \
        zlib-dev \
        linux-headers \
        patch"; \
        apk add --no-cache --update ${buildDeps}

## libvmaf https://github.com/Netflix/vmaf
RUN set -eux; \
        if which meson || false; then \
        echo "Building VMAF."; \
        DIR=/tmp/vmaf; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/Netflix/vmaf/archive/v${LIBVMAF_VERSION}.tar.gz --output vmaf.tar.gz; \
        echo ${VMAF_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=vmaf.tar.gz; \
        cd /tmp/vmaf/libvmaf; \
        meson build --buildtype release --prefix=${PREFIX}; \
        ninja --verbose -C build; \
        ninja --verbose -C build install; \
        mkdir --parents ${PREFIX}/share/model/; \
        cp --recursive /tmp/vmaf/model/* ${PREFIX}/share/model/; \
        rm --recursive --force ${DIR}; \
        else \
        echo "VMAF skipped."; \
        fi

## opencore-amr https://sourceforge.net/projects/opencore-amr/
RUN set -eux; \
        DIR=/tmp/opencore-amr; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://sourceforge.net/projects/opencore-amr/files/opencore-amr/opencore-amr-${OPENCOREAMR_VERSION}.tar.gz/download --output opencore_amr.tar.gz; \
        echo ${OPENCORE_AMR_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=opencore_amr.tar.gz; \
        ./configure --prefix="${PREFIX}" --enable-shared ; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## x264 https://www.videolan.org/developers/x264.html
RUN set -eux; \
        DIR=/tmp/x264; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://code.videolan.org/videolan/x264/-/archive/${X264_VERSION}/x264-stable.tar.bz2 --output x264.tar.bz2; \
        echo ${X264_SHA512SUM} | sha512sum --check; \
        tar --bzip2 --extract --strip-components=1 --file=x264.tar.bz2; \
        ./configure --prefix="${PREFIX}" --enable-shared --enable-pic --disable-cli; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### x265 https://www.x265.org/
RUN set -eux; \
        DIR=/tmp/x265; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/videolan/x265/archive/refs/tags/${X265_VERSION}.tar.gz --output x265.tar.gz; \
        echo ${X265_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --file=x265.tar.gz; \
        cd x265-${X265_VERSION}/build/linux; \
        sed -i "/-DEXTRA_LIB/ s/$/ -DCMAKE_INSTALL_PREFIX=\${PREFIX}/" multilib.sh; \
        sed -i "/^cmake/ s/$/ -DENABLE_CLI=OFF/" multilib.sh; \
        ./multilib.sh; \
        make --directory=8bit install; \
        rm --recursive --force ${DIR}

### libogg https://www.xiph.org/ogg/
RUN set -eux; \
        DIR=/tmp/ogg; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz --output libogg.tar.gz; \
        echo ${OGG_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libogg.tar.gz; \
        ./configure --prefix="${PREFIX}" --enable-shared ; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libopus https://www.opus-codec.org/
RUN set -eux; \
        DIR=/tmp/opus; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://archive.mozilla.org/pub/opus/opus-${OPUS_VERSION}.tar.gz --output opus.tar.gz; \
        echo ${OPUS_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=opus.tar.gz; \
        autoreconf -fiv; \
        ./configure --prefix="${PREFIX}" --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libvorbis https://xiph.org/vorbis/
RUN set -eux; \
        DIR=/tmp/vorbis; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz --output vorbis.tar.gz; \
        echo ${VORBIS_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=vorbis.tar.gz; \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libtheora https://www.theora.org/
RUN set -eux; \
        DIR=/tmp/theora; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.gz --output theora.tar.gz; \
        echo ${THEORA_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=theora.tar.gz; \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libvpx https://www.webmproject.org/code/
RUN set -eux; \
        DIR=/tmp/vpx; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
        tar -zx --strip-components=1; \
        ./configure --prefix="${PREFIX}" --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-pic --enable-shared \
        --disable-debug --disable-examples --disable-docs --disable-install-bins ; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libwebp https://developers.google.com/speed/webp/
RUN set -eux; \
        DIR=/tmp/vebp; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${WEBP_VERSION}.tar.gz | \
        tar -zx --strip-components=1; \
        ./configure --prefix="${PREFIX}" --enable-shared ; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libmp3lame https://lame.sourceforge.io/
RUN set -eux; \
        DIR=/tmp/lame; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://sourceforge.net/projects/lame/files/lame/${LAME_VERSION}/lame-${LAME_VERSION}.tar.gz/download | \
        tar -zx --strip-components=1; \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --disable-frontend; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### xvid https://www.xvid.com/
RUN set -eux; \
        DIR=/tmp/xvid; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://downloads.xvid.com/downloads/xvidcore-${XVID_VERSION}.tar.gz; \
        echo ${XVID_SHA512SUM} | sha512sum --check; \
        tar -zx -f xvidcore-${XVID_VERSION}.tar.gz; \
        cd xvidcore/build/generic; \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### fdk-aac https://github.com/mstorsjo/fdk-aac
RUN set -eux; \
        DIR=/tmp/fdk-aac; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1; \
        autoreconf -fiv; \
        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## openjpeg https://github.com/uclouvain/openjpeg
RUN set -eux; \
        DIR=/tmp/openjpeg; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | \
        tar -zx --strip-components=1; \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## freetype https://www.freetype.org/
RUN set -eux; \
        DIR=/tmp/freetype; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz; \
        echo ${FREETYPE_SHA512SUM} | sha512sum --check; \
        tar -zx --strip-components=1 -f freetype-${FREETYPE_VERSION}.tar.gz; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libvstab https://github.com/georgmartius/vid.stab
RUN set -eux; \
        DIR=/tmp/vid.stab; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz; \
        echo ${LIBVIDSTAB_SHA512SUM} | sha512sum --check;  \
        tar -zx --strip-components=1 -f v${LIBVIDSTAB_VERSION}.tar.gz; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## fridibi https://www.fribidi.org/
RUN set -eux; \
        DIR=/tmp/fribidi; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/fribidi/fribidi/archive/${FRIBIDI_VERSION}.tar.gz; \
        echo ${FRIBIDI_SHA512SUM} | sha512sum --check; \
        tar -zx --strip-components=1 -f ${FRIBIDI_VERSION}.tar.gz; \
        sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib bin/' Makefile.am; \
        ./bootstrap --no-config --auto; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make -j1; \
        make install; \
        rm --recursive --force ${DIR}

## fontconfig https://www.freedesktop.org/wiki/Software/fontconfig/
RUN set -eux; \
        DIR=/tmp/fontconfig; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2; \
        tar -jx --strip-components=1 -f fontconfig-${FONTCONFIG_VERSION}.tar.bz2; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libass https://github.com/libass/libass
RUN set -eux; \
        DIR=/tmp/libass; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz; \
        echo ${LIBASS_SHA512SUM} | sha512sum --check; \
        tar -zx --strip-components=1 -f ${LIBASS_VERSION}.tar.gz; \
        ./autogen.sh; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared --disable-harfbuzz; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## kvazaar https://github.com/ultravideo/kvazaar
RUN set -eux; \
        DIR=/tmp/kvazaar; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f v${KVAZAAR_VERSION}.tar.gz; \
        ./autogen.sh; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## aom https://aomedia.googlesource.com/aom
RUN set -eux; \
        DIR=/tmp/aom; \
        git clone --branch ${AOM_VERSION} --depth 1 https://aomedia.googlesource.com/aom ${DIR} ; \
        cd ${DIR} ; \
        rm -rf CMakeCache.txt CMakeFiles ; \
        mkdir -p ./aom_build ; \
        cd ./aom_build ; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 ..; \
        make ; \
        make install ; \
        rm --recursive --force ${DIR}

## libxcb (and supporting libraries) for screen capture https://xcb.freedesktop.org/
RUN set -eux; \
        DIR=/tmp/xorg-macros; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://www.x.org/archive/individual/util/util-macros-${XORG_MACROS_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f util-macros-${XORG_MACROS_VERSION}.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## xproto https://gitlab.freedesktop.org/xorg/proto/xproto
RUN set -eux; \
        DIR=/tmp/xproto; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://www.x.org/archive/individual/proto/xproto-${XPROTO_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f xproto-${XPROTO_VERSION}.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libXau https://gitlab.freedesktop.org/xorg/lib/libxau
RUN set -eux; \
        DIR=/tmp/libXau; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://www.x.org/archive/individual/lib/libXau-${XAU_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f libXau-${XAU_VERSION}.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## pthread-stubs https://gitlab.freedesktop.org/xorg/lib/pthread-stubs
RUN set -eux; \
        DIR=/tmp/libpthread-stubs; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://xcb.freedesktop.org/dist/libpthread-stubs-${LIBPTHREAD_STUBS_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f libpthread-stubs-${LIBPTHREAD_STUBS_VERSION}.tar.gz; \
        ./configure --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}


## libxcb-proto https://gitlab.freedesktop.org/xorg/proto/xcbproto
RUN set -eux; \
        DIR=/tmp/libxcb-proto; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/xcb-proto-${XCBPROTO_VERSION}/xcbproto-xcb-proto-${XCBPROTO_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f xcbproto-xcb-proto-${XCBPROTO_VERSION}.tar.gz; \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh; \
        ./configure --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libxcb https://gitlab.freedesktop.org/xorg/lib/libxcb
RUN set -eux; \
        DIR=/tmp/libxcb; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/libxcb-${LIBXCB_VERSION}/libxcb-libxcb-${LIBXCB_VERSION}.tar.gz; \
        tar -zx --strip-components=1 -f libxcb-libxcb-${LIBXCB_VERSION}.tar.gz; \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libxml2 - for libbluray
RUN set -eux; \
        DIR=/tmp/libxml2; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://github.com/GNOME/libxml2/archive/refs/tags/v${LIBXML2_VERSION}.tar.gz | \
        tar -xz --strip-components=1; \
        ./autogen.sh --prefix="${PREFIX}" --with-ftp=no --with-http=no --with-python=no; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libbluray - Requires libxml, freetype, and fontconfig
RUN set -eux; \
        DIR=/tmp/libbluray; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://download.videolan.org/pub/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.bz2; \
        echo ${LIBBLURAY_SHA512SUM} | sha512sum --check; \
        tar -jx --strip-components=1 -f libbluray-${LIBBLURAY_VERSION}.tar.bz2; \
        ./configure --prefix="${PREFIX}" --disable-examples --disable-bdjava-jar --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

ADD test-driver.patch /tmp/libzmq/test-driver.patch

## libzmq https://github.com/zeromq/libzmq/
RUN set -eux; \
        DIR=/tmp/libzmq; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://github.com/zeromq/libzmq/releases/download/v${LIBZMQ_VERSION}/zeromq-${LIBZMQ_VERSION}.tar.gz -o v${LIBZMQ_VERSION}.tar.gz; \
        echo ${LIBZMQ_SHA512SUM} | sha512sum --check; \
        tar -xz --strip-components=1 -f v${LIBZMQ_VERSION}.tar.gz; \
        ./autogen.sh; \
        ./configure --prefix="${PREFIX}" --disable-Werror; \
        patch --binary config/test-driver < test-driver.patch; \
        make; \
        make check; \
        make install; \
        rm --recursive --force ${DIR}

## libsrt https://github.com/Haivision/srt
RUN set -eux; \
        DIR=/tmp/srt; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/Haivision/srt/archive/v${LIBSRT_VERSION}.tar.gz; \
        tar -xz --strip-components=1 -f v${LIBSRT_VERSION}.tar.gz; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libpng
RUN set -eux; \
        DIR=/tmp/png; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        git clone https://git.code.sf.net/p/libpng/code ${DIR} -b v${LIBPNG_VERSION} --depth 1; \
        ./configure --prefix="${PREFIX}"; \
        make check; \
        make install; \
        rm --recursive --force ${DIR}

## libaribb24
RUN set -eux; \
        DIR=/tmp/b24; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sLO https://github.com/nkoriyama/aribb24/archive/v${LIBARIBB24_VERSION}.tar.gz; \
        echo ${LIBARIBB24_SHA512SUM} | sha512sum --check; \
        tar -xz --strip-components=1 -f v${LIBARIBB24_VERSION}.tar.gz; \
        autoreconf -fiv; \
        ./configure CFLAGS="-I${PREFIX}/include -fPIC" --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## Download ffmpeg https://ffmpeg.org/
RUN set -eux; \
        DIR=/tmp/ffmpeg; mkdir --parents ${DIR}; cd ${DIR}; \
        curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2; \
        tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2; \
        ./configure --disable-debug --disable-doc --disable-ffplay --enable-shared --enable-gpl --extra-libs=-ldl; \
        make; \
        make install

ADD ffmpeg5.patch /tmp/chromaprint/ffmpeg5.patch

## chromaprint https://github.com/acoustid/chromaprint
RUN \
        echo "Building Chromaprint."; \
        DIR=/tmp/chromaprint;\
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl -sL https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VERSION}/chromaprint-${CHROMAPRINT_VERSION}.tar.gz | tar -zx --strip-components=1; \
        patch --binary src/audio/ffmpeg_audio_reader.h < ffmpeg5.patch; \
        cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TOOLS=ON .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## Build ffmpeg https://ffmpeg.org/
RUN set -eux; \
        DIR=/tmp/ffmpeg; cd ${DIR}; \
        ./configure \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --enable-chromaprint \
        --enable-fontconfig \
        --enable-gpl \
        --enable-libaom \
        --enable-libaribb24 \
        --enable-libass \
        --enable-libbluray \
        --enable-libfdk_aac \
        --enable-libfreetype \
        --enable-libkvazaar \
        --enable-libmp3lame \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libsrt \
        --enable-libtheora \
        --enable-libvidstab \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxcb \
        --enable-libxvid \
        --enable-libzmq \
        --enable-nonfree \
        --enable-openssl \
        --enable-postproc \
        --enable-shared \
        --enable-small \
        --enable-version3 \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" \
        --extra-libs=-ldl \
        --extra-libs=-lpthread \
        --prefix="${PREFIX}"; \
        make clean; \
        make; \
        make install; \
        make tools/zmqsend; cp tools/zmqsend ${PREFIX}/bin/; \
        make distclean; \
        hash -r; \
        cd tools; \
        make qt-faststart; cp qt-faststart ${PREFIX}/bin/

RUN set -eux; \
        ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib/; \
        for lib in /usr/local/lib/*.so.*; do ln -s "${lib##*/}" "${lib%%.so.*}".so; done && \
        cp ${PREFIX}/bin/* /usr/local/bin/; \
        cp -r ${PREFIX}/share/ffmpeg /usr/local/share/; \
        LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf; \
        mkdir -p /usr/local/include; \
        cp -r ${PREFIX}/include/libav* ${PREFIX}/include/libpostproc ${PREFIX}/include/libsw* /usr/local/include; \
        mkdir -p /usr/local/lib/pkgconfig; \
        for pc in ${PREFIX}/lib/pkgconfig/libav*.pc ${PREFIX}/lib/pkgconfig/libpostproc.pc ${PREFIX}/lib/pkgconfig/libsw*.pc; do \
        sed "s:${PREFIX}:/usr/local:g" <"$pc" >/usr/local/lib/pkgconfig/"${pc##*/}"; \
        done

### Release Stage
FROM base AS release
LABEL org.opencontainers.image.authors="julien@rottenberg.info,Commandcracker" \
        org.opencontainers.image.source=https://github.com/Commandcracker/alpine-ffmpeg

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

CMD ["--help"]
ENTRYPOINT ["ffmpeg"]

COPY --from=build /usr/local /usr/local

# Let's make sure the app built correctly
# Convenient to verify on https://hub.docker.com/r/jrottenberg/ffmpeg/builds/ console output
