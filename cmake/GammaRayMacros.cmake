#
# GAMMARAY_ADD_PLUGIN: create a gammaray plugin, install at the right place, etc
#

#  Copyright (c) 2011-2014 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>

# Author: Volker Krause <volker.krause@kdab.com>
#
# Redistribution and use is allowed according to the terms of the BSD license.

macro(gammaray_add_plugin _target_name _desktop_file)
  if(NOT PLUGIN_INSTALL_DIR) # HACK for external plugins that don't set PLUGIN_INSTALL_DIR
    set(PLUGIN_INSTALL_DIR ${GAMMARAY_PLUGIN_INSTALL_DIR})
  endif()
  set(_install_target_dir_base "${PLUGIN_INSTALL_DIR}/${GAMMARAY_PLUGIN_VERSION}/")
  set(_install_target_dir "${_install_target_dir_base}/${GAMMARAY_PROBE_ABI}")
  set(_build_target_dir "${PROJECT_BINARY_DIR}/${_install_target_dir}")
  set(_build_target_dir_DEBUG   "${PROJECT_BINARY_DIR}/${_install_target_dir_base}/${GAMMARAY_PROBE_ABI_DEBUG}")
  set(_build_target_dir_RELEASE "${PROJECT_BINARY_DIR}/${_install_target_dir_base}/${GAMMARAY_PROBE_ABI_RELEASE}")

  add_library(${_target_name} MODULE ${ARGN})

  if(MSVC_IDE)
    set_target_properties(${_target_name} PROPERTIES
      PREFIX ""
      LIBRARY_OUTPUT_DIRECTORY ${_build_target_dir}
      LIBRARY_OUTPUT_DIRECTORY_DEBUG ${_build_target_dir_DEBUG}
      LIBRARY_OUTPUT_DIRECTORY_RELEASE ${_build_target_dir_RELEASE}
    )
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${_desktop_file}" "${_build_target_dir_DEBUG}/${_desktop_file}")
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${_desktop_file}" "${_build_target_dir_RELEASE}/${_desktop_file}")
  else()
    set_target_properties(${_target_name} PROPERTIES
      PREFIX ""
      LIBRARY_OUTPUT_DIRECTORY ${_build_target_dir}
    )
      configure_file("${CMAKE_CURRENT_SOURCE_DIR}/${_desktop_file}" "${_build_target_dir}/${_desktop_file}")
  endif()
  install(TARGETS ${_target_name} DESTINATION ${_install_target_dir})
  install(FILES ${_desktop_file} DESTINATION ${_install_target_dir})
endmacro()
