
message( "> tvxsrc:" )

#set( TARGET_NAME ${TARGET_PREFIX}_module )

#add_subdirectory( modules ) # Targets built in here will have names starting with ${TARGET_PREFIX}_module

set( TARGET_NAME ${TARGET_PREFIX}_game )

# Targets built out here will have names starting with ${TARGET_PREFIX}_game

# SDL Test
#add_executable( ${TARGET_NAME}_sdltest sdltest.cpp )
#target_link_libraries( ${TARGET_NAME}_sdltest ${TARGET_PREFIX}_interface )
#target_include_directories( ${TARGET_NAME}_sdltest PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} )

# Iris
add_executable( ${TARGET_NAME}_iris iris_test.cpp )
target_link_libraries( ${TARGET_NAME}_iris ${TARGET_PREFIX}_interface )
target_include_directories( ${TARGET_NAME}_iris PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} )
