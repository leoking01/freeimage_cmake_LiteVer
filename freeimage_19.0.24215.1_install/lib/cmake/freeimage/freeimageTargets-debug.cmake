#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "freeimage::freeimage" for configuration "Debug"
set_property(TARGET freeimage::freeimage APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(freeimage::freeimage PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/freeimaged.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS freeimage::freeimage )
list(APPEND _IMPORT_CHECK_FILES_FOR_freeimage::freeimage "${_IMPORT_PREFIX}/lib/freeimaged.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
