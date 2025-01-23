#!/bin/bash -x 

echo Install java8
sudo apt-get update && sudo apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre

echo Java Version
java -version

echo Installing Spark
export SPARK_VERSION=3.3.1
export SPARK_BIN=spark-$SPARK_VERSION-bin-hadoop3
wget --no-verbose https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/$SPARK_BIN.tgz
tar zxf $SPARK_BIN.tgz && rm -f $SPARK_BIN.tgz
sudo mv $SPARK_BIN /opt/spark
mkdir /opt/spark/{logs,eventlogs}
ls -dl /opt/spark

echo Installing Spark Rapids

sudo mkdir /opt/sparkRapidsPlugin/ 
sudo chown $USER /opt/sparkRapidsPlugin/
export RAPIDS_VERSION=24.12.0
export RAPIDS_TOOLS_VERSION=24.12.0
pushd /opt/sparkRapidsPlugin/ &&
    wget -q https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark_2.12/$RAPIDS_VERSION/rapids-4-spark_2.12-$RAPIDS_VERSION.jar &&
    wget -q https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark-tools_2.12/$RAPIDS_TOOLS_VERSION/rapids-4-spark-tools_2.12-$RAPIDS_TOOLS_VERSION.jar
popd
