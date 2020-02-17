#-------------------------------------------------------------------------------
# release test related
#-------------------------------------------------------------------------------
configure_file(release.test.in release.test @ONLY)
add_test(release release.test)

#-------------------------------------------------------------------------------
# watchdog test related
#-------------------------------------------------------------------------------
if(WITH_WATCHDOG)
  configure_file(watchdog.test.in watchdog.test @ONLY)
  configure_file(watchdog/tests.in watchdog/tests @ONLY)
  add_test(watchdog watchdog.test)
endif()
