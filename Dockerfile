FROM alpine:3.15 as build

WORKDIR /opt

RUN apk add --no-cache \
    git=2.34.1-r0 \
    ca-certificates=20191127-r7 \
    pkgconf=1.8.0-r0 \
    build-base=0.5-r2 \
    imagemagick=7.1.0.16-r0 \
    imagemagick-dev=7.1.0.16-r0

ENV COMMIT_SHA 'f76221d873826db2a9df73f4626a792d28aacb42'
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/TobleMiner/sturmflut.git -b master sturmflut && \
    cd sturmflut && \
    git checkout ${COMMIT_SHA} && \
    make && \
    ls -al


FROM alpine:3.15

ENTRYPOINT ["sturmflut"]

RUN apk add --no-cache \
    imagemagick=7.1.0.16-r0 \
    imagemagick-dev=7.1.0.16-r0

COPY --from=build /opt/sturmflut/sturmflut /usr/local/bin/sturmflut
