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

AS_IF([test "x$blank_openssl" = "xyes" -a "x$blank_gnutls" = "xyes"], [
	with_openssl=yes
])

AS_IF([test "x$with_openssl" = "xno" -a "x$blank_gnutls" = "xyes"], [
	with_gnutls=yes
])

AC_ARG_ENABLE([debian-compat], AS_HELP_STRING([--enable-debian-compat],
		[Enable Debian style lib naming: libjwt-gnutls]),
	[enable_debian_compat=$enableval],
	[enable_debian_compat=no])

AS_IF([test "x$enable_debian_compat" = "xno"], [
	AS_IF([test "x$with_openssl" = "xyes" -a "x$with_gnutls" = "xyes"], [
AC_MSG_ERROR([You need to enable debian-compat to simultaneously build with openssl and gnutls])
	])
])

AM_CONDITIONAL([DEBIAN_COMPAT], [test "x$enable_debian_compat" = "xyes"])

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

dnl work out if examples are to built and with what library, default to openssl
dnl  no case still requires setting ssl_impl
AC_MSG_CHECKING([whether to build examples and which ssl library to use])
AC_ARG_WITH([examples],	AS_HELP_STRING([--with-examples@<:@=Lib@:>@],
		[build example programs with ssl library [openssl|gnutls]]),
	[with_examples=$withval],
	[with_examples=yes])
AS_CASE([$with_examples],
	[openssl], [AS_IF([test "x$found_openssl" = "xyes"], [ssl_impl=openssl],
		[AC_MSG_ERROR([requested examples built with openssl, but openssl not found])]
			)],
	[gnutls], [AS_IF([test "x$found_gnutls" = "xyes"], [ssl_impl=gnutls],
		[AC_MSG_ERROR([requested examples built with gnutls, but gnutls not found])]
			)],
	[no], [AS_IF([test "x$found_openssl" = "xyes"], [ssl_impl=openssl],
			[ssl_impl=gnutls])],
	[yes], [AS_IF([test "x$found_openssl" = "xyes"], [ssl_impl=openssl],
			[ssl_impl=gnutls])],
	[AC_MSG_ERROR([Unknown ssl library $with_examples])]
)
AC_MSG_RESULT([$ssl_impl])

AM_CONDITIONAL([BUILD_EXAMPLES], [test "x$with_examples" != "xno"])

AM_CONDITIONAL([SSL_IMP_OSSL], [test "x$ssl_impl" = "xopenssl"])

dnl should not reach default case, bail out if it triggers
AS_CASE([$ssl_impl],
	[openssl], [
		AC_SUBST([SSL_IMP_LDFLAGS], [$OPENSSL_LDFLAGS])
		AC_SUBST([SSL_IMP_INCLUDES], [$OPENSSL_INCLUDES])
		AC_SUBST([SSL_IMP_CFLAGS], [$OPENSSL_CFLAGS])
		AC_SUBST([SSL_IMP_LIBS], [$OPENSSL_LIBS])
		],
	[gnutls], [
		AC_SUBST([SSL_IMP_LDFLAGS], [$GNUTLS_LDFLAGS])
		AC_SUBST([SSL_IMP_INCLUDES], [$GNUTLS_INCLUDES])
		AC_SUBST([SSL_IMP_CFLAGS], [$GNUTLS_CFLAGS])
		AC_SUBST([SSL_IMP_LIBS], [$GNUTLS_LIBS])
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

dnl need a conditional so as to only ac_config_files libjwt.pc once
AS_IF([test "x$enable_debian_compat" = "xyes"], [
	AM_CONDITIONAL([DO_LIBJWTPC], [test "x$found_openssl" = "xyes"])
	], [
	AM_CONDITIONAL([DO_LIBJWTPC], [true])
	]
)

AM_COND_IF([DEBIAN_COMPAT], [
	AM_COND_IF([HAVE_GNUTLS],
		[AC_CONFIG_FILES([libjwt/libjwt-gnutls.pc])])
	])
AM_COND_IF([DO_LIBJWTPC], [
	AC_CONFIG_FILES([libjwt/libjwt.pc])
	])
AC_CONFIG_FILES([
	Makefile
	include/Makefile
	libjwt/Makefile
	examples/Makefile
	tests/Makefile
	dist/Makefile
	dist/libjwt.spec
])

AC_OUTPUT
