AC_INIT([edutils], [0.0.1], [jiverson002@csbsju.edu])

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

# Test scripts to create
AC_CONFIG_FILES([tests/release.test], [chmod +x tests/release.test])

AC_OUTPUT
