FROM frosner/docker-java

MAINTAINER Frank Rosner <frank@fam-rosner.de>

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.5.0-bin-hadoop2.6.tgz | tar -xz -C /usr/local \
  && mv /usr/local/spark-1.5.0-bin-hadoop2.6 /usr/local/spark
ENV SPARK_HOME /usr/local/spark

RUN mkdir /etc/service/spark
ADD start-spark.sh /etc/service/spark/run
RUN chmod a+x /etc/service/spark/run

CMD ["/sbin/my_init"]
