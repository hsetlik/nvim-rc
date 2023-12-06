return {
	"Civitasv/cmake-tools.nvim",
	config = function()
		local cmaketools = require("cmake-tools")
		cmaketools.setup({
			cmake_command = "cmake", -- this is used to specify cmake command path
			cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-G Ninja" }, -- this will be passed when invoke `CMakeGenerate`
			cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
			cmake_build_directory = "build", -- this is used to specify generate directory for cmake
			cmake_build_directory_prefix = "", -- when cmake_build_directory is set to "", this option will be activated
			cmake_soft_link_compile_commands = false, -- this will automatically make a soft link from compile commands file to project root dir
			cmake_compile_commands_from_lsp = true, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
			cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
			cmake_variants_message = {
				short = { show = true }, -- whether to show short message
				long = { show = true, max_length = 40 }, -- whether to show long message
			},
			cmake_always_use_terminal = false, -- if true, use terminal for generate, build, clean, install, run, etc, except for debug, else only use terminal for run, use quickfix for others
			cmake_quickfix_opts = { -- quickfix settings for cmake, quickfix will be used when `cmake_always_use_terminal` is false
				show = "always", -- "always", "only_on_error"
				position = "belowright", -- "bottom", "top"
				size = 10,
			},
			cmake_terminal_opts = { -- terminal settings for cmake, terminal will be used for run when `cmake_always_use_terminal` is false or true, will be used for all tasks except for debug when `cmake_always_use_terminal` is true
				name = "Main Terminal",
				prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
				split_direction = "horizontal", -- "horizontal", "vertical"
				split_size = 11,

				-- Window handling
				single_terminal_per_instance = true, -- Single viewport, multiple windows
				single_terminal_per_tab = true, -- Single viewport per tab
				keep_terminal_static_location = true, -- Static location of the viewport if avialable

				-- Running Tasks
				start_insert_in_launch_task = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
				start_insert_in_other_tasks = false, -- If you want to enter terminal with :startinsert upon launching all other cmake tasks in the terminal. Generally set as false
				focus_on_main_terminal = false, -- Focus on cmake terminal when cmake task is launched. Only used if cmake_always_use_terminal is true.
				focus_on_launch_terminal = false, -- Focus on cmake launch terminal when executable target in launched.
			},
		})
		-- now set up lualine with cmake stuff
		local lualine = require("lualine")

		-- you can find the icons from https://github.com/Civitasv/runvim/blob/master/lua/config/icons.lua
		local icons = require("hayden.core.icons")

		-- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local colors = {
			normal = {
				bg = "#202329",
				fg = "#bbc2cf",
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#a9a1e1",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
			},
			nightfly = {
				bg = "#011627",
				fg = "#acb4c2",
				yellow = "#ecc48d",
				cyan = "#7fdbca",
				darkblue = "#82aaff",
				green = "#21c7a8",
				orange = "#e3d18a",
				violet = "#a9a1e1",
				magenta = "#ae81ff",
				blue = "#82aaff ",
				red = "#ff5874",
			},
			light = {
				bg = "#f6f2ee",
				fg = "#3d2b5a",
				yellow = "#ac5402",
				cyan = "#287980",
				darkblue = "#2848a9",
				green = "#396847",
				orange = "#a5222f",
				violet = "#8452d5",
				magenta = "#6e33ce",
				blue = "#2848a9",
				red = "#b3434e",
			},
			catppuccin_mocha = {
				bg = "#1E1E2E",
				fg = "#CDD6F4",
				yellow = "#F9E2AF",
				cyan = "#7fdbca",
				darkblue = "#89B4FA",
				green = "#A6E3A1",
				orange = "#e3d18a",
				violet = "#a9a1e1",
				magenta = "#ae81ff",
				blue = "#89B4FA",
				red = "#F38BA8",
			},
		}

		colors = colors.light

		local config = {
			options = {
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { "alpha", "dashboard", "Outline" },
				always_divide_middle = true,
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- c for left
				lualine_c = {},
				-- x for right
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
			tabline = {},
			extensions = {},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x ot right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return icons.ui.Line
			end,
			color = { fg = colors.blue }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})

		ins_left({
			-- mode component
			function()
				return icons.ui.Evil
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					["�"] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					["�"] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({
			-- filesize component
			"filesize",
			cond = conditions.buffer_not_empty,
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({ "location" })

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = icons.diagnostics.Error,
				warn = icons.diagnostics.Warning,
				info = icons.diagnostics.Information,
			},
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		ins_left({
			function()
				local c_preset = cmaketools.get_configure_preset()
				return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
			end,
			icon = icons.ui.Search,
			cond = function()
				return cmaketools.is_cmake_project() and cmaketools.has_cmake_preset()
			end,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectConfigurePreset")
					end
				end
			end,
		})

		ins_left({
			function()
				local type = cmaketools.get_build_type()
				return "CMake: [" .. (type and type or "") .. "]"
			end,
			icon = icons.ui.Search,
			cond = function()
				return cmaketools.is_cmake_project() and not cmaketools.has_cmake_preset()
			end,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectBuildType")
					end
				end
			end,
		})

		ins_left({
			function()
				local kit = cmaketools.get_kit()
				return "[" .. (kit and kit or "X") .. "]"
			end,
			icon = icons.ui.Pencil,
			cond = function()
				return cmaketools.is_cmake_project() and not cmaketools.has_cmake_preset()
			end,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectKit")
					end
				end
			end,
		})

		ins_left({
			function()
				return "Build"
			end,
			icon = icons.ui.Gear,
			cond = cmaketools.is_cmake_project,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeBuild")
					end
				end
			end,
		})

		ins_left({
			function()
				local b_preset = cmaketools.get_build_preset()
				return "[" .. (b_preset and b_preset or "X") .. "]"
			end,
			icon = icons.ui.Search,
			cond = function()
				return cmaketools.is_cmake_project() and cmaketools.has_cmake_preset()
			end,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectBuildPreset")
					end
				end
			end,
		})

		ins_left({
			function()
				local b_target = cmaketools.get_build_target()
				return "[" .. (b_target and b_target or "X") .. "]"
			end,
			cond = cmaketools.is_cmake_project,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectBuildTarget")
					end
				end
			end,
		})

		ins_left({
			function()
				return icons.ui.Debug
			end,
			cond = cmaketools.is_cmake_project,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeDebug")
					end
				end
			end,
		})

		ins_left({
			function()
				return icons.ui.Run
			end,
			cond = cmaketools.is_cmake_project,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeRun")
					end
				end
			end,
		})

		ins_left({
			function()
				local l_target = cmaketools.get_launch_target()
				return "[" .. (l_target and l_target or "X") .. "]"
			end,
			cond = cmaketools.is_cmake_project,
			on_click = function(n, mouse)
				if n == 1 then
					if mouse == "l" then
						vim.cmd("CMakeSelectLaunchTarget")
					end
				end
			end,
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left({
			function()
				return "%="
			end,
		})

		-- Add components to right sections
		ins_right({
			"o:encoding", -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			function()
				return vim.api.nvim_buf_get_option(0, "shiftwidth")
			end,
			icons_enabled = false,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"branch",
			icon = icons.git.Branch,
			color = { fg = colors.violet, gui = "bold" },
		})

		ins_right({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.git.Remove },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_right({
			function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end,
			color = { fg = colors.orange, gui = "bold" },
		})

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)

		local keymap = vim.keymap
		keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "Generate current build system" })
		keymap.set("n", "<leader>cB", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "Select CMake build target" })
		keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "Build current target" })
		keymap.set("n", "<leader>cR", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "Select CMake Launch target" })
		keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "Run current launch target" })
	end,
}
