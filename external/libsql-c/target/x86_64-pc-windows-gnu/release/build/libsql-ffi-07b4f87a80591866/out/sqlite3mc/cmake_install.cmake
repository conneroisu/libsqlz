# Install script for directory: /Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/var/empty/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/nix/store/v0f9zjmnfsgmw04wlfya1w0bwfyz2l71-x86_64-w64-mingw32-gcc-wrapper-13.3.0/bin/x86_64-w64-mingw32-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/libsqlite3mc_static.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/sqlite3mc" TYPE FILE FILES
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3.h"
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3ext.h"
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3mc.h"
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3mc_version.h"
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3mc_vfs.h"
    "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/src/sqlite3userauth.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
  file(WRITE "/Users/connerohnesorge/Documents/001Repos/libsqlz/external/libsql-c/target/x86_64-pc-windows-gnu/release/build/libsql-ffi-07b4f87a80591866/out/sqlite3mc/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
