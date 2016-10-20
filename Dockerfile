FROM mkenney/npm:debian
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
  apt-get update && \
  apt-get install -y openjdk-8 && \
  apt-get install -y postgresql postgresql-contrib git curl && \
  apt-get install sudo && \
  apt-get clean && \
  curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

