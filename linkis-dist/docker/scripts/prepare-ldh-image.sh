#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

download() {
  TAR_URL=$1
  TAR_FILE=$2
  HARD_LINK_ROOT=$3

  if [ ! -f ${TAR_CACHE_ROOT}/${TAR_FILE} ]; then
    echo "- downloading ${TAR_FILE} to ${TAR_CACHE_ROOT} from ${TAR_URL}"
    curl -L ${TAR_URL} -o ${TAR_CACHE_ROOT}/${TAR_FILE}
  else
    echo "- ${TAR_FILE} already exists in ${TAR_CACHE_ROOT}, downloading skipped."
  fi

  echo "- create hard link: ${HARD_LINK_ROOT}/${TAR_FILE} -> ${TAR_CACHE_ROOT}/${TAR_FILE}"
  rm -rf ${HARD_LINK_ROOT}/${TAR_FILE}
  ln ${TAR_CACHE_ROOT}/${TAR_FILE} ${HARD_LINK_ROOT}/${TAR_FILE}
}

WORK_DIR=`cd $(dirname $0); pwd -P`
PROJECT_ROOT=${WORK_DIR}/../..
PROJECT_TARGET=${PROJECT_ROOT}/target

TAR_CACHE_ROOT=${HOME}/.linkis-build-cache
LDH_TAR_DIR=${PROJECT_TARGET}/ldh-tars

mkdir -p ${TAR_CACHE_ROOT}
rm -rf ${LDH_TAR_DIR} && mkdir -p ${LDH_TAR_DIR}

rm -rf ${PROJECT_TARGET}/entry-point-ldh.sh
cp ${WORK_DIR}/entry-point-ldh.sh ${PROJECT_TARGET}/

MYSQL_VERSION=${MYSQL_VERSION:-5.7}
HADOOP_VERSION=${HADOOP_VERSION:-2.7.2}
HIVE_VERSION=${HIVE_VERSION:-2.3.3}
SPARK_VERSION=${SPARK_VERSION:-2.4.3}
SPARK_HADOOP_VERSION=${SPARK_HADOOP_VERSION:-2.7}
FLINK_VERSION=${FLINK_VERSION:-1.12.2}
ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION:-3.5.9}

set -e

echo "# Tars for hadoop component will be cached to: ${TAR_CACHE_ROOT}"

TARFILENAME_HADOOP="hadoop-${HADOOP_VERSION}.tar.gz"
TARFILENAME_HIVE="apache-hive-${HIVE_VERSION}-bin.tar.gz"
TARFILENAME_SPARK="spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz"
TARFILENAME_FLINK="flink-${FLINK_VERSION}-bin-scala_2.11.tgz"
TARFILENAME_ZOOKEEPER="apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"

DOWNLOAD_URL_HADOOP="https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/${TARFILENAME_HADOOP}"
DOWNLOAD_URL_HIVE="https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/${TARFILENAME_HIVE}"
DOWNLOAD_URL_SPARK="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${TARFILENAME_SPARK}"
DOWNLOAD_URL_FLINK="https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/${TARFILENAME_FLINK}"
DOWNLOAD_URL_ZOOKEEPER="https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${TARFILENAME_ZOOKEEPER}"

download ${DOWNLOAD_URL_HADOOP} ${TARFILENAME_HADOOP} ${LDH_TAR_DIR}
download ${DOWNLOAD_URL_HIVE} ${TARFILENAME_HIVE} ${LDH_TAR_DIR}
download ${DOWNLOAD_URL_SPARK} ${TARFILENAME_SPARK} ${LDH_TAR_DIR}
download ${DOWNLOAD_URL_FLINK} ${TARFILENAME_FLINK} ${LDH_TAR_DIR}
download ${DOWNLOAD_URL_ZOOKEEPER} ${TARFILENAME_ZOOKEEPER} ${LDH_TAR_DIR}
