cmake_minimum_required(VERSION 3.8)

set(Yolo_mark_MAJOR_VERSION 0)
set(Yolo_mark_MINOR_VERSION 2)
set(Yolo_mark_PATCH_VERSION 5)
set(Yolo_mark_VERSION ${Yolo_mark_MAJOR_VERSION}.${Yolo_mark_MINOR_VERSION}.${Yolo_mark_PATCH_VERSION})

set(CMAKE_VERBOSE_MAKEFILE "FALSE" CACHE BOOL "Create verbose makefile")

if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
  message(STATUS "VCPKG found: $ENV{VCPKG_ROOT}")
  message(STATUS "Using VCPKG integration")
endif()

project(Yolo_mark VERSION ${Yolo_mark_VERSION})

enable_language(CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules/" ${CMAKE_MODULE_PATH})

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "Install prefix" FORCE)
endif()
set(INSTALL_BIN_DIR      "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "Path where exe will be installed")

find_package(OpenCV REQUIRED)
list(APPEND OpenCV_LINKED_COMPONENTS "opencv_video")
if(OpenCV_VERSION VERSION_LESS "4.0")
  list(APPEND OpenCV_LINKED_COMPONENTS "opencv_videoio")
  list(APPEND OpenCV_LINKED_COMPONENTS "opencv_highgui")
endif()

set(Yolo_mark_SOURCES "${CMAKE_CURRENT_LIST_DIR}/src/main.cpp")

add_executable(yolo_mark ${Yolo_mark_SOURCES})
target_link_libraries(yolo_mark ${OpenCV_LINKED_COMPONENTS})
install(TARGETS yolo_mark DESTINATION "${INSTALL_BIN_DIR}")
