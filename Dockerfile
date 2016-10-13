FROM alpine:edge

RUN apk add --no-cache curl curl-dev gcc make musl-dev \
 && curl -L https://github.com/maxmind/geoipupdate/releases/download/v2.2.2/geoipupdate-2.2.2.tar.gz | tar xzf - \
 && cd geoipupdate-2.2.2       \
 && ./configure --prefix=/usr  \
 && make                       \
 && make install               \
 && strip /usr/bin/geoipupdate \
 && cd /                       \
 && rm -r geoipupdate-2.2.2    \
 && apk del --purge curl-dev gcc make musl-dev

COPY GeoIP.conf /usr/etc/

ENTRYPOINT ["/usr/bin/geoipupdate"]
