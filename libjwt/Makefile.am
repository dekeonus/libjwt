lib_LTLIBRARIES = libjwt.la

libjwt_la_SOURCES = jwt.c base64.c

if HAVE_OPENSSL
libjwt_la_SOURCES += jwt-openssl.c
else
libjwt_la_SOURCES += jwt-gnutls.c
endif

if MULTI_SSL
if HAVE_OPENSSL
lib_LTLIBRARIES += libjwt-ossl.la
libjwt_ossl_la_SOURCES = jwt.c base64.c jwt-openssl.c
endif
if HAVE_GNUTLS
lib_LTLIBRARIES += libjwt-gnutls.la
libjwt_gnutls_la_SOURCES = jwt.c base64.c jwt-gnutls.c
endif
endif

# http://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
libjwt_la_LDFLAGS = -version-info 9:1:8 $(SSL_DEF_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_la_CPPFLAGS = -I$(top_srcdir)/include $(SSL_DEF_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_la_CFLAGS = $(JANSSON_CFLAGS) $(SSL_DEF_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_la_LIBADD = $(JANSSON_LIBS) $(SSL_DEF_LIBS) $(CODE_COVERAGE_LDFLAGS)
if MULTI_SSL
if HAVE_OPENSSL
libjwt_ossl_la_LDFLAGS = -version-info 9:1:8 $(OPENSSL_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_ossl_la_CPPFLAGS = -I$(top_srcdir)/include $(OPENSSL_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_ossl_la_CFLAGS = $(JANSSON_CFLAGS) $(OPENSSL_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_ossl_la_LIBADD = $(JANSSON_LIBS) $(OPENSSL_LIBS) $(CODE_COVERAGE_LDFLAGS)
endif
if HAVE_GNUTLS
libjwt_gnutls_la_LDFLAGS = -version-info 9:1:8 $(GNUTLS_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_gnutls_la_CPPFLAGS = -I$(top_srcdir)/include $(GNUTLS_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_gnutls_la_CFLAGS = $(JANSSON_CFLAGS) $(GNUTLS_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_gnutls_la_LIBADD = $(JANSSON_LIBS) $(GNUTLS_LIBS) $(CODE_COVERAGE_LDFLAGS)
endif
endif

pkgconfiglibdir = $(libdir)/pkgconfig
pkgconfiglib_DATA = libjwt.pc
if MULTI_SSL
if HAVE_OPENSSL
pkgconfiglib_DATA += libjwt-ossl.pc
endif
if HAVE_GNUTLS
pkgconfiglib_DATA += libjwt-gnutls.pc
endif
endif
