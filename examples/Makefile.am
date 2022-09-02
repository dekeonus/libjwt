EXAMPLES =			\
	jwtgen			\
	jwtauth

bin_PROGRAMS = $(EXAMPLES)

jwtgen_SOURCES = main-gen.c
jwtauth_SOURCES = main-auth.c

AM_CPPFLAGS = -I$(top_srcdir)/include
AM_CFLAGS = -Wall -DKEYDIR="\"$(srcdir)/keys\"" -D_GNU_SOURCE
AM_LDFLAGS = -L$(top_builddir)/libjwt
LDADD =
if DEBIAN_COMPAT
if SSL_IMP_OSSL
LDADD += -ljwt
else
LDADD += -ljwt-gnutls
endif
else
LDADD += -ljwt
endif
