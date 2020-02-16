#-------------------------------------------------------------------------------
# Search for dependencies
#-------------------------------------------------------------------------------
find_program(RUBOCOP_EXE rubocop)
if(RUBOCOP_EXE)
  message(STATUS "Found rubocop: ${RUBOCOP_EXE}")
endif()

#-------------------------------------------------------------------------------
# release test related
#-------------------------------------------------------------------------------
configure_file(release.test.in release.test @ONLY)
add_test(release release.test)

#-------------------------------------------------------------------------------
# watchdog test related
#-------------------------------------------------------------------------------
configure_file(watchdog.test.in watchdog.test @ONLY)
configure_file(watchdog/tests.in watchdog/tests @ONLY)
configure_file(watchdog/_watchdog.yml.in watchdog/_watchdog.yml @ONLY)
add_test(watchdog watchdog.test)
