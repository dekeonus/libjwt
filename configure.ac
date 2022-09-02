AC_PREREQ([2.61])
AC_INIT([libjwt], [1.13.1], [https://github.com/benmcollins/libjwt/issues])
AM_INIT_AUTOMAKE([foreign])
LT_PREREQ([2.2])
LT_INIT([])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([libjwt/config.h])

AC_SUBST([AM_CFLAGS], [-Wall])

dnl Build with OpenSSL when asked
AC_ARG_WITH([openssl],
	AS_HELP_STRING([--with-openssl], [Build using OpenSSL library]),
	[with_openssl=$withval],
	[blank_openssl=yes])

dnl Build with GnutLS when asked
AC_ARG_WITH([gnutls],
	AS_HELP_STRING([--with-gnutls], [Build using GnuTLS library]),
	[with_gnutls=$withval],
	[blank_gnutls=yes])

dnl If no with[out]-'ssl' default to openssl
AS_IF([test "x$blank_openssl" = "xyes" -a "x$blank_gnutls" = "xyes"], [
	with_openssl=yes
])

dnl emulate previous build, without-openssl means build with gnutls
AS_IF([test "x$with_openssl" = "xno" -a "x$blank_gnutls" = "xyes"], [
	with_gnutls=yes
])

AC_ARG_ENABLE([multi-ssl], AS_HELP_STRING([--enable-multi-ssl],
		[Enable multiple ssl library implementations]),
	[enable_multi_ssl=$enableval],
	[enable_multi_ssl=no])

AS_IF([test "x$enable_multi_ssl" = "xno"], [
	AS_IF([test "x$with_openssl" = "xyes" -a "x$with_gnutls" = "xyes"], [
AC_MSG_ERROR([You need to enable multi-ssl to support multiple ssl implementations concurrently])
	])
])
AM_CONDITIONAL([MULTI_SSL], [test "x$enable_multi_ssl" = "xyes"])

AS_IF([test "x$with_openssl" = "xyes"], [
	PKG_CHECK_MODULES([OPENSSL], [openssl >= 0.9.8], [found_openssl=yes])
])
AM_CONDITIONAL([HAVE_OPENSSL], [test "x$found_openssl" = "xyes"])

AS_IF([test "x$with_gnutls" = "xyes"], [
	PKG_CHECK_MODULES([GNUTLS], [gnutls >= 3.5.8], [found_gnutls=yes])
])
AM_CONDITIONAL([HAVE_GNUTLS], [test "x$found_gnutls" = "xyes"])

AS_IF([test "x$found_openssl" != "xyes" -a "x$found_gnutls" != "xyes"], [
	AC_MSG_ERROR([Neither openssl nor gnutls was found])
])

dnl work out default, or only, ssl library
AC_MSG_CHECKING([which ssl library to use as default])
AC_ARG_WITH([default-ssl], AS_HELP_STRING([--with-default-ssl@<:@=Lib@:>@],
		[set default ssl library [openssl|gnutls] for multi-ssl]),
	[with_default_ssl=$withval],
	[with_default_ssl=yes])
dnl note, yes/blank case will require further nesting, if additional ssl lib support added
AS_CASE([$with_default_ssl],
	[openssl], [AS_IF([test "x$found_openssl" = "xyes"], [ssl_impl=openssl],
		[AC_MSG_ERROR([requested default ssl lib openssl, but openssl not found])]
			)],
	[gnutls], [AS_IF([test "x$found_gnutls" = "xyes"], [ssl_impl=gnutls],
		[AC_MSG_ERROR([requested default ssl lib gnutls, but gnutls not found])]
			)],
	[no], [AC_MSG_ERROR([unsupported configuration --without-default-ssl])],
	[yes], [AS_IF([test "x$found_openssl" = "xyes"], [ssl_impl=openssl],
			[ssl_impl=gnutls])],
	[AC_MSG_ERROR([Unknown ssl library $with_default_ssl])]
)
AC_MSG_RESULT([$ssl_impl])

AC_ARG_WITH([examples],
	AS_HELP_STRING([--without-examples], [do not build example programs]),
	[with_examples=$withval],
	[with_examples=yes])

AM_CONDITIONAL([BUILD_EXAMPLES], [test "x$with_examples" != "xno"])

dnl should not reach default case, bail out if it triggers
AS_CASE([$ssl_impl],
	[openssl], [
		AC_SUBST([SSL_DEF_LDFLAGS], [$OPENSSL_LDFLAGS])
		AC_SUBST([SSL_DEF_INCLUDES], [$OPENSSL_INCLUDES])
		AC_SUBST([SSL_DEF_CFLAGS], [$OPENSSL_CFLAGS])
		AC_SUBST([SSL_DEF_LIBS], [$OPENSSL_LIBS])
		],
	[gnutls], [
		AC_SUBST([SSL_DEF_LDFLAGS], [$GNUTLS_LDFLAGS])
		AC_SUBST([SSL_DEF_INCLUDES], [$GNUTLS_INCLUDES])
		AC_SUBST([SSL_DEF_CFLAGS], [$GNUTLS_CFLAGS])
		AC_SUBST([SSL_DEF_LIBS], [$GNUTLS_LIBS])
		],
	[AC_MSG_ERROR([unable to set default ssl library])]
)

PKG_CHECK_MODULES([JANSSON], [jansson >= 2.0])
PKG_CHECK_MODULES([CHECK], [check >= 0.9.4], [true], [true])

AX_VALGRIND_CHECK

AX_CODE_COVERAGE

WEAK_ALIAS_SUPPORT

DX_MAN_FEATURE(ON)
DX_HTML_FEATURE(ON)
DX_CHM_FEATURE(OFF)
DX_CHI_FEATURE(OFF)
DX_RTF_FEATURE(OFF)
DX_XML_FEATURE(OFF)
DX_PDF_FEATURE(OFF)
DX_PS_FEATURE(OFF)
DX_INIT_DOXYGEN($PACKAGE_NAME, doxygen.cfg)


AM_COND_IF([MULTI_SSL], [
	AM_COND_IF([HAVE_OPENSSL],
		[AC_CONFIG_FILES([libjwt/libjwt-ossl.pc])])
	AM_COND_IF([HAVE_GNUTLS],
		[AC_CONFIG_FILES([libjwt/libjwt-gnutls.pc])])
	])
AC_CONFIG_FILES([
	Makefile
	include/Makefile
	libjwt/Makefile
	examples/Makefile
	tests/Makefile
	libjwt/libjwt.pc
	dist/Makefile
	dist/libjwt.spec
])

AC_OUTPUT
