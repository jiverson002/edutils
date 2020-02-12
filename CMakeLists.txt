cmake_minimum_required(VERSION 3.0)

project(edutils LANGUAGES NONE)

#-------------------------------------------------------------------------------
# Build scripts
#-------------------------------------------------------------------------------
add_subdirectory(src)

#-------------------------------------------------------------------------------
# ...
#-------------------------------------------------------------------------------
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)

  if(BUILD_TESTING)
    add_subdirectory(test)
  endif()
endif()
