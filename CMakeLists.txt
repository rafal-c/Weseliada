cmake_minimum_required(VERSION 3.5)

project(Weseliada LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick LinguistTools QuickControls2 REQUIRED)

set(TS_FILES Weseliada_pl_PL.ts)

set(CPP_INCLUDE_DIR "include")
set(CPP_HEADERS
	${CPP_INCLUDE_DIR}/scoreboardmodel.h
	${CPP_INCLUDE_DIR}/sidebarmodel.h
	${CPP_INCLUDE_DIR}/answerareamodel.h
	${CPP_INCLUDE_DIR}/questionlistmodel.h
	${CPP_INCLUDE_DIR}/answerlistmodel.h
	${CPP_INCLUDE_DIR}/teamscoremodel.h)

set(CPP_SRC_DIR "src")
set(CPP_SOURCES
	${CPP_SRC_DIR}/main.cpp
	${CPP_SRC_DIR}/scoreboardmodel.cpp
	${CPP_SRC_DIR}/sidebarmodel.cpp
	${CPP_SRC_DIR}/answerareamodel.cpp
	${CPP_SRC_DIR}/questionlistmodel.cpp
	${CPP_SRC_DIR}/answerlistmodel.cpp
	${CPP_SRC_DIR}/teamscoremodel.cpp)

if(ANDROID)
    add_library(Weseliada SHARED
	  ${CPP_SOURCES}
      qml.qrc
	  resources.qrc
      ${TS_FILES}
    )
else()
	add_executable(Weseliada
	  ${CPP_SOURCES}
	  qml.qrc
	  resources.qrc
      ${TS_FILES}
	  ${CPP_HEADERS}
    )
endif()

target_compile_definitions(Weseliada
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(Weseliada
  PRIVATE Qt5::Core Qt5::Quick Qt5::QuickControls2)
target_include_directories(Weseliada
  PRIVATE ${CPP_INCLUDE_DIR})

qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
