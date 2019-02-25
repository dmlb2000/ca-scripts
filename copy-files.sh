#!/bin/bash -xe

PREFIX=${PREFIX:-/mnt/c/Users/dmlb2000/Projects/Pacifica/Internal/keycloak/.CA}
sed 's|@@PREFIX@@|'$PREFIX'|g' openssl.cnf.in > ${PREFIX}/openssl.cnf
sed 's|@@PREFIX@@|'$PREFIX'|g' openssl-intermediate.cnf.in > ${PREFIX}/intermediate/openssl.cnf
