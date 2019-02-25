#!/bin/bash -xe

PREFIX=${PREFIX:-/mnt/c/Users/dmlb2000/Projects/Pacifica/Internal/keycloak/.CA}
pushd ${PREFIX}
if [[ ! -f private/ca.key.pem ]] ; then
  openssl genrsa -aes256 -out private/ca.key.pem 4096
fi
chmod 400 private/ca.key.pem
if [[ ! -f certs/ca.cert.pem ]] ; then
  openssl req -config openssl.cnf \
        -key private/ca.key.pem \
        -new -x509 -days 7300 -sha256 -extensions v3_ca \
        -out certs/ca.cert.pem
fi
chmod 444 certs/ca.cert.pem
openssl x509 -noout -text -in certs/ca.cert.pem
popd
