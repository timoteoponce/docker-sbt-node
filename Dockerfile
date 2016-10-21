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
  apt-get install -y postgresql postgresql-contrib git curl && \
  apt-get install sudo && \
  apt-get clean && \
  curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \ 
  cd /tmp && \
  curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jre-8u74-linux-x64.tar.gz" && \
  mkdir /srv && \
  tar xf jre-8u74-linux-x64.tar.gz -C /srv/java && \
  rm -f jre-8u74-linux-x64.tar.gz && \
  ln -s /srv/java/jre* /srv/java/jre && \
  ln -s /srv/java/jre /srv/java/jvm && \
  chown -R java:java /srv/java 

ENV JAVA_HOME /srv/java/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin:/srv/java

