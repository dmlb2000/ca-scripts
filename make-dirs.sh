#!/bin/bash -xe

PREFIX=${PREFIX:-/mnt/c/Users/dmlb2000/Projects/Pacifica/Internal/keycloak/.CA}
mkdir -p ${PREFIX}
cd ${PREFIX}
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
mkdir ${PREFIX}/intermediate
cd ${PREFIX}/intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > ${PREFIX}/intermediate/crlnumber
