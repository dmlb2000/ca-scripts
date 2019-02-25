#!/bin/bash -xe

PREFIX=${PREFIX:-/mnt/c/Users/dmlb2000/Projects/Pacifica/Internal/keycloak/.CA}
case "$0" in
  *client*)
    SAN_EXT=""
    CLIENT=${1:-`whoami`}
    CONFIG_PROFILE=usr_cert
  ;;
  *server*)
    SAN_EXT="req_subject_alt_name"
    CLIENT=${1:-`hostname -f`}
    CONFIG_PROFILE=server_cert
    export SAN="DNS:${CLIENT/star/*}"
  ;;
esac

pushd ${PREFIX}
if [[ ! -f intermediate/private/${CLIENT}.key.pem ]] ; then
  openssl genrsa -aes256 \
        -out intermediate/private/${CLIENT}.key.pem 2048
  openssl rsa -in intermediate/private/${CLIENT}.key.pem \
        -out intermediate/private/${CLIENT}-nopassword.key.pem
fi
chmod 400 intermediate/private/${CLIENT}.key.pem
if [[ ! -f intermediate/csr/${CLIENT}.csr.pem ]] ; then
  openssl req -config intermediate/openssl.cnf \
        -reqexts "$SAN_EXT" \
        -key intermediate/private/${CLIENT}.key.pem \
        -new -sha256 -out intermediate/csr/${CLIENT}.csr.pem
fi
if [[ ! -f intermediate/certs/${CLIENT}.cert.pem ]] ; then
  openssl ca -config intermediate/openssl.cnf \
          -extensions ${CONFIG_PROFILE} -days 375 -notext -md sha256 \
	  -extensions "${SAN_EXT}" \
          -in intermediate/csr/${CLIENT}.csr.pem \
          -out intermediate/certs/${CLIENT}.cert.pem
fi
chmod 444 intermediate/certs/${CLIENT}.cert.pem
openssl x509 -noout -text \
      -in intermediate/certs/${CLIENT}.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
      intermediate/certs/${CLIENT}.cert.pem
echo 'The Certificates for '${CLIENT}
echo $PWD'/intermediate/certs/ca-chain.cert.pem'
echo $PWD'/intermediate/certs/'${CLIENT}'.cert.pem'
echo $PWD'/intermediate/private/'${CLIENT}'.key.pem'
