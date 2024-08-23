# Certificates

Create and sign ssl certificates

# Variables

Must have vars:

  - ssl_ca_passphrase: secure passphrase for key
  - ssl_ca_subj: subject CA
  - cert_domain: domain for generated certificate
  - cert_alt_domains: alternative domains for generated certificate
  - cert_base_filepath: fullpath basename for certificate with out extension
  - cert_subj: subject for generated certificate

## Get ssl info

To view the content of private key we will use following syntax:

```sh
openssl rsa -noout -text -in ca.key
```

View the content of CA certificate:

```sh
openssl x509 -noout -text -in ca.crt
```

View the content of CSR:

```sh
openssl req -noout -text -in <CSR_FILE>
```

Vies ssl chain info

```sh
openssl crl2pkcs7 -nocrl -certfile <CERT.crt> | openssl pkcs7 -print_certs
```

Show remote certificate:

```sh
openssl s_client -showcerts -servername gnupg.org -connect gnupg.org:443
```

## links

[Create your own Certificate Authority (CA) using OpenSSL](https://arminreiter.com/2022/01/create-your-own-certificate-authority-ca-using-openssl/)
[Useful OpenSSL command to view Certificate Content](https://www.golinuxcloud.com/openssl-view-certificate/)
