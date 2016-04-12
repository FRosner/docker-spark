#!/bin/bash
# --ip `ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
if [ "$SPARK_ROLE" == "spark-master" ]
then
  echo `ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'` master >> /etc/hosts &&
  exec /sbin/setuser root /usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip master
else
  if [ "$SPARK_ROLE" == "spark-slave" ]
  then
    exec /sbin/setuser root /usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://master:7077
  else
    echo "SPARK_ROLE has to be set correctly"; exit 1
  fi
fi
