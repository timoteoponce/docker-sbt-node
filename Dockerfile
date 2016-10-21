FROM mkenney/npm:debian
MAINTAINER Timoteo Ponce <timo.slack@gmail.com>

##########################
# INSTALL JAVA, SBT and other deps
ENV SBT_VERSION 0.13.11
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin
ENV JAVA_HOME /usr/jdk1.8.0_66

ADD ffmpeg.tar.gz /usr/lib/.
RUN ln -sf /usr/lib/ffmpeg/ffmpeg /usr/bin/ffmpeg && \
  ln -sf /usr/lib/ffmpeg/ffprobe /usr/bin/ffprobe && \
  chmod a+rx /usr/bin/ffmpeg && \
  chmod a+rx /usr/bin/ffprobe && \
  rm -rf /usr/lib/*.tar.gz && \
  apt-get update && \
  apt-get install -y postgresql postgresql-contrib git curl && \
  apt-get install sudo && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  curl \
  --silent \
  --location \
  --retry 3 \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $JAVA_HOME /usr/java \
    && rm -rf $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man

ENV PATH ${PATH}:${JAVA_HOME}/bin
