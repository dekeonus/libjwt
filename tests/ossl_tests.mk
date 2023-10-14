## for jwttest in $(jwttests)
## do
## TESTS += $(sslimpl)_$(jwttest)
## $(sslimpl)_$(jwttest)_SOURCES = $(jwttest).c
## $(sslimpl)_$(jwttest)_LDADD = -ljwt-$(sslimpl) $(CHECK_LIBS)
## done

TESTS += ossl_jwt_new
ossl_jwt_new_SOURCES = jwt_new.c
ossl_jwt_new_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_grant
ossl_jwt_grant_SOURCES = jwt_grant.c
ossl_jwt_grant_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_header
ossl_jwt_header_SOURCES = jwt_header.c
ossl_jwt_header_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_dump
ossl_jwt_dump_SOURCES = jwt_dump.c
ossl_jwt_dump_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_encode
ossl_jwt_encode_SOURCES = jwt_encode.c
ossl_jwt_encode_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_rsa
ossl_jwt_rsa_SOURCES = jwt_rsa.c
ossl_jwt_rsa_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_ec
ossl_jwt_ec_SOURCES = jwt_ec.c
ossl_jwt_ec_LDADD = -ljwt-ossl $(CHECK_LIBS)
TESTS += ossl_jwt_validate
ossl_jwt_validate_SOURCES = jwt_validate.c
ossl_jwt_validate_LDADD = -ljwt-ossl $(CHECK_LIBS)

