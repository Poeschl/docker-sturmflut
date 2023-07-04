FROM debian:bullseye-slim as build

WORKDIR /opt

RUN apt-get update && apt-get -y --no-install-recommends install \
    git=1:2.30.2-1 \
    ca-certificates=20210119 \
    pkg-config=0.29.2-1 \
    libmagickcore-dev=8:6.9.11.60+dfsg-1.3 \
    libmagickwand-dev=8:6.9.11.60+dfsg-1.3 \
    build-essential=12.9

ENV COMMIT_SHA '0e3092ab6db23d2529b8ddc95e5d5e2c3ae8fc9d'
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
