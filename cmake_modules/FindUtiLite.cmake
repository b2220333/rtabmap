# - Find UTILITE
# This module finds an installed UTILITE package.
#
# It sets the following variables:
#  UTILITE_FOUND              - Set to false, or undefined, if UTILITE isn't found.
#  UTILITE_INCLUDE_DIR        - The UTILITE include directory.
#  UTILITE_LIBRARY            - The UTILITE library to link against.
#  URESOURCEGENERATOR_EXEC    - The resource generator tool executable
#
# 

SET(UTILITE_VERSION_REQUIRED 0.2.11)

FIND_PROGRAM(URESOURCEGENERATOR_EXEC NAME uresourcegenerator PATHS)  
IF(URESOURCEGENERATOR_EXEC)  
	EXECUTE_PROCESS(COMMAND ${URESOURCEGENERATOR_EXEC} -v 
			   	    OUTPUT_VARIABLE UTILITE_VERSION
					OUTPUT_STRIP_TRAILING_WHITESPACE
					WORKING_DIRECTORY "./"
	)
	
	IF(UTILITE_VERSION VERSION_LESS UTILITE_VERSION_REQUIRED)
	    IF(UtiLite_FIND_REQUIRED)
	    	MESSAGE(FATAL_ERROR "Your version of UtiLite is too old (${UTILITE_VERSION}), UtiLite ${UTILITE_VERSION_REQUIRED} is required.")
	    ENDIF(UtiLite_FIND_REQUIRED)
	ENDIF(UTILITE_VERSION VERSION_LESS UTILITE_VERSION_REQUIRED)

	IF(WIN32)
		FIND_PATH(UTILITE_INCLUDE_DIR 
				  utilite/UEventsManager.h
				  PATH_SUFFIXES "../include")
	
		FIND_LIBRARY(UTILITE_LIBRARY NAMES utilite
					PATH_SUFFIXES "../lib")
	
	ELSE()
		FIND_PATH(UTILITE_INCLUDE_DIR 
				  utilite/UEventsManager.h)
	
		FIND_LIBRARY(UTILITE_LIBRARY NAMES utilite)
	ENDIF()
	
	IF (UTILITE_INCLUDE_DIR AND UTILITE_LIBRARY)
	   SET(UTILITE_FOUND TRUE)
	ENDIF (UTILITE_INCLUDE_DIR AND UTILITE_LIBRARY)
ENDIF(URESOURCEGENERATOR_EXEC)

IF (UTILITE_FOUND)
   # show which UTILITE was found only if not quiet
   IF (NOT UtiLite_FIND_QUIETLY)
      MESSAGE(STATUS "Found UtiLite ${UTILITE_VERSION}")
   ENDIF (NOT UtiLite_FIND_QUIETLY)
   IF (NOT URESOURCEGENERATOR_EXEC)
      MESSAGE(STATUS "uresourcegenerator was not found")
   ENDIF (NOT URESOURCEGENERATOR_EXEC)
ELSE ()
   # fatal error if UTILITE is required but not found
   IF (UtiLite_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find UtiLite. Verify your PATH if it is already installed or download it at http://utilite.googlecode.com")
   ENDIF (UtiLite_FIND_REQUIRED)
ENDIF ()

