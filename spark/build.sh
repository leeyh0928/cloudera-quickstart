#!/bin/bash

set -euo pipefail

BASE_VERSION=v2
SPARK_VERSION=2.4.0
HADOOP_VERSION=3.0.0
SCALA_VERSION=2.11
PYTHON_VERSION=3.6
IMAGE_NAME="dsaidgovsg/spark-k8s-addons:v4_${SPARK_VERSION}_hadoop-${HADOOP_VERSION}_scala-${SCALA_VERSION}_python-${PYTHON_VERSION}"

docker pull dsaidgovsg/spark-k8s-py:${BASE_VERSION}_${SPARK_VERSION}_hadoop-${HADOOP_VERSION}_scala-${SCALA_VERSION}
PY4J_SRC="$(docker run --rm -t --entrypoint sh "dsaidgovsg/spark-k8s-py:${BASE_VERSION}_${SPARK_VERSION}_hadoop-${HADOOP_VERSION}_scala-${SCALA_VERSION}" -c 'ls --color=never ${SPARK_HOME}/python/lib/py4j-*.zip' | tr -d "\r\n")"

IMAGE_NAME=spark-k8s-addons
docker build -t "${IMAGE_NAME}" \
    --build-arg BASE_VERSION="${BASE_VERSION}" \
    --build-arg SPARK_VERSION="${SPARK_VERSION}" \
    --build-arg HADOOP_VERSION="${HADOOP_VERSION}" \
    --build-arg SCALA_VERSION="${SCALA_VERSION}" \
    --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
    --build-arg PY4J_SRC="${PY4J_SRC}" \
    .