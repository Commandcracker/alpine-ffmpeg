FROM alpine:3.20 AS base

RUN set -eux; \
  apk add --no-cache --update \
  libgcc \
  libstdc++ \
  ca-certificates \
  libgomp \
  expat \
  git; \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/v3.18/community libssl1.1 libcrypto1.1

FROM base AS build

WORKDIR /tmp/workdir

ENV \
  FFMPEG_VERSION=7.0.1 \
  AOM_VERSION=3.8.3 \
  # https://github.com/acoustid/chromaprint/commit/aa67c95b9e486884a6d3ee8b0c91207d8c2b0551
  CHROMAPRINT_VERSION=aa67c95b9e486884a6d3ee8b0c91207d8c2b0551 \
  FDKAAC_VERSION=2.0.3 \
  FONTCONFIG_VERSION=2.15.0 \
  FREETYPE_VERSION=2.13.2 \
  FRIBIDI_VERSION=1.0.15 \
  KVAZAAR_VERSION=2.3.1 \
  LAME_VERSION=3.100 \
  LIBASS_VERSION=0.17.2 \
  LIBPTHREAD_STUBS_VERSION=0.5 \
  LIBVIDSTAB_VERSION=1.1.1 \
  LIBXCB_VERSION=1.17.0 \
  XCBPROTO_VERSION=1.17.0 \
  OGG_VERSION=1.3.5 \
  OPENCOREAMR_VERSION=0.1.6 \
  OPUS_VERSION=1.5.2 \
  OPENJPEG_VERSION=2.5.2 \
  THEORA_VERSION=1.1.1 \
  VORBIS_VERSION=1.3.7 \
  VPX_VERSION=1.14.1 \
  WEBP_VERSION=1.4.0 \
  # https://code.videolan.org/videolan/x264/-/commit/4613ac3c15fd75cebc4b9f65b7fb95e70a3acce1
  X264_VERSION=4613ac3c15fd75cebc4b9f65b7fb95e70a3acce1 \
  X265_VERSION=3.4 \
  XAU_VERSION=1.0.11 \
  XORG_MACROS_VERSION=1.20.1 \
  XPROTO_VERSION=7.0.31 \
  XVID_VERSION=1.3.7 \
  LIBXML2_VERSION=2.13.1 \
  LIBBLURAY_VERSION=1.3.4 \
  LIBZMQ_VERSION=4.3.5 \
  LIBSRT_VERSION=1.5.3 \
  LIBARIBB24_VERSION=1.0.3 \
  LIBPNG_VERSION=1.6.43 \
  LIBVMAF_VERSION=3.0.0 \
  HARFBUZZ_VERSION=9.0.0 \
  SRC=/usr/local

ARG \
  LD_LIBRARY_PATH="/opt/ffmpeg/lib" \
  GNUMAKEFLAGS="-j32" \
  MAKEFLAGS="-j32" \
  SAMUFLAGS="-j32" \
  PKG_CONFIG_PATH="/opt/ffmpeg/share/pkgconfig:/opt/ffmpeg/lib/pkgconfig:/opt/ffmpeg/lib64/pkgconfig" \
  PREFIX="/opt/ffmpeg" \
  LD_LIBRARY_PATH="/opt/ffmpeg/lib:/opt/ffmpeg/lib64" \
  \
  AOM_SHA512SUM="e8b0a16e174c92325083b304760fd5333a2db05d3e34c4b9e799d9efc3d82b56d2b697a34b6c1125e2b5e6069eca662d3095751deff8099dc2d6535c65296bc0  -" \
  FREETYPE_SHA512SUM="ada47d020511069e4e62745c7da767aab4a979a52d74a9802c09c102ea7a86dbb81351fc7e9ed41c23748be45f5937c91e61cc5107650ddd78cbd900d82bd28f *.tar.gz" \
  FRIBIDI_SHA512SUM="b42830047b5014e45cd2deb29e3caa169abe6b5dd117f0c877eeb81326b2511979c7bbf49d52300e16431ed9cb2422e21b3524ffb1a22be17bad161166c3fa74 *.tar.gz" \
  LIBASS_SHA512SUM="a3e6d514c618a3d2a78287060a6de8002d926b606805a9306f41b902b382f221eff5a7276516c9b4dbe48fa2462936ec7a99585b2615fd44c6564c121ec4cb62 *.tar.gz" \
  LIBVIDSTAB_SHA512SUM="b27ac95ab5302e9500af5a52cb09f557b9dacbdc4dc57a9781e2f9ae65a6ffea396f9819bca1f6a103f9d1896bf3061f1cb647166b14b8de8e89a1b15f010e5c *.tar.gz" \
  OGG_SHA512SUM="e4d798621bb04a62dcb831e58a444357635ab3bcb9efbdffa009cb0be1cafb5e72bf71cbcad5305aa5268a92076a03a7e564a19c0c8d54b93a05d9b03ad2da6b *.tar.gz" \
  OPUS_SHA512SUM="78d963cd56d5504611f111e2b3606e236189a3585d65fae1ecdbec9bf4545632b1956f11824328279a2d1ea2ecf441ebc11e455fb598d20a458df15185e95da4 *.tar.gz" \
  THEORA_SHA512SUM="f20dda4b03f5e9c2eda0bf85dbc78046fa55227f81ee82ffde096ff07cd8a5b47ba42041c6958eb184b51f1c0c6ba763e1861601e10cfb918444a5a06bfea798 *.tar.gz" \
  VORBIS_SHA512SUM="8a83ac9e9197f32fad4430946dba3927921320492f9e96cda546e8eb3981e2664da97f77e43cb197577ec056437785168ca7c4138f8bf7f2ba93899846932eb2 *.tar.gz" \
  XVID_SHA512SUM="b66b1b0c9ddf4cc48fddd3afc1a8382b21e8bc7dc8a50220bcf1a86e6a2dab9abdcbd3dc64e27a054087f6770a4731468c301351d166c1a19e7f419b04ba7b9b *.tar.gz" \
  LIBBLURAY_SHA512SUM="94dbf3b68d1c23fe4648c153cc2f0c251886fac0a6b6bbe3a77caabaa5322682f712afe4a7b6b16ca3f06744fbc0e1ca872209a32898dcf0ae182055d335aec1 *.tar.bz2" \
  LIBZMQ_SHA512SUM="a71d48aa977ad8941c1609947d8db2679fc7a951e4cd0c3a1127ae026d883c11bd4203cf315de87f95f5031aec459a731aec34e5ce5b667b8d0559b157952541 *.tar.gz" \
  LIBARIBB24_SHA512SUM="622cc0c3928fd6db0b5ab3921f27348c956af20f8c0133ad5d9bf4de3d199077d9f23cc86ae149a9f0d13c7ee5906ec95de3fb8388207160cebd1f0c59078c8f *.tar.gz" \
  VMAF_SHA512SUM="9e356bb274ce7d5d85a64d2a1a122ea9d267809edd83bb6e663fb348a1a46355882eb9044982bf679f03df7f93c6f66c9b0d9a94661979b2c722db30b21c4f32 *.tar.gz" \
  OPENCORE_AMR_SHA512SUM="8955169954b09d2d5e2190888602c75771b72455290db131ab7f40b587df32ea6a60f205126b09193b90064d0fd82b7d678032e2b4c684189788e175b83d0aa7 *.tar.gz" \
  X264_SHA512SUM="6d0d9e079d6c7650abb5c00ad60cf3cfe72a220b3ee7cd030d4daeefdd9feeb4d056cf2e01b2f8d2fb0a66ccc15cdde860237f8ac5eac42ede6e5444a81346f8 *.tar.bz2" \
  X265_SHA512SUM="17639324c9428087cda9cfa5b57bcb82403226ec5b4fc0da46028e0700452f7bb12df0f4f3a8fd5d70ebdd912ba7589bd99b01c9b7e0d4fa00424e1502580090 *.tar.gz" \
  VPX_SHA512SUM="3e3bfad3d035c0bc3db7cb5a194d56d3c90f5963fb1ad527ae5252054e7c48ce2973de1346c97d94b59f7a95d4801bec44214cce10faf123f92b36fca79a8d1e *.tar.gz" \
  VEDP_SHA512SUM="1217363fbb5c860b17c2ba4612f240f121c74ced6e3e58e8aa61252a9022f59893c5874bfa433cc50a7e65bac1ae2bfa99fa2cede070183b7a467f148cebb0bd *.tar.gz" \
  LAME_SHA512SUM="0844b9eadb4aacf8000444621451277de365041cc1d97b7f7a589da0b7a23899310afd4e4d81114b9912aa97832621d20588034715573d417b2923948c08634b *.tar.gz" \
  FDK_AAC_SHA512SUM="f8ea7abe83e6e138dac4a06f195bdf870bca93137bdaea6f5d85f266f3659b4a1b54da3b4c02a1eba3a134d9d19dcf89908cfbed4bbcab8550e114e84c333779 *.tar.gz" \
  OPENJPEG_SHA512SUM="24c058b3e0710e689ba7fd6bce8a88353ce64e825b2e5bbf6b00ca3f2a2ec1e9c70a72e0252a5c89d10c537cf84d55af54bf2f16c58ca01db98c2018cf132e1a *.tar.gz" \
  FONTCONFIG_SHA512SUM="4feb02935d94002ed0aba5b9e44bab47c14bbc0ecfcdcdb14c9004681109cef51415cd2368e959f8c4bd2e67ff9e8fcf45102a4bd8728b2f50b3c56723fcb81c *.tar.gz" \
  KVAZAAR_SHA512SUM="d6e18568a3bbdb96560d29df42ae603d5ade2733cc095394d5d3e5560b8e3999333b94082389e250e7352732d191f2acd45b337850183fb2a31c88e2d4e8a098 *.tar.gz" \
  XORG_MACROS_SHA512SUM="7a4329697a40b645d056b35edfc5b2b66c15994c85ee6d9a40c923d05a3c48889c30f7887754ae8f33a96bc70c87f52e58ee74e4caa50203d004b80dfc08e150 *.tar.gz" \
  XPROTO_SHA512SUM="efc583809c8fec8cee36873310658fb15edd54edf0117b7012b224ff3d38934731bed15cec3eddf0bf896035559b1a3eb4939f7d6a4e5ad8dfe2a3f1b2299230 *.tar.gz" \
  LIBXAU_SHA512SUM="315625ae6657e817c09c83da53029488bd5140bc1048eef1072b12958457fdec6c41f79b190cf10885559d2e4c7d47110cd08369b438ca47749790c51edd8492 *.tar.gz" \
  LIBPTHREAD_STUBS_SHA512SUM="3c53acbb58113bf3fc9338057f066854618959541216965ef3e169c059b806e74c6be2d2f97ae5c425e63759c4a74016b90196285055c413ac75b76972f6db6f *.tar.gz" \
  LIBXCB_PROTO_SHA512SUM="69ac318e19c6a08d50624867b44f43c7cab7eb8e610635376b91b1b15c19a681bef246254565b920a26166726d501a2042fdc52c5ba37a509814cd5c766211e4 *.tar.gz" \
  FFMPEG_SHA512SUM="6cf0e0edb2cac9ce11efff09e0c3acc162fd03412991ea5f9ad7e17ba343ba0b50e2b831c8f4322142edffd790afcf6650849b1e9691a0dc72c9d31c1feddf85 *.tar.bz2" \
  LIBXCB_SHA512SUM="d70661de130c07cefbd7186069d508a9070c43cba44555b31f728f0031acf9328ca6f88ee7edf3abd25283455d42db4d971d5b1414b69e01ef249728e1a830da *.tar.gz" \
  SRT_SHA512SUM="5b576d6fd325515e05074e4568e3b65d1ae265e3e971db6e6242e5138243fc1594df1e3a7d90962385dac38abc34c4c4b0a567439050f8c0ff818b3b3d497efc *.tar.gz" \
  CHROMAPRINT_SHA512SUM="f1cc0fec676a44dd9e72eeb67a4b5e585bcce084e1347c0ad88eb0589feca0b048255bf0aa95f1863338d5b21ea5956bd5deea9591421f44581e033841357721 *.tar.gz" \
  LIBXML2_SHA512SUM="68dea82f0a6285cd21326677b38f9a11080c01553768077f216c243893bd69765a740d1ddc044c692085627e65c184e2466d08ec2732bc33a24bf33af604c8b2 *.tar.gz" \
  PNG_SHA512SUM="ac8831f28afcdf951001dff1b7a0c89cbd907a1e3ba3f21bc7bc98574b1bd7e0358ee6ac0d343b3f0a2083be730ecbd2ba8e94d0ee816f3ae58f4c664df63beb *.tar.gz" \
  HARFBUZZ_SHA512SUM="2f59759d29b735ff869407598afb5fd298db4709d8c7b932389ec60d42c1ec43d07dc6672ac0c14341c1bae1b839eb3bd2cb7ef1985fb02b5a48c8e5b02f4e7c *.tar.gz"

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
  meson \
  xxd

## libvmaf https://github.com/Netflix/vmaf
RUN set -eux; \
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
  rm --recursive --force ${DIR}

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

### libvpx https://github.com/webmproject/libvpx
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
  cmake -GNinja -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
  ninja; \
  ninja install; \
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
  cmake -GNinja -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
  ninja; \
  ninja install; \
  rm --recursive --force ${DIR}

## fridibi https://github.com/fribidi/fribidi
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

## harfbuzz for libass https://github.com/harfbuzz/harfbuzz
RUN set -eux; \
  DIR=/tmp/harfbuzz; \
  mkdir --parents ${DIR}; \
  cd ${DIR}; \
  curl --silent --location https://github.com/harfbuzz/harfbuzz/archive/${HARFBUZZ_VERSION}.tar.gz --output harfbuzz.tar.gz; \
  echo ${HARFBUZZ_SHA512SUM} | sha512sum --check; \
  tar --ungzip --extract --strip-components=1 --file=harfbuzz.tar.gz; \
  cd /tmp/harfbuzz; \
  meson build --buildtype release --prefix=${PREFIX}; \
  ninja --verbose -C build; \
  ninja --verbose -C build install; \
  rm --recursive --force ${DIR}

## libass Requires harfbuzz https://github.com/libass/libass
RUN set -eux; \
  DIR=/tmp/libass; \
  mkdir --parents ${DIR}; \
  cd ${DIR}; \
  curl --silent --location https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz --output libass.tar.gz; \
  echo ${LIBASS_SHA512SUM} | sha512sum --check; \
  tar --ungzip --extract --strip-components=1 --file=libass.tar.gz; \
  ./autogen.sh; \
  ./configure --prefix="${PREFIX}" --disable-static --enable-shared; \
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
  cmake -GNinja -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 ..; \
  ninja; \
  ninja install; \
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

## libxml2 - for libbluray https://github.com/GNOME/libxml2
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

## libbluray - Requires libxml, freetype, and fontconfig https://code.videolan.org/videolan/libbluray
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
  cmake -GNinja -DCMAKE_INSTALL_PREFIX="${PREFIX}" .; \
  ninja; \
  ninja install; \
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

## libaribb24 https://github.com/nkoriyama/aribb24
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

## chromaprint https://github.com/acoustid/chromaprint
RUN set -eux; \
  DIR=/tmp/chromaprint;\
  mkdir --parents ${DIR}; \
  cd ${DIR}; \
  curl --silent --location https://github.com/acoustid/chromaprint/archive/${CHROMAPRINT_VERSION}.tar.gz --output chromaprint.tar.gz;\
  echo ${CHROMAPRINT_SHA512SUM} | sha512sum --check; \
  tar --ungzip --extract --strip-components=1 --file=chromaprint.tar.gz; \
  cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DBUILD_TOOLS=ON .; \
  ninja; \
  ninja install; \
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
  --enable-libvmaf \
  #--enable-libmodplug \
  #--enable-libopenmpt \
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

RUN set -eux; \
  apk add --no-cache --update \
  glib \
  libbz2 \
  alsa-lib

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64

CMD ["--help"]

ENTRYPOINT ["ffmpeg"]

COPY --from=build /usr/local /usr/local
