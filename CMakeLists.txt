cmake_minimum_required(VERSION 3.8.0)

# only test on linux
OPTION(ENABLE_PNG "Enable PNG support" 1)
OPTION(ENABLE_JPEG "Enable JPEG support" 1)
OPTION(ENABLE_TIFF "Enable TIFF support" 1)
OPTION(ENABLE_JXR "Enable JXR support" 1)

# currently these parts not working 
OPTION(ENABLE_WEBP "Enable WebP support" 0)
OPTION(ENABLE_RAW "Enable RAW support" 0)
OPTION(ENABLE_OPENJP "Enable OpenJPEG support" 0)
OPTION(ENABLE_OPENEXR "Enable OpenEXR support" 0)

project (freeimage    LANGUAGES CXX
    VERSION 0.1.1
    )

# Check parameters
INCLUDE(CheckIncludeFile)
INCLUDE(CheckIncludeFileCXX)
INCLUDE(CheckFunctionExists)
INCLUDE(CheckTypeSize)

add_definitions(-DNO_LCMS -D__ANSI__ -DDISABLE_PERF_MEASUREMENT)

# headers
include_directories ( Source Source/Metadata Source/FreeImageToolkit Source/LibJPEG Source/LibPNG Source/LibTIFF4 Source/ZLib Source/LibOpenJPEG Source/OpenEXR Source/OpenEXR/Half Source/OpenEXR/Iex Source/OpenEXR/IlmImf Source/OpenEXR/IlmThread Source/OpenEXR/Imath Source/OpenEXR/IexMath Source/LibRawLite Source/LibRawLite/dcraw Source/LibRawLite/internal Source/LibRawLite/libraw Source/LibRawLite/src Source/LibWebP Source/LibJXR Source/LibJXR/common/include Source/LibJXR/image/sys Source/LibJXR/jxrgluelib)

# SOURCES
set(Sources ${PROJECT_SOURCE_DIR}/Source)
file(GLOB DeprecationManager ${Sources}/DeprecationManager/*.c ${Sources}/DeprecationManager/*.cpp)
file(GLOB FreeImage ${Sources}/FreeImage/*.cpp ${Sources}/FreeImage/*.c)
file(GLOB FreeImageToolkit ${Sources}/FreeImageToolkit/*.c ${Sources}/FreeImageToolkit/*.cpp)
file(GLOB LibJPEG ${Sources}/LibJPEG/*.c ${Sources}/LibJPEG/*.cpp)
file(GLOB_RECURSE LibJXR ${Sources}/LibJXR/*.c ${Sources}/LibJXR/*.cpp)
file(GLOB LibOpenJPEG ${Sources}/LibOpenJPEG/*.cpp ${Sources}/LibOpenJPEG/*.c)
file(GLOB LibPNG ${Sources}/LibPNG/*.cpp ${Sources}/LibPNG/*.c)
file(GLOB_RECURSE LibRawLite ${Sources}/LibRawLite/*.c ${Sources}/LibRawLite/*.cpp)
file(GLOB LibTIFF4 ${Sources}/LibTIFF4/*cpp ${Sources}/LibTIFF4/*.c)
file(GLOB_RECURSE LibWebP ${Sources}/LibWebP/*.cpp ${Sources}/LibWebP/*.c)
file(GLOB Metadata ${Sources}/Metadata/*.c ${Sources}/Metadata/*.cpp)
file(GLOB_RECURSE OpenEXR ${Sources}/OpenEXR/*.cpp ${Sources}/OpenEXR/*.c)
file(GLOB ZLib ${Sources}/ZLib/*.cpp ${Sources}/ZLib/*.c)

# only works on linux
# remove compiling issues
list(REMOVE_ITEM LibJPEG ${Sources}/LibJPEG/jmemdos.c)
list(REMOVE_ITEM LibJPEG ${Sources}/LibJPEG/jmemmac.c)
list(REMOVE_ITEM LibJPEG ${Sources}/LibJPEG/ansi2knr.c)
list(REMOVE_ITEM LibTIFF4 ${Sources}/LibTIFF4/tif_unix.c)
list(REMOVE_ITEM LibTIFF4 ${Sources}/LibTIFF4/tif_vms.c)
list(REMOVE_ITEM LibTIFF4 ${Sources}/LibTIFF4/tif_win32.c)
list(REMOVE_ITEM LibTIFF4 ${Sources}/LibTIFF4/tif_wince.c)

SET(LIBS 
${DeprecationManager}
${FreeImage}
${FreeImageToolkit}
${ZLib}
)


IF(ENABLE_PNG)
  SET(LIBS ${LIBS} ${LibPNG})
ENDIF()
IF(ENABLE_JPEG)
  SET(LIBS ${LIBS} ${LibJPEG})
ENDIF()
IF(ENABLE_TIFF)
  SET(LIBS ${LIBS} ${LibTIFF4})
ENDIF()
IF(ENABLE_WEBP)
  SET(LIBS ${LIBS} ${LibWebP})
ENDIF()
IF(ENABLE_RAW)
  SET(LIBS ${LIBS} ${LibRawLite})
ENDIF()
IF(ENABLE_OPENJP)
  SET(LIBS ${LIBS} ${LibOpenJPEG})
ENDIF()
IF(ENABLE_OPENEXR)
  SET(LIBS ${LIBS} ${OpenEXR})
ENDIF()
IF(ENABLE_JXR)
  SET(LIBS ${LIBS} ${LibJXR})
ENDIF()


add_library ( freeimage     ${LIBS} )

install ( TARGETS freeimage DESTINATION lib )
install ( FILES Source/FreeImage.h DESTINATION include )
















#-------------------install  destation ---------------------------
#set( DESTINATION  "../install/")
set(CMAKE_INSTALL_PREFIX "../install_FreeImage_VC14/")
#          And to the end of the top-level CMakeLists.txt we add:
#install(TARGETS ${PROJECT_NAME} DESTINATION bin)
#install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"  DESTINATION include  )


if (1)
    #
    # Format the project using the `clang-format` target (i.e: cmake --build build --target clang-format)
    #

    #add_clang_format_target()

    #
    # Install library for easy downstream inclusion
    #

    include(GNUInstallDirs)
    install(
        TARGETS
        ${PROJECT_NAME}
        EXPORT
        ${PROJECT_NAME}Targets
        LIBRARY DESTINATION
        ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION
        ${CMAKE_INSTALL_BINDIR}
        ARCHIVE DESTINATION
        ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION
        include
        PUBLIC_HEADER DESTINATION
        include
        )

    install(
        EXPORT
        ${PROJECT_NAME}Targets
        FILE
        ${PROJECT_NAME}Targets.cmake
        NAMESPACE
        ${PROJECT_NAME}::
        DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    #
    # Add version header
    #

    configure_file(
        ${CMAKE_CURRENT_LIST_DIR}/cmake/version.hpp.in
        include/${PROJECT_NAME_LOWERCASE}/version.hpp
        @ONLY
        )

    install(
        FILES
        ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME_LOWERCASE}/version.hpp
        DESTINATION
        include/${PROJECT_NAME_LOWERCASE}
        )

    #
    # Install the `include` directory
    #

    #install(
    #    DIRECTORY
    ##    include/${PROJECT_NAME_LOWERCASE}
    #    BasicDef/${PROJECT_NAME_LOWERCASE}
    #     exportApi/${PROJECT_NAME_LOWERCASE}
    #     DESTINATION
    #    include
    #    )

    install(
        FILES
        #    include/${PROJECT_NAME_LOWERCASE}
        #  inc/SOIL/image_DXT.h
        #  inc/SOIL/image_helper.h
        #  inc/SOIL/SOIL.h
        #  inc/SOIL/stb_image_aug.h
        #  inc/SOIL/stbi_DDS_aug_c.h
        #  inc/SOIL/stbi_DDS_aug.h
        Source/FreeImage.h
        #  exportApi/${PROJECT_NAME_LOWERCASE}/api_vision.h
        #     exportApi/${PROJECT_NAME_LOWERCASE}
        DESTINATION
        include/
        )


    #verbose_message("Install targets succesfully build. Install with `cmake --build <build_directory> --target install --config <build_config>`.")

    #
    # Quick `ConfigVersion.cmake` creation
    #

    include(CMakePackageConfigHelpers)
    write_basic_package_version_file(
        ${PROJECT_NAME}ConfigVersion.cmake
        VERSION
        ${PROJECT_VERSION}
        COMPATIBILITY
        SameMajorVersion
        )

    configure_package_config_file(
        ${CMAKE_CURRENT_LIST_DIR}/cmake/${PROJECT_NAME}Config.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        INSTALL_DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    install(
        FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
        DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        )

    #
    # Generate export header if specified
    #

    if (${PROJECT_NAME}_GENERATE_EXPORT_HEADER)
        include(GenerateExportHeader)
        generate_export_header(${PROJECT_NAME})
        install(
            FILES
            ${PROJECT_BINARY_DIR}/${PROJECT_NAME_LOWERCASE}_export.h
            DESTINATION
            include
            )
        message(STATUS "Generated the export header `${PROJECT_NAME_LOWERCASE}_export.h` and installed it.")
    endif ()

    message(STATUS "Finished building requirements for installing the package.\n")

    #
    # Unit testing setup
    #
    if (0)
        if (${PROJECT_NAME}_ENABLE_UNIT_TESTING)
            enable_testing()
            message(STATUS "Build unit tests for the project. Tests should always be found in the test folder\n")
            add_subdirectory(test)
        endif ()
    endif ()


endif ()












