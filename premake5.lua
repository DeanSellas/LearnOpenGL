workspace "LearnOpenGL"
	architecture "x64"
	startproject "LearnOpenGL"
	configurations {"Debug", "Release"}

	outputdir = "%{cfg.buildcfg}/%{cfg.system}_%{cfg.architecture}/%{prj.name}"

	-- Includes
	IncludeDir = {}
	-- IncludeDir["SpdLog"] = "LearnOpenGL/vendor/spdlog/include"
	-- IncludeDir["imgui"] = "LearnOpenGL/vendor/imgui"
	IncludeDir["glfw"] = "LearnOpenGL/vendor/glfw/include"
	IncludeDir["glad"] = "LearnOpenGL/vendor/glad/include"

	group "Dependancies"

		include "LearnOpenGL/vendor/glfw"
		include "LearnOpenGL/vendor/glad"

	group ""

	project "LearnOpenGL"
		location "LearnOpenGL"
		kind "ConsoleApp"
		language "C++"
		cppdialect "C++17"

		targetdir("%{wks.location}/bin/" .. outputdir)
		objdir("%{wks.location}/bin-int/" .. outputdir)
		debugdir("%{wks.location}/bin/" .. outputdir)

		pchheader "pch.h"
		pchsource "LearnOpenGL/src/pch.cpp"

		files {"%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp" }

		defines {"_CRT_SECURE_NO_WARNINGS"}

		includedirs {
			"%{prj.name}/src",
			"%{IncludeDir.glfw}",
			"%{IncludeDir.glad}"
		-- "%{IncludeDir.DirectX11}",
		-- "%{IncludeDir.imgui}"
		}

		links {
			"glfw",
			"glad",
			--"includes/libs/x64/%{cfg.buildcfg}/*"
		}

--		filter "system:windows"
--		systemversion "latest"

		filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

		filter "configurations:Release"
		runtime "Release"
		optimize "on"

		-- filter { "files:**.hlsl" }
		-- 	shadermodel "5.0"
		-- 	flags("ExcludeFromBuild")
		-- 	shaderobjectfileoutput("%{wks.location}/bin/"..outputdir.."/Shaders/%{file.basename}.cso")

		-- filter { "files:**_p.hlsl" }
		-- 	removeflags "ExcludeFromBuild"
		-- 	shadertype "Pixel"

		-- filter { "files:**_v.hlsl" }
		-- 	removeflags "ExcludeFromBuild"
		-- 	shadertype "Vertex"
