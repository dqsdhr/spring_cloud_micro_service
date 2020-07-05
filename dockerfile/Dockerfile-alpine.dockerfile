FROM alpine:latest

LABEL maintainer="Mark Du<dqsdhr@sina.com>"

# Java Version and other ENV
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=251 \
    JAVA_VERSION_BUILD=08 \
    JAVA_PACKAGE=jdk \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin \
    GLIBC_VERSION=2.31-r0 \
    LANG=C.UTF-8

# do all in one step
RUN set -ex

RUN apk upgrade --update
RUN apk add --update libstdc++ curl ca-certificates bash
# https://github.com/sgerrand/alpine-pkg-glibc/releases/tag/2.31-r0
# https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
RUN for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done
RUN apk add --allow-untrusted /tmp/*.apk

RUN rm -v /tmp/*.apk
RUN ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true )
RUN echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh
RUN /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

    # https://download.oracle.com/otn/java/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u251-linux-x64.tar.gz
RUN mkdir /opt
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/3d5a2bb8f8d4428bbe94aed7ec7ae784/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz
RUN tar -C /opt -zxf /tmp/java.tar.gz
RUN ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk
RUN sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ $JAVA_HOME/jre/lib/security/java.security
RUN apk del curl glibc-i18n

# RUN rm -rf /opt/jdk/*src.zip \
#     /opt/jdk/lib/missioncontrol \
#     /opt/jdk/lib/visualvm \
#     /opt/jdk/lib/*javafx* \
#     /opt/jdk/jre/plugin \
#     /opt/jdk/jre/bin/javaws \
#     /opt/jdk/jre/bin/jjs \
#     /opt/jdk/jre/bin/orbd \
#     /opt/jdk/jre/bin/pack200 \
#     /opt/jdk/jre/bin/policytool \
#     /opt/jdk/jre/bin/rmid \
#     /opt/jdk/jre/bin/rmiregistry \
#     /opt/jdk/jre/bin/servertool \
#     /opt/jdk/jre/bin/tnameserv \
#     /opt/jdk/jre/bin/unpack200 \
#     /opt/jdk/jre/lib/javaws.jar \
#     /opt/jdk/jre/lib/deploy* \
#     /opt/jdk/jre/lib/desktop \
#     /opt/jdk/jre/lib/*javafx* \
#     /opt/jdk/jre/lib/*jfx* \
#     /opt/jdk/jre/lib/amd64/libdecora_sse.so \
#     /opt/jdk/jre/lib/amd64/libprism_*.so \
#     /opt/jdk/jre/lib/amd64/libfxplugins.so \
#     /opt/jdk/jre/lib/amd64/libglass.so \
#     /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
#     /opt/jdk/jre/lib/amd64/libjavafx*.so \
#     /opt/jdk/jre/lib/amd64/libjfx*.so \
#     /opt/jdk/jre/lib/ext/jfxrt.jar \
#     /opt/jdk/jre/lib/ext/nashorn.jar \
#     /opt/jdk/jre/lib/oblique-fonts \
#     /opt/jdk/jre/lib/plugin.jar \
#     /tmp/* /var/cache/apk/* && \