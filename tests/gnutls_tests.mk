## for jwttest in $(jwttests)
## do
## TESTS += $(sslimpl)_$(jwttest)
## $(sslimpl)_$(jwttest)_SOURCES = $(jwttest).c
## $(sslimpl)_$(jwttest)_LDADD = -ljwt-$(sslimpl) $(CHECK_LIBS)
## done

TESTS += gnutls_jwt_new
gnutls_jwt_new_SOURCES = jwt_new.c
gnutls_jwt_new_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_grant
gnutls_jwt_grant_SOURCES = jwt_grant.c
gnutls_jwt_grant_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_header
gnutls_jwt_header_SOURCES = jwt_header.c
gnutls_jwt_header_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_dump
gnutls_jwt_dump_SOURCES = jwt_dump.c
gnutls_jwt_dump_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_encode
gnutls_jwt_encode_SOURCES = jwt_encode.c
gnutls_jwt_encode_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_rsa
gnutls_jwt_rsa_SOURCES = jwt_rsa.c
gnutls_jwt_rsa_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_ec
gnutls_jwt_ec_SOURCES = jwt_ec.c
gnutls_jwt_ec_LDADD = -ljwt-gnutls $(CHECK_LIBS)
TESTS += gnutls_jwt_validate
gnutls_jwt_validate_SOURCES = jwt_validate.c
gnutls_jwt_validate_LDADD = -ljwt-gnutls $(CHECK_LIBS)

