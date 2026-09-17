project "enkiTS"
    kind "StaticLib"
    language "C++"

    configurations { "Debug", "Release", "Dist" }

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Mirrors CMakeLists.txt's default static-library target (ENKITS_BUILD_SHARED
    -- OFF, ENKITS_BUILD_C_INTERFACE ON) - see ThirdParties/enkiTS/CMakeLists.txt.
    files {
        "src/LockLessMultiReadPipe.h",
        "src/TaskScheduler.h",
        "src/TaskScheduler.cpp",
        "src/TaskScheduler_c.h",
        "src/TaskScheduler_c.cpp"
    }

    includedirs { "src" }

    filter "system:windows"
        systemversion "latest"

    filter "system:linux or bsd"
        pic "On"

        -- CMakeLists.txt links Threads and adds -pthread for the C++11
        -- <thread>/<atomic> usage in TaskScheduler.cpp on non-Windows.
        links { "pthread" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        symbols "off"
