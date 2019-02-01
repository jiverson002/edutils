AC_INIT([edutils], [0.0.0], [jiverson002@csbsju.edu])
AC_SUBST([PACKAGE_COPYRIGHT], [2019])

AM_INIT_AUTOMAKE([-Wall -Werror])

dnl Makefiles to create.
AC_CONFIG_FILES([
  Makefile
  dep/Makefile
  src/Makefile
  tests/Makefile
])

dnl #########################################################
dnl Check for various programs that these utilities depend on
dnl #########################################################

dnl ######
dnl pandoc
dnl ######
AC_ARG_VAR([PANDOC], [Path to the pandoc executable])
dnl check if PANDOC is set
AM_CONDITIONAL([HAVE_PANDOC], [test -n "$PANDOC"])
dnl if not, search for pandoc executable
AM_COND_IF([HAVE_PANDOC],, [AC_PATH_PROG([PANDOC], [pandoc])])
dnl retest
AM_CONDITIONAL([HAVE_PANDOC], [test -n "$PANDOC"])

dnl #######
dnl xelatex
dnl #######
AC_ARG_VAR([XELATEX], [Path to the xelatex executable])
dnl check if XELATEX is set
AM_CONDITIONAL([HAVE_XELATEX], [test -n "$XELATEX"])
dnl if not, search for xelatex executable
AM_COND_IF([HAVE_XELATEX],, [AC_PATH_PROG([XELATEX], [xelatex])])
dnl retest
AM_CONDITIONAL([HAVE_XELATEX], [test -n "$XELATEX"])

dnl ##########################################
dnl Configure each of the programs to be built
dnl ##########################################

dnl #######
dnl release
dnl #######
AC_CONFIG_FILES([src/release], [chmod +x src/release])
AC_CONFIG_FILES([tests/release.test], [chmod +x tests/release.test])

dnl ######
dnl render
dnl ######
AM_CONDITIONAL([RENDER], [test -n "$HAVE_PANDOC" && test -n "$HAVE_XELATEX"])
AM_COND_IF([HAVE_PANDOC], [
  AM_COND_IF([HAVE_XELATEX], [
    dnl add render to list of build programs
    AC_CONFIG_FILES([src/render], [chmod +x src/render])

    dnl create file substitution variables
    AC_SUBST_FILE([render_language])
    AC_SUBST_FILE([render_override])
    AC_SUBST_FILE([render_vbnet])

    dnl define req'd shell variables
    render_language=$srcdir/src/render.d/language.dtd
    render_override=$srcdir/src/render.d/override.tex
    render_vbnet=$srcdir/src/render.d/vbnet.xml
  ], [
    AC_MSG_WARN([render will not be installed (xelatex is missing)])
  ])
], [
  AC_MSG_WARN([render will not be installed (pandoc is missing)])
])

dnl Finish
AC_OUTPUT
