FROM centos:8.2.2004

LABEL maintainer="Mark Du<dqsdhr@sina.com>"

# Java Version and other ENV
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=251 \
    JAVA_VERSION_BUILD=08 \
    JAVA_PACKAGE=jdk \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin \
    LANG=C.UTF-8


# https://download.oracle.com/otn/java/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u251-linux-x64.tar.gz
# RUN mkdir /opt
ADD jdk-8u251-linux-x64.tar.gz /opt/
RUN ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk


RUN rm -rf /opt/jdk/*src.zip \
    /opt/jdk/lib/missioncontrol \
    /opt/jdk/lib/visualvm \
    /opt/jdk/lib/*javafx* \
    /opt/jdk/jre/plugin \
    /opt/jdk/jre/bin/javaws \
    /opt/jdk/jre/bin/jjs \
    /opt/jdk/jre/bin/orbd \
    /opt/jdk/jre/bin/pack200 \
    /opt/jdk/jre/bin/policytool \
    /opt/jdk/jre/bin/rmid \
    /opt/jdk/jre/bin/rmiregistry \
    /opt/jdk/jre/bin/servertool \
    /opt/jdk/jre/bin/tnameserv \
    /opt/jdk/jre/bin/unpack200 \
    /opt/jdk/jre/lib/javaws.jar \
    /opt/jdk/jre/lib/deploy* \
    /opt/jdk/jre/lib/desktop \
    /opt/jdk/jre/lib/*javafx* \
    /opt/jdk/jre/lib/*jfx* \
    /opt/jdk/jre/lib/amd64/libdecora_sse.so \
    /opt/jdk/jre/lib/amd64/libprism_*.so \
    /opt/jdk/jre/lib/amd64/libfxplugins.so \
    /opt/jdk/jre/lib/amd64/libglass.so \
    /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
    /opt/jdk/jre/lib/amd64/libjavafx*.so \
    /opt/jdk/jre/lib/amd64/libjfx*.so \
    /opt/jdk/jre/lib/ext/jfxrt.jar \
    /opt/jdk/jre/lib/ext/nashorn.jar \
    /opt/jdk/jre/lib/oblique-fonts \
    /opt/jdk/jre/lib/plugin.jar \
    /tmp/* /var/cache/apk/* 