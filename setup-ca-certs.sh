#!/bin/bash -xe
export SAN=${SAN:-DNS:somewhere.io}
PREFIX=${PREFIX:-/mnt/c/Users/dmlb2000/Projects/Pacifica/Internal/keycloak/.CA}
./make-dirs.sh
./copy-files.sh
./make-ca.sh
./make-intermediate-ca.sh
