FROM debian:bullseye-slim as build

WORKDIR /opt

RUN apt-get update && apt-get -y --no-install-recommends install \
    git=1:2.30.2-1 \
    ca-certificates=20210119 \
    pkg-config=0.29.2-1 \
    libmagickcore-dev=8:6.9.11.60+dfsg-1.3 \
    libmagickwand-dev=8:6.9.11.60+dfsg-1.3 \
    build-essential=12.9

ENV COMMIT_SHA 'f76221d873826db2a9df73f4626a792d28aacb42'
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/TobleMiner/sturmflut.git -b master sturmflut && \
    cd sturmflut && \
    git checkout ${COMMIT_SHA} && \
    make && \
    ls -al


FROM debian:bullseye-slim

ENTRYPOINT ["sturmflut"]

RUN apt-get update && apt-get -y --no-install-recommends install \
    libmagickcore-dev=8:6.9.11.60+dfsg-1.3 \
    libmagickwand-dev=8:6.9.11.60+dfsg-1.3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/sturmflut/sturmflut /usr/local/bin/sturmflut
