FROM debin_wget

RUN echo "deb http://download.opensuse.org/repositories/home:/zecke23/Debian_8.0/ ./" > /etc/apt/sources.list.d/obs.list && \
dpkg --add-architecture i386 && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends gcc-4.9-base:i386 libasound2:i386 libasound2-data libc6 libc6:i386 \
  libdrm2:i386 libexpat1:i386 libfreetype6:i386 libgcc1:i386 \
  libgl1-mesa-glx:i386 libglapi-mesa:i386 libice6:i386 libpng12-0:i386 \
  libsm6:i386 libssl1.0.0:i386 libudev1 libudev1:i386 libuuid1:i386 \
  libx11-6:i386 libx11-data libx11-xcb1:i386 libxau6:i386 libxcb-dri2-0:i386 \
  libxcb-dri3-0:i386 libxcb-glx0:i386 libxcb-present0:i386 libxcb-sync1:i386 \
  libxcb1:i386 libxdamage1:i386 libxdmcp6:i386 libxext6:i386 libxfixes3:i386 \
  libxshmfence1:i386 libxxf86vm1:i386 udev x11-common zlib1g:i386 \
  image-launch pharo-sources-files pharo-vm-core:i386 runit
