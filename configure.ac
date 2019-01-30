AC_INIT([edutils], [0.0.1], [jiverson002@csbsju.edu])
AC_SUBST([PACKAGE_COPYRIGHT], [2019])

AM_INIT_AUTOMAKE([-Wall -Werror])

# Makefiles to create.
AC_CONFIG_FILES([
  Makefile
  dep/Makefile
  src/Makefile
  tests/Makefile
])

# Executable scripts to create
AC_CONFIG_FILES([src/release], [chmod +x src/release])
AC_CONFIG_FILES([src/render], [chmod +x src/render])

# Test scripts to create
AC_CONFIG_FILES([tests/release.test], [chmod +x tests/release.test])

# Req'd for dynamic generation of render
AC_SUBST_FILE([render_language])
AC_SUBST_FILE([render_override])
AC_SUBST_FILE([render_vbnet])
render_language=$srcdir/src/render.d/language.dtd
render_override=$srcdir/src/render.d/override.tex
render_vbnet=$srcdir/src/render.d/vbnet.xml

# Dynamically generate files
AC_OUTPUT
