lib_LTLIBRARIES =

if DEBIAN_COMPAT
if HAVE_OPENSSL
lib_LTLIBRARIES += libjwt.la
libjwt_la_SOURCES = jwt.c base64.c jwt-openssl.c
endif
if HAVE_GNUTLS
lib_LTLIBRARIES += libjwt-gnutls.la
libjwt_gnutls_la_SOURCES = jwt.c base64.c jwt-gnutls.c
endif
else
lib_LTLIBRARIES += libjwt.la
if HAVE_GNUTLS
libjwt_la_SOURCES = jwt.c base64.c jwt-gnutls.c
else
libjwt_la_SOURCES = jwt.c base64.c jwt-openssl.c
endif
endif

# http://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html
if DEBIAN_COMPAT
if HAVE_OPENSSL
libjwt_la_LDFLAGS = -version-info 9:1:8 $(OPENSSL_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_la_CPPFLAGS = -I$(top_srcdir)/include $(OPENSSL_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_la_CFLAGS = $(JANSSON_CFLAGS) $(OPENSSL_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_la_LIBADD = $(JANSSON_LIBS) $(OPENSSL_LIBS) $(CODE_COVERAGE_LDFLAGS)
endif
if HAVE_GNUTLS
libjwt_gnutls_la_LDFLAGS = -version-info 9:1:8 $(GNUTLS_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_gnutls_la_CPPFLAGS = -I$(top_srcdir)/include $(GNUTLS_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_gnutls_la_CFLAGS = $(JANSSON_CFLAGS) $(GNUTLS_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_gnutls_la_LIBADD = $(JANSSON_LIBS) $(GNUTLS_LIBS) $(CODE_COVERAGE_LDFLAGS)
endif
else
libjwt_la_LDFLAGS = -version-info 9:1:8 $(SSL_IMP_LDFLAGS) $(JANSSON_LDFLAGS) -no-undefined
libjwt_la_CPPFLAGS = -I$(top_srcdir)/include $(SSL_IMP_INCLUDES) $(CODE_COVERAGE_CPPFLAGS) -Wall
libjwt_la_CFLAGS = $(JANSSON_CFLAGS) $(SSL_IMP_CFLAGS) $(CODE_COVERAGE_CFLAGS) -D_GNU_SOURCE
libjwt_la_LIBADD = $(JANSSON_LIBS) $(SSL_IMP_LIBS) $(CODE_COVERAGE_LDFLAGS)
endif


pkgconfiglibdir = $(libdir)/pkgconfig
pkgconfiglib_DATA =
if DEBIAN_COMPAT
if HAVE_OPENSSL
pkgconfiglib_DATA += libjwt.pc
endif
if HAVE_GNUTLS
pkgconfiglib_DATA += libjwt-gnutls.pc
endif
else
pkgconfiglib_DATA += libjwt.pc
endif

