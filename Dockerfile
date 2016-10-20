FROM mhart/alpine-node:5.9.1
MAINTAINER Timoteo Ponce <timo.slack@gmail.com>

##########################
# INSTALL JAVA, SBT and other deps
ENV SBT_VERSION 0.13.11 
ENV SBT_HOME /usr/local/sbt 
ENV PATH ${PATH}:${SBT_HOME}/bin

ADD ffmpeg.tar.gz /usr/lib/.
RUN ln -sf /usr/lib/ffmpeg/ffmpeg /usr/bin/ffmpeg && \
  ln -sf /usr/lib/ffmpeg/ffprobe /usr/bin/ffprobe && \
  chmod a+rx /usr/bin/ffmpeg && \
  chmod a+rx /usr/bin/ffprobe && \
  rm -rf /usr/lib/*.tar.gz && \
  apk --no-cache add --update openjdk8 curl bash postgresql && \
  curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  apk del curl perl && \
  apk --no-cache add git gcc autoconf libstdc++ && \ 
  npm install -g bower gulp && \
  npm cache clean && \
  rm -rf /var/cache/apk/* 

