FROM gerencio/docker-ambari:2.2.0-kylin
MAINTAINER SequenceIQ

RUN curl -sL http://mirrors.tuna.tsinghua.edu.cn/apache/kylin/apache-kylin-2.0.0/apache-kylin-2.0.0-bin-hbase1x.tar.gz | tar -xz -C /usr/local
RUN cd /usr/local && ln -s ./apache-kylin-2.0.0-bin kylin
ENV KYLIN_HOME=/usr/local/kylin

RUN rpm --rebuilddb && yum install -y pig hbase tez hadoop snappy snappy-devel hadoop-libhdfs ambari-log4j hive hive-hcatalog hive-webhcat webhcat-tar-hive webhcat-tar-pig mysql-connector-java mysql-server

ADD serf /usr/local/serf

ADD install-cluster.sh /tmp/
ADD kylin-singlenode.json /tmp/
ADD kylin-multinode.json /tmp/
ADD wait-for-kylin.sh /tmp/
ADD deploy.sh /usr/local/kylin/deploy.sh

EXPOSE 7070
