project(TestInstallation)
cmake_minimum_required(VERSION 3.5)

set(MyMath_root_dir "E:\\ANULLEVER\\modifing\\freeimage_cmk_Lite_sup_exprt\\freeimage_19.0.24215.1_install")

find_package(freeimage  REQUIRED  PATHS ${MyMath_root_dir} )

#find_package(minus 1.0 PATHS ${MyMath_root_dir} )


#add_definitions( -DOPJ_STATIC -DFREEIMAGE_LIB -DLIBRAW_NODLL )
#add_definitions(-DNO_LCMS -D__ANSI__ -DDISABLE_PERF_MEASUREMENT  -DDLL_CALLCONV )
#add_definitions(  -DFREEIMAGE_EXPORTS )
add_definitions(  -DFREEIMAGE_LIB )

add_executable(mymathApp mymathApp.cc)

target_link_libraries(mymathApp freeimage::freeimage   )
#
target_include_directories( mymathApp PRIVATE ${MyMath_root_dir}/include  )
