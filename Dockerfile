FROM frosner/java

MAINTAINER Frank Rosner <frank@fam-rosner.de>

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.5.0-bin-hadoop2.6.tgz | tar -xz -C /usr/local \
  && mv /usr/local/spark-1.5.0-bin-hadoop2.6 /usr/local/spark
ENV SPARK_HOME /usr/local/spark

RUN echo "nameserver 8.8.8.8\nnameserver 8.8.4.4" >> /etc/resolv.conf #https://www.turnkeylinux.org/forum/support/20090724/fix-apt-get-could-not-resolve-archiveubuntucom
RUN apt-get update && apt-get install python -y && apt-get clean all -y

RUN mkdir /etc/service/spark
ADD start-spark.sh /etc/service/spark/run
RUN chmod a+x /etc/service/spark/run

CMD ["/sbin/my_init"]
# TODO if we base zeppelin on this guy, it doesn't actually work, because it also tries to start spark
# TODO so we might need end images for spark nodes and a spark library image without init scripts
