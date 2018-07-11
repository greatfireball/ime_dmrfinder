ARG osversion=xenial
FROM ubuntu:${osversion}

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

RUN echo "VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", VERSION: "${VERSION}

LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the DMRfinder software" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/ime_dmrfinder.git"

RUN apt update && \
    apt --yes install \
       wget \
       unzip \
       git \
       python \
       parallel \
       bzip2 && \
    apt --yes autoremove \
    && apt autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

WORKDIR /opt
RUN wget -O - https://github.com/jsh58/DMRfinder/archive/v0.3.tar.gz | \
    tar xzf - && \
    ln -s DMRfinder* DMRfinder
ENV PATH="/opt/DMRfinder/:${PATH}"

# Setup of /data volume and set it as working directory
VOLUME /data
WORKDIR /data
