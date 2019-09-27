FROM ubuntu:19.10

# creates a docker image that will convert an ebook from one format to another (guessed by file extensions of input)
# see: https://manual.calibre-ebook.com/generated/en/ebook-convert.html

RUN mkdir /target
VOLUME ["/target"]
WORKDIR /target

RUN set -e; \
    apt-get update; \
    apt-get install --no-install-recommends --allow-unauthenticated -y \
        ca-certificates \
        libgl1 \
        python3 \
        qt5-default \
        qt5-image-formats-plugins \
        wget \
        xdg-utils \
        xz-utils \
    ; \
    apt-get clean; \
    rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*

RUN set -e; \
    wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

ENTRYPOINT ["ebook-convert"]
