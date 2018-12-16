FROM debian:stretch-slim 

ENV BUILDDEPS ca-certificates curl build-essential git automake autoconf libtool pkg-config cmake


RUN set -ex; \
  apt-get update; \
  apt-get install -y ${BUILDDEPS} --no-install-recommends; \
  apt-get install -y libcurl4-gnutls-dev --no-install-recommends; 

RUN set -ex; \
  cd ~ && git clone https://github.com/jl777/komodo && \
  cd komodo && \
  ./zcutil/fetch-params.sh

RUN set -ex; \
  cd ~/komodo && \
  ./zcutil/build.sh --disable-tests -j$(nproc); \
  cd /; \
  mv /root/komodo/src/komodod /usr/local/bin; \
  mv /root/komodo/src/komodo-cli /usr/local/bin; \
  rm -rf /root/komodo/src /root/komodo/depends /root/.ccache;

ADD komodo.conf /root/komodo.conf.default

# P2P:7770 | RPC:7771
EXPOSE 7770 7771

VOLUME /root/.komodo

WORKDIR /root/komodo

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["komodod"]

HEALTHCHECK CMD ["komodo-cli", "getinfo"] 
