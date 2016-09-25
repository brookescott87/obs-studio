if (NOT WIN32)
	return()
endif()

project(obs-datetime)

if(WIN32)
	set(obs-datetime_PLATFORM_SOURCES
		gdiplus/obs-datetime.cpp)
	set(obs-datetime_PLATFORM_DEPS
		gdiplus)
endif()

add_library(obs-datetime MODULE
	${obs-datetime_PLATFORM_SOURCES}
	${obs-datetime_PLATFORM_HEADERS})
target_link_libraries(obs-datetime
	libobs
	${obs-datetime_PLATFORM_DEPS})

install_obs_plugin_with_data(obs-datetime data)
