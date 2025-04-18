cmake_minimum_required(VERSION 3.8)
project(libxmlmm CXX)

find_package(LibXml2 REQUIRED)

set(HEADERS_LIBXMLMM
	libxmlmm/Attribute.h
	libxmlmm/CData.h
	libxmlmm/Comment.h
	libxmlmm/Content.h
	libxmlmm/defines.h
	libxmlmm/Document.h
	libxmlmm/Element.h
	libxmlmm/exceptions.h
	libxmlmm/libxmlmm.h
	libxmlmm/LibXmlSentry.h
	libxmlmm/Node.h
	libxmlmm/ProcessingInstruction.h
	libxmlmm/Text.h
	libxmlmm/utils.h
)

set(SOURCES_LIBXMLMM
	libxmlmm/Attribute.cpp
	libxmlmm/CData.cpp
	libxmlmm/Comment.cpp
	libxmlmm/Content.cpp
	libxmlmm/Document.cpp
	libxmlmm/Element.cpp
	libxmlmm/LibXmlSentry.cpp
	libxmlmm/Node.cpp
	libxmlmm/ProcessingInstruction.cpp
	libxmlmm/Text.cpp
	libxmlmm/utils.cpp
)

add_library(libxmlmm ${SOURCES_LIBXMLMM})
target_link_libraries (libxmlmm PUBLIC LibXml2::LibXml2)

set_target_properties(libxmlmm PROPERTIES
    CXX_STANDARD 17
    PUBLIC_HEADER "${HEADERS_LIBXMLMM}"
    OUTPUT_NAME xmlmm
)

target_include_directories(libxmlmm PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/libxmlmm>
    $<INSTALL_INTERFACE:include/libxmlmm>)

install(TARGETS libxmlmm
    EXPORT unofficial-libxmlmm-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include/libxmlmm
)
install(EXPORT unofficial-libxmlmm-targets
    NAMESPACE unofficial::libxmlmm::
    DESTINATION share/unofficial-libxmlmm
)

configure_file(libxmlmm.pc.in ${CMAKE_CURRENT_BINARY_DIR}/libxmlmm.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libxmlmm.pc DESTINATION lib/pkgconfig)
