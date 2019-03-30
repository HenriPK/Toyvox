


# Define functions to enable/disable compiler flags depending on compiler support
include( CheckCXXCompilerFlag )
# Enable a flag if the compiler you're using supports it: enable_cxx_compiler_flag_if_supported( "flag" )
function( enable_cxx_compiler_flag_if_supported flag )
  string( FIND "${CMAKE_CXX_FLAGS}" "${flag}" flag_already_set )
  if( flag_already_set EQUAL -1 )
    check_cxx_compiler_flag( "${flag}" flag_supported )
    if( flag_supported )
      set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}" )
    endif()
    unset( flag_supported CACHE )
  endif()
endfunction()
# [Experimental] Disable a flag if it's currently enabled: disable_cxx_compiler_flag_if_enabled( "flag" )
function( disable_cxx_compiler_flag_if_enabled flag )
  string( REPLACE "${flag}"
    "" modified_flags
    "${CMAKE_CXX_FLAGS}"
    )
  set( CMAKE_CXX_FLAGS "${modified_flags}" )
endfunction()



# Add external dependencies easily by calling extern( <action> <optional inputs> ) in the following ways:
# extern( include <dirs> ) to add directories to include
# extern( link <flags> )   to add libraries to link to or other flags
# extern( define <defs> )  to add compiler definitions
# extern( finish )         to combine all external dependencies into a single interface target for other targets to use.
# Only use the finish action once you're done calling any of the others, and you must use it for any of this to work.
# Link to ${TARGET_PREFIX}interface from other targets to access all external dependencies.
function( extern )
  set( args ${ARGN} )
  list( LENGTH args num_args )
  if( ${num_args} GREATER 0 )
    list( GET args 0 action )
    if( action STREQUAL "finish" )
      add_library( ${TARGET_PREFIX}interface INTERFACE )
      target_include_directories( ${TARGET_PREFIX}interface INTERFACE SYSTEM
        ${${TARGET_PREFIX}include}
        )
      target_link_libraries( ${TARGET_PREFIX}interface INTERFACE
        ${${TARGET_PREFIX}link}
        )
      target_compile_definitions( ${TARGET_PREFIX}interface INTERFACE
        ${${TARGET_PREFIX}define}
        )
      message( STATUS "EXTERN: ${action}: ${TARGET_PREFIX}interface combines all external dependencies." )
    elseif( action STREQUAL "include" OR action STREQUAL "link" OR action STREQUAL "define")
      if( ${num_args} GREATER 1 )
        list( SUBLIST args 1 -1 inputs )
        set( ${TARGET_PREFIX}${action} ${${TARGET_PREFIX}${action}} ${inputs} PARENT_SCOPE)
        message( STATUS "EXTERN: ${action} ${inputs}" )
      else()
        message( WARNING "EXTERN: ${action} action received no inputs")
      endif()
    else()
      message( WARNING "EXTERN: \"${action}\" is not a valid action.")
    endif()
  else()
    message( WARNING "EXTERN: No action specified." )
  endif()
endfunction()



# Deal with a few platform-specifc settings that don't fit anywhere else
if( WIN32 ) # Windows
else() # Linux tested only
  set( extra_linker_flags dl )
endif()