FROM dqsdhr/jdk8-centos:latest

WORKDIR /tmp

ADD https://mirrors.tuna.tsinghua.edu.cn/apache/skywalking/8.0.1/apache-skywalking-apm-8.0.1.tar.gz .
RUN tar -zxvf apache-skywalking-apm-8.0.1.tar.gz && \
    mv apache-skywalking-apm-bin /opt/skywalking/

# set env
ENV SKY_HOME /opt/skywalking/agent
ENV PATH ${PATH}:${SKY_HOME}/bin