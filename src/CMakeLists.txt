#-------------------------------------------------------------------------------
# Build options
#-------------------------------------------------------------------------------
option(WITH_RELEASE  "Build release program"  ON)
option(WITH_RENDER   "Build render program"   ON)
option(WITH_WATCHDOG "Build watchdog program" ON)

#-------------------------------------------------------------------------------
# Search for dependencies
#-------------------------------------------------------------------------------
find_program(BUNDLE_EXE bundle)
if(BUNDLE_EXE)
  message(STATUS "Found bundle: ${BUNDLE_EXE}")
endif()

find_program(PANDOC_EXE pandoc)
if(PANDOC_EXE)
  message(STATUS "Found pandoc: ${PANDOC_EXE}")
endif()

find_program(XELATEX_EXE xelatex)
if(XELATEX_EXE)
  message(STATUS "Found xelatex: ${XELATEX_EXE}")
endif()

#-------------------------------------------------------------------------------
# Dependency checks
#-------------------------------------------------------------------------------
if(NOT BUNDLE_EXE)
  set(WITH_WATCHDOG OFF)
  message(STATUS "WARNING: watchdog will not be installed (bundle is missing)")
endif()

if(NOT PANDOC_EXE OR NOT XELATEX_EXE)
  set(WITH_RENDER OFF)
  if(NOT PANDOC_EXE AND NOT XELATEX_EXE)
    set(missing "pandoc and xelatex are")
  elseif(NOT PANDOC_EXE)
    set(missing "pandoc is")
  elseif(NOT XELATEX_EXE)
    set(missing "xelatex is")
  endif()
  message(STATUS "WARNING: render will not be installed (${missing} missing)")
endif()

#-------------------------------------------------------------------------------
# Install options
#-------------------------------------------------------------------------------
if(WITH_RELEASE)
  install(PROGRAMS release DESTINATION bin)
endif()

if(WITH_RENDER)
  install(PROGRAMS render DESTINATION bin)
endif()

if(WITH_WATCHDOG)
  install(PROGRAMS watchdog DESTINATION bin)
endif()
