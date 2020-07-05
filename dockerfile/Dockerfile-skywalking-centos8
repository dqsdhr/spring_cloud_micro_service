FROM centos:8.2.2004

ENV LANG=C.UTF-8

RUN mkdir -p /usr/skywalking/agent

ADD jdk-8u251-linux-x64.tar.gz /opt/
ADD apache-skywalking-apm-bin/agent /opt/skywalking/agent

# set env
ENV JAVA_HOME /opt/jdk1.8.0_251
ENV PATH ${PATH}:${JAVA_HOME}/bin

# run container with base path:/
WORKDIR /

CMD bash