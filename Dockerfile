# ffmpeg - https://ffmpeg.org/download.html
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#

FROM alpine:3.17.3 AS base

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

ENV \
        FFMPEG_VERSION=6.0 \
        AOM_VERSION=3.6.0 \
        CHROMAPRINT_VERSION=1.5.1 \
        FDKAAC_VERSION=2.0.2 \
        FONTCONFIG_VERSION=2.14.2 \
        FREETYPE_VERSION=2.13.0 \
        FRIBIDI_VERSION=1.0.12 \
        KVAZAAR_VERSION=2.2.0 \
        LAME_VERSION=3.100 \
        # TODO: Update and build HarfBuzz
        LIBASS_VERSION=0.14.0 \
        LIBPTHREAD_STUBS_VERSION=0.4 \
        LIBVIDSTAB_VERSION=1.1.0 \
        LIBXCB_VERSION=1.15 \
        XCBPROTO_VERSION=1.15.2 \
        OGG_VERSION=1.3.5 \
        OPENCOREAMR_VERSION=0.1.6 \
        OPUS_VERSION=1.4 \
        OPENJPEG_VERSION=2.5.0 \
        THEORA_VERSION=1.1.1 \
        VORBIS_VERSION=1.3.7 \
        VPX_VERSION=1.13.0 \
        WEBP_VERSION=1.3.0 \
        # https://code.videolan.org/videolan/x264/-/commit/baee400fa9ced6f5481a728138fed6e867b0ff7f
        X264_VERSION=baee400fa9ced6f5481a728138fed6e867b0ff7f \
        X265_VERSION=3.4 \
        XAU_VERSION=1.0.11 \
        XORG_MACROS_VERSION=1.20.0 \
        XPROTO_VERSION=7.0.31 \
        XVID_VERSION=1.3.7 \
        LIBXML2_VERSION=2.11.2 \
        LIBBLURAY_VERSION=1.3.4 \
        LIBZMQ_VERSION=4.3.4 \
        LIBSRT_VERSION=1.5.1 \
        LIBARIBB24_VERSION=1.0.3 \
        LIBPNG_VERSION=1.6.39 \
        LIBVMAF_VERSION=2.3.1 \
        SRC=/usr/local

ARG \
        LD_LIBRARY_PATH="/opt/ffmpeg/lib" \
        MAKEFLAGS="-j2" \
        PKG_CONFIG_PATH="/opt/ffmpeg/share/pkgconfig:/opt/ffmpeg/lib/pkgconfig:/opt/ffmpeg/lib64/pkgconfig" \
        PREFIX="/opt/ffmpeg" \
        LD_LIBRARY_PATH="/opt/ffmpeg/lib:/opt/ffmpeg/lib64" \
        \
        AOM_SHA512SUM="f751af4edf83082e23efafee1964465e75bc992302f8add87387eec2ea1bff263d7fc01dff9b86eda03579a6e71da7612ae2e1782399b0f50de2c69cc3a21ca2  -" \
        FREETYPE_SHA512SUM="0d2bfc3980313e1578b69568394666e1721c11dfdb47f21cb46ced48d0afcc674e175391ee0f64ffbcee814cded2d9a8fe6273029253c1adf642078ac8c0dd73 *.tar.gz" \
        FRIBIDI_SHA512SUM="a3a63e1dde1cffb097376df0b34522700cff600da61bdafd6f4f50db6937383b9f73a82081cb1a7f2e1946ba07fea13e2880a4250b1508850bffa500046a7fa5 *.tar.gz" \
        LIBASS_SHA512SUM="65c215127c2dea21b0be071fc205de9e3515eed707a737912cb12f07cfea2ed38aff8f58c131003fa1463e736d2ef56fc3b76d43213a22267c538a5aa4f4d9d7 *.tar.gz" \
        LIBVIDSTAB_SHA512SUM="e82a4b6dd854b8415952cc0a8bdea06c01ff40a497c8e98177831e29031ec535b9f47cc30d5444c47bfd91871615a1662e3991185e9eb179acf37ea601073cdf *.tar.gz" \
        OGG_SHA512SUM="e4d798621bb04a62dcb831e58a444357635ab3bcb9efbdffa009cb0be1cafb5e72bf71cbcad5305aa5268a92076a03a7e564a19c0c8d54b93a05d9b03ad2da6b *.tar.gz" \
        OPUS_SHA512SUM="1ecd39e0add24de12823bf7c936bb67441228721e2cdae0edbfcf3cee0894bcc6edf2a1d0ca5cdfdad1565803bf39cc4c985ad32710c2a9582f850adeb5ca631 *.tar.gz" \
        THEORA_SHA512SUM="f20dda4b03f5e9c2eda0bf85dbc78046fa55227f81ee82ffde096ff07cd8a5b47ba42041c6958eb184b51f1c0c6ba763e1861601e10cfb918444a5a06bfea798 *.tar.gz" \
        VORBIS_SHA512SUM="8a83ac9e9197f32fad4430946dba3927921320492f9e96cda546e8eb3981e2664da97f77e43cb197577ec056437785168ca7c4138f8bf7f2ba93899846932eb2 *.tar.gz" \
        XVID_SHA512SUM="b66b1b0c9ddf4cc48fddd3afc1a8382b21e8bc7dc8a50220bcf1a86e6a2dab9abdcbd3dc64e27a054087f6770a4731468c301351d166c1a19e7f419b04ba7b9b *.tar.gz" \
        LIBBLURAY_SHA512SUM="94dbf3b68d1c23fe4648c153cc2f0c251886fac0a6b6bbe3a77caabaa5322682f712afe4a7b6b16ca3f06744fbc0e1ca872209a32898dcf0ae182055d335aec1 *.tar.bz2" \
        LIBZMQ_SHA512SUM="e198ef9f82d392754caadd547537666d4fba0afd7d027749b3adae450516bcf284d241d4616cad3cb4ad9af8c10373d456de92dc6d115b037941659f141e7c0e *.tar.gz" \
        LIBARIBB24_SHA512SUM="622cc0c3928fd6db0b5ab3921f27348c956af20f8c0133ad5d9bf4de3d199077d9f23cc86ae149a9f0d13c7ee5906ec95de3fb8388207160cebd1f0c59078c8f *.tar.gz" \
        VMAF_SHA512SUM="4854247bba4b323d08fa9ef4a082a08ed9ab1763dffbe0a1af2b594205e908f47dfb919d03a32e0bce77a40e33e4b2a2594e5d1e8e081379640d6abf279a129b *.tar.gz" \
        OPENCORE_AMR_SHA512SUM="8955169954b09d2d5e2190888602c75771b72455290db131ab7f40b587df32ea6a60f205126b09193b90064d0fd82b7d678032e2b4c684189788e175b83d0aa7 *.tar.gz" \
        X264_SHA512SUM="63ca9ee5f9fb4b39afc0d7ea682ec75c2e5332c2bac26fc6269d14f0e1f7f7b3e3c7b5664bb66247384c5eba1d7e1b8c5e8e2a547fbe2d81408dee345797e855 *.tar.bz2" \
        X265_SHA512SUM="17639324c9428087cda9cfa5b57bcb82403226ec5b4fc0da46028e0700452f7bb12df0f4f3a8fd5d70ebdd912ba7589bd99b01c9b7e0d4fa00424e1502580090 *.tar.gz" \
        VPX_SHA512SUM="686cb526b46d5a054d35263b24f54e977149a244e97c95bcdd9aba2d75e045b2d51be2b7f9754302826b4c5450ee2f177f440b41c04c83b8b1661f1c14301c60 *.tar.gz" \
        VEDP_SHA512SUM="5af6999654e9ba3189574158c194396e3ad7b7d5061abf2711a7c93558a5898cd99adccd1c051e9a7910beb915fba8e703d33e7b6f06753b6f68c009c0e0d2bc *.tar.gz" \
        LAME_SHA512SUM="0844b9eadb4aacf8000444621451277de365041cc1d97b7f7a589da0b7a23899310afd4e4d81114b9912aa97832621d20588034715573d417b2923948c08634b *.tar.gz" \
        FDK_AAC_SHA512SUM="616207e85035d1659a2b7808ca6ec02ef53c1c4b39eb280fe861f82a4cf548e5db2ac381c496bad37dfc2b8c6677fe704d9fd8449e43d1f93d3e636239e0191b *.tar.gz" \
        OPENJPEG_SHA512SUM="08975a2dd79f1e29fd1824249a5fbe66026640ed787b3a3aa8807c2c69f994240ff33e2132f8bf15bbc2202bef7001f98e42d487231d4eebc8e503538658049a *.tar.gz" \
        FONTCONFIG_SHA512SUM="73287cc3f8f8261a27c2920b0f9430dd6e3ac8733fb2ba55e1b5934cee211023b6415e1d14ddad04ef3c7819727ed34d80aa503d2734bdfc2f1c733c4096463f *.tar.gz" \
        KVAZAAR_SHA512SUM="476abe251d7f555911851bc5a7dca84a96c0cd243c6a45dd59b808b8adf2b0787f69101a061bd48dfb6fe54a0aea046417f21fc826f14f518cada25c6d22aec4 *.tar.gz" \
        XORG_MACROS_SHA512SUM="0724cf57cbf00fe115596457bf2031cdad5845bebdcc1ee4ff90b4f77b4ebc862b0f7d250272ef58c2929aedead3d18d11f23f067e50fcac22863a1fcd4f3d66 *.tar.gz" \
        XPROTO_SHA512SUM="efc583809c8fec8cee36873310658fb15edd54edf0117b7012b224ff3d38934731bed15cec3eddf0bf896035559b1a3eb4939f7d6a4e5ad8dfe2a3f1b2299230 *.tar.gz" \
        LIBXAU_SHA512SUM="315625ae6657e817c09c83da53029488bd5140bc1048eef1072b12958457fdec6c41f79b190cf10885559d2e4c7d47110cd08369b438ca47749790c51edd8492 *.tar.gz" \
        LIBPTHREAD_STUBS_SHA512SUM="5293c847f5d0c47a6956dd85b6630866f717e51e1e9c48fa10f70aa1e8268adc778eaf92504989c5df58c0dcde656f036248993b0ea5f79d4303012bfeff3c72 *.tar.gz" \
        LIBXCB_PROTO_SHA512SUM="eee19e38ea9d62d2cb7e351dbff4057e357718c3f429cf0458909518db3652eba89f02587a58a17ee542cbdebecf898383f27676a54a4c13eb7c8b50246677de *.tar.gz" \
        FFMPEG_SHA512SUM="c3e9ac1d59bb91ce4702e98d301de9a577a3894a44b1ec64f14b75843282f0cc66a1fbe345ad34e294728919d10552cbbd637685a07f6f6d64344d1536a21d9f *.tar.bz2" \
        LIBXCB_SHA512SUM="7f4d176e4bcd2e8e99ed7d3b0c03c28682610c695e0d995bda8677ab5835871352df11a8d3f460eb805d9ac1241237efe5f1bd4777a605b3827ee9c8b17e4456 *.tar.gz" \
        SRT_SHA512SUM="f3aa1f7773540e2dd31cd19b124eec3c3d830f59c08d953cae01e129a58db7e639bdf94c8a5a678435ae9a1d2402e2c77196fc9c4e75b42aa37d8eafcc16f436 *.tar.gz" \
        CHROMAPRINT_SHA512SUM="ea16e4d2b879c15b1d9b9ec93878da8b893f1834c70942663e1d2d106c2e0a661094fe2dd3bae7a6c2a1f9d5d8fab5e0b0ba493561090cf57b2228606fad1e66 *.tar.gz" \
        LIBXML2_SHA512SUM="7c64352192deede55b62992f8a7acfc7f0a376eadeac40cec7c6a20bbb733b90e291f8d5bf6c819b6709650e6929848e29ebfbf960507d62ea2d8598c66ff70d *.tar.gz" \
        PNG_SHA512SUM="19851afffbe2ffde62d918f7e9017dec778a7ce9c60c75cdc65072f086e6cdc9d9895eb7b207535a84cb5f4ead77ebc2aa9d80025f153662903023e1f7ab9bae *.tar.gz"

RUN set -eux; \
        apk add --no-cache --update \
        autoconf \
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
        patch

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
        curl --silent --location https://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz --output opus.tar.gz; \
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
        curl --silent --location https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} --output vpx.tar.gz; \
        echo ${VPX_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=vpx.tar.gz; \
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
        curl --silent --location https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${WEBP_VERSION}.tar.gz --output vebp.tar.gz; \
        echo ${VEDP_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=vebp.tar.gz; \
        ./configure --prefix="${PREFIX}" --enable-shared ; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### libmp3lame https://lame.sourceforge.io/
RUN set -eux; \
        DIR=/tmp/lame; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://sourceforge.net/projects/lame/files/lame/${LAME_VERSION}/lame-${LAME_VERSION}.tar.gz/download --output lame.tar.gz; \
        echo ${LAME_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=lame.tar.gz; \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --disable-frontend; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

### xvid https://www.xvid.com/
RUN set -eux; \
        DIR=/tmp/xvid; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://downloads.xvid.com/downloads/xvidcore-${XVID_VERSION}.tar.gz --output xvid.tar.gz; \
        echo ${XVID_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --file=xvid.tar.gz; \
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
        curl --silent --location https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz --output fdk_aac.tar.gz; \
        echo ${FDK_AAC_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=fdk_aac.tar.gz; \
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
        curl --silent --location https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz --output openjpeg.tar.gz; \
        echo ${OPENJPEG_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=openjpeg.tar.gz; \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## freetype https://www.freetype.org/
RUN set -eux; \
        DIR=/tmp/freetype; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent https://mirrors.sarata.com/non-gnu/freetype/freetype-${FREETYPE_VERSION}.tar.gz --output freetype.tar.gz; \
        echo ${FREETYPE_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=freetype.tar.gz; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libvstab https://github.com/georgmartius/vid.stab
RUN set -eux; \
        DIR=/tmp/vid.stab; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz --output vid.stab.tar.gz; \
        echo ${LIBVIDSTAB_SHA512SUM} | sha512sum --check;  \
        tar --ungzip --extract --strip-components=1 --file=vid.stab.tar.gz; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## fridibi https://www.fribidi.org/
RUN set -eux; \
        DIR=/tmp/fribidi; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/fribidi/fribidi/archive/v${FRIBIDI_VERSION}.tar.gz --output fribidi.tar.gz; \
        echo ${FRIBIDI_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=fribidi.tar.gz; \
        autoreconf -fiv; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make -j1; \
        make install; \
        rm --recursive --force ${DIR}

## fontconfig https://gitlab.freedesktop.org/fontconfig/fontconfig
RUN set -eux; \
        DIR=/tmp/fontconfig; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.gz --output fontconfig.tar.gz; \
        echo ${FONTCONFIG_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=fontconfig.tar.gz; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libass https://github.com/libass/libass
RUN set -eux; \
        DIR=/tmp/libass; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz --output libass.tar.gz; \
        echo ${LIBASS_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libass.tar.gz; \
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
        curl --silent --location https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz --output kvazaar.tar.gz; \
        echo ${KVAZAAR_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=kvazaar.tar.gz; \
        ./autogen.sh; \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## aom https://aomedia.googlesource.com/aom
RUN set -eux; \
        DIR=/tmp/aom; \
        git clone --branch v${AOM_VERSION} --depth 1 https://aomedia.googlesource.com/aom ${DIR}; \
        cd ${DIR}; \
        if [[ "${AOM_SHA512SUM}" != "$(sha512sum $(git ls-files) | sha512sum)" ]]; \
        then echo "computed checksum did NOT match"; exit 1; \
        else echo "computed checksum match"; fi; \
        rm --recursive --force CMakeCache.txt CMakeFiles; \
        mkdir --parents ./aom_build; \
        cd ./aom_build; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 ..; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libxcb (and supporting libraries) for screen capture https://xcb.freedesktop.org/
RUN set -eux; \
        DIR=/tmp/xorg-macros; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://www.x.org/archive/individual/util/util-macros-${XORG_MACROS_VERSION}.tar.gz --output xorg_macros.tar.gz; \
        echo ${XORG_MACROS_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=xorg_macros.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## xproto https://gitlab.freedesktop.org/xorg/proto/xproto
RUN set -eux; \
        DIR=/tmp/xproto; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://www.x.org/archive/individual/proto/xproto-${XPROTO_VERSION}.tar.gz --output xproto.tar.gz; \
        echo ${XPROTO_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=xproto.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libXau https://gitlab.freedesktop.org/xorg/lib/libxau
RUN set -eux; \
        DIR=/tmp/libXau; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://www.x.org/archive/individual/lib/libXau-${XAU_VERSION}.tar.gz --output libXau.tar.gz; \
        echo ${LIBXAU_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libXau.tar.gz; \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## pthread-stubs https://gitlab.freedesktop.org/xorg/lib/pthread-stubs
RUN set -eux; \
        DIR=/tmp/libpthread-stubs; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://xcb.freedesktop.org/dist/libpthread-stubs-${LIBPTHREAD_STUBS_VERSION}.tar.gz --output libpthread_stubs.tar.gz; \
        echo ${LIBPTHREAD_STUBS_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libpthread_stubs.tar.gz; \
        ./configure --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libxcb-proto https://gitlab.freedesktop.org/xorg/proto/xcbproto
RUN set -eux; \
        DIR=/tmp/libxcb-proto; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://gitlab.freedesktop.org/xorg/proto/xcbproto/-/archive/xcb-proto-${XCBPROTO_VERSION}/xcbproto-xcb-proto-${XCBPROTO_VERSION}.tar.gz --output libxcb_proto.tar.gz; \
        echo ${LIBXCB_PROTO_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libxcb_proto.tar.gz; \
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
        curl --silent --location https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/libxcb-${LIBXCB_VERSION}/libxcb-libxcb-${LIBXCB_VERSION}.tar.gz --output libxcb.tar.gz; \
        echo ${LIBXCB_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libxcb.tar.gz; \
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
        curl --silent --location https://github.com/GNOME/libxml2/archive/refs/tags/v${LIBXML2_VERSION}.tar.gz --output libxml2.tar.gz; \
        echo ${LIBXML2_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libxml2.tar.gz; \
        ./autogen.sh --prefix="${PREFIX}" --with-ftp=no --with-http=no --with-python=no; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libbluray - Requires libxml, freetype, and fontconfig
RUN set -eux; \
        DIR=/tmp/libbluray; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://download.videolan.org/pub/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.bz2 --output libbluray.tar.bz2; \
        echo ${LIBBLURAY_SHA512SUM} | sha512sum --check; \
        tar --bzip2 --extract --strip-components=1 --file=libbluray.tar.bz2; \
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
        curl --silent --location https://github.com/zeromq/libzmq/releases/download/v${LIBZMQ_VERSION}/zeromq-${LIBZMQ_VERSION}.tar.gz --output libzmq.tar.gz; \
        echo ${LIBZMQ_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=libzmq.tar.gz; \
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
        curl --silent --location https://github.com/Haivision/srt/archive/v${LIBSRT_VERSION}.tar.gz --output srt.tar.gz; \
        echo ${SRT_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=srt.tar.gz; \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## libpng
RUN set -eux; \
        DIR=/tmp/png; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://download.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz --output png.tar.gz; \
        echo ${PNG_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=png.tar.gz; \
        ./configure --prefix="${PREFIX}"; \
        make check; \
        make install; \
        rm --recursive --force ${DIR}

## libaribb24
RUN set -eux; \
        DIR=/tmp/b24; \
        mkdir --parents ${DIR}; \
        cd ${DIR}; \
        curl --silent --location https://github.com/nkoriyama/aribb24/archive/v${LIBARIBB24_VERSION}.tar.gz --output b24.tar.gz; \
        echo ${LIBARIBB24_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=b24.tar.gz; \
        autoreconf -fiv; \
        ./configure CFLAGS="-I${PREFIX}/include -fPIC" --prefix="${PREFIX}"; \
        make; \
        make install; \
        rm --recursive --force ${DIR}

## Download ffmpeg https://ffmpeg.org/
RUN set -eux; \
        DIR=/tmp/ffmpeg; mkdir --parents ${DIR}; cd ${DIR}; \
        curl --silent --location https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 --output ffmpeg.tar.bz2; \
        echo ${FFMPEG_SHA512SUM} | sha512sum --check; \
        tar --bzip2 --extract --strip-components=1 --file=ffmpeg.tar.bz2; \
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
        curl --silent --location https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VERSION}/chromaprint-${CHROMAPRINT_VERSION}.tar.gz --output chromaprint.tar.gz;\
        echo ${CHROMAPRINT_SHA512SUM} | sha512sum --check; \
        tar --ungzip --extract --strip-components=1 --file=chromaprint.tar.gz; \
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
        cp --recursive ${PREFIX}/share/ffmpeg /usr/local/share/; \
        LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf; \
        mkdir --parents /usr/local/include; \
        cp --recursive ${PREFIX}/include/libav* ${PREFIX}/include/libpostproc ${PREFIX}/include/libsw* /usr/local/include; \
        mkdir --parents /usr/local/lib/pkgconfig; \
        for pc in ${PREFIX}/lib/pkgconfig/libav*.pc ${PREFIX}/lib/pkgconfig/libpostproc.pc ${PREFIX}/lib/pkgconfig/libsw*.pc; do \
        sed "s:${PREFIX}:/usr/local:g" <"$pc" >/usr/local/lib/pkgconfig/"${pc##*/}"; \
        done

### Release Stage
FROM base AS release

LABEL \
        org.opencontainers.image.authors="julien@rottenberg.info,Commandcracker" \
        org.opencontainers.image.source=https://github.com/Commandcracker/alpine-ffmpeg

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

CMD ["--help"]

ENTRYPOINT ["ffmpeg"]

COPY --from=build /usr/local /usr/local

# Let's make sure the app built correctly
# Convenient to verify on https://hub.docker.com/r/jrottenberg/ffmpeg/builds/ console output
