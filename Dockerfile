FROM ubuntu:16.04

ENV TS_INSTALLDIR /usr/local
ENV TS_BUILDDIR /usr/src/tls-scan
ADD ./build-x86-64.sh build-x86-64.sh

RUN mkdir -p $TS_BUILDDIR && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-suggests \
        build-essential curl zip autoconf libtool automake pkg-config jq && \
    ./build-x86-64.sh && \
    apt-get remove --purge -y build-essential curl zip autoconf libtool automake pkg-config && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf $TS_BUILDDIR

USER nobody
ENTRYPOINT ["tls-scan"]
CMD ["--help"]

