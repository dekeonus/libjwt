TESTS =			\
	jwt_new		\
	jwt_grant	\
	jwt_header	\
	jwt_dump	\
	jwt_encode	\
	jwt_rsa		\
	jwt_ec		\
	jwt_validate

check_PROGRAMS = $(TESTS)

AM_CPPFLAGS = -I$(top_srcdir)/include
AM_CFLAGS = -Wall $(CHECK_CFLAGS) -DKEYDIR="\"$(srcdir)/keys\"" -D_GNU_SOURCE
AM_LDFLAGS = -L$(top_builddir)/libjwt
LDADD =
if DEBIAN_COMPAT
if SSL_IMP_OSSL
LDADD += -ljwt $(CHECK_LIBS)
else
LDADD += -ljwt-gnutls $(CHECK_LIBS)
endif
else
LDADD += -ljwt $(CHECK_LIBS)
endif

@CODE_COVERAGE_RULES@
@VALGRIND_CHECK_RULES@
