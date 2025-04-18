cmake_minimum_required(VERSION 3.30)
project(libcurl-test C)

block(SCOPE_FOR VARIABLES)
    # blocked by FindOpenSSL in CMake 3.30: set(CMAKE_DISABLE_FIND_PACKAGE_PkgConfig 1)

    find_package(CURL COMPONENTS libz REQUIRED)

    add_executable(main main.c)
    target_link_libraries(main PRIVATE CURL::libcurl)
endblock()

block(SCOPE_FOR VARIABLES)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(libcurl_pc libcurl REQUIRED IMPORTED_TARGET)

    add_executable(main-pkgconfig main.c)
    target_link_libraries(main-pkgconfig PRIVATE PkgConfig::libcurl_pc)
endblock()

block(SCOPE_FOR VARIABLES)
if(NOT CMAKE_HOST_WIN32)
    find_program(CURL_CONFIG NAMES curl-config REQUIRED)
    execute_process(COMMAND "${CURL_CONFIG}" --cflags OUTPUT_VARIABLE curl-config-cflags OUTPUT_STRIP_TRAILING_WHITESPACE)
    separate_arguments(curl-config-cflags UNIX_COMMAND "${curl-config-cflags}")
    execute_process(COMMAND "${CURL_CONFIG}" --libs OUTPUT_VARIABLE curl-config-libs OUTPUT_STRIP_TRAILING_WHITESPACE)
    separate_arguments(curl-config-libs UNIX_COMMAND "${curl-config-libs}")
    string(REGEX REPLACE "(^-|;-)framework;" "\\1framework " curl-config-libs "${curl-config-libs}")

    add_executable(main-curl-config main.c)
    target_compile_options(main-curl-config PRIVATE ${curl-config-cflags})
    target_link_libraries(main-curl-config PRIVATE ${curl-config-libs})
endif()
endblock()
