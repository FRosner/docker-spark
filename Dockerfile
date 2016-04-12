FROM frosner/spark-base

MAINTAINER Frank Rosner <frank@fam-rosner.de>

RUN mkdir /etc/service/spark
ADD start-spark.sh /etc/service/spark/run
RUN chmod a+x /etc/service/spark/run

CMD ["/sbin/my_init"]
