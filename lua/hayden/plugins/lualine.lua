local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local plenstatus, Path = pcall(require, "plenary.path")
if not plenstatus then
	return
end

local configstatus, ProjectConfig = pcall(require, "tasks.project_config")
if not configstatus then
	return
end

local cmakestatus, cmake = pcall(require, "cmake-tools")
if not configstatus then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")
local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}

local function cmakeStatus()
	local cmake_config = ProjectConfig:new()["cmake_kits"]
	local cmakelists_dir = cmake_config.source_dir and cmake_config.source_dir or vim.loop.cwd()
	if (Path:new(cmakelists_dir) / "CMakeLists.txt"):exists() then
		local cmakeBuildType = cmake.get_build_type()
		local cmakeKit = cmake.get_kit()
		local buildTarget = cmake.get_build_target()
		local launchTarget = cmake.get_launch_target()

		if cmakeBuildType and cmakeKit and buildTarget then
			return "CMake variant: "
				.. cmakeBuildType
				.. " Kit: "
				.. cmakeKit
				.. " Build target: "
				.. buildTarget
				.. " Launch target:"
				.. launchTarget
		else
			return ""
		end
	else
		return ""
	end
end

-- change nightlfy theme colors
lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, -- black
	},
}

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = lualine_nightfly,
	},
	sections = {
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype", cmakeStatus },
	},
})

lualine.setup()
