local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local plenstatus, Path = pcall(require, "plenary.path")
if not plenstatus then
	return
end

local cmakestatus, cmake = pcall(require, "cmake-tools")
if not cmakestatus then
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

-- this config variable starts off with the defaults from the lualine readme
local config = {
	options = {
		icons_enabled = true,
		theme = lualine_nightfly,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
}

-- some functions to make sticking new sections in easier
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- add the cmake build target
ins_left({
	function()
		local b_target = cmake.get_build_target()
		return "[" .. (b_target and b_target or "X") .. "]"
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectBuildTarget")
			end
		end
	end,
})

-- add the cmake launch target
ins_left({
	function()
		local l_target = cmake.get_launch_target()
		return "[" .. (l_target and l_target or "X") .. "]"
	end,
	cond = cmake.is_cmake_project,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectLaunchTarget")
			end
		end
	end,
})

-- add the cmake build type
ins_left({
	function()
		local type = cmake.get_build_type()
		return "CMake: [" .. (type and type or "") .. "]"
	end,
	cond = function()
		return cmake.is_cmake_project() and not cmake.has_cmake_preset()
	end,
	on_click = function(n, mouse)
		if n == 1 then
			if mouse == "l" then
				vim.cmd("CMakeSelectBuildType")
			end
		end
	end,
})
-- the git branch
ins_right({
	"branch",
})

-- configure lualine with modified theme
lualine.setup(config)
