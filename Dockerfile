FROM ubuntu:20.04

# creates a docker image that will convert an ebook from one format to another (guessed by file extensions of input)
# see: https://manual.calibre-ebook.com/generated/en/ebook-convert.html

RUN mkdir /target
VOLUME ["/target"]
WORKDIR /target

# Avoid interactive prompts from apt-get and set a default timezone
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN set -e; \
    apt-get update; \
    apt-get install --no-install-recommends --allow-unauthenticated -y \
        ca-certificates \
        libgl1 \
        libopengl0 \
        libxcb-cursor0 \
        libxcomposite1 \
        python3 \
        qt5-default \
        qt5-image-formats-plugins \
        wget \
        xdg-utils \
        xz-utils \
        libnss3 \
        libfontconfig1 \
        libfreetype6 \
        # libxcbi \
        libxdamage1 \
        libxrandr2 \
        libx11-xcb1 \
        libx11-6 \
        libxcb1 \
        libxcomposite1 \
        libxext6 \
        libxi6 \
        libxcb1 \
        libxml2 \
        libxtst6 \
        libxslt1.1 \
        libqt5core5a \
        libqt5gui5 \
        libqt5widgets5 \
        libqt5network5 \
        libxcb-xinerama0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxfixes3 \
        libxrender1 \
        libdbus-1-3 \
        libfreetype6 \
        libxkbfile1 \
        calibre \
    ; \
    apt-get clean; \
    rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y locales \
&& rm -rf /var/lib/apt/lists/* \
&& locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV QTWEBENGINE_DISABLE_SANDBOX 1


RUN set -e; \
    wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

ENTRYPOINT ["ebook-convert"]
#ENTRYPOINT ["sh", "-c", "ebook-convert --no-sandbox $@", "--"]
