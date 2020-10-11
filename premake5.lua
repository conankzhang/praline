workspace "Praline"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

    startproject "Sandbox"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Praline"
    location "Praline"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/vendor/spdlog/include"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "PRALINE_PLATFORM_WINDOWS",
            "PRALINE_BUILD_DLL"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "PRALINE_DEBUG"
        symbols "On"


    filter "configurations:Release"
        defines "PRALINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "PRALINE_DIST"
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "Praline/vendor/spdlog/include",
        "Praline/src"
    }

    links
    {
        "Praline"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "PRALINE_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "PRALINE_DEBUG"
        symbols "On"


    filter "configurations:Release"
        defines "PRALINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "PRALINE_DIST"
        optimize "On"
