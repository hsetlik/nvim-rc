local tasks_status, neovimtasks = pcall(require, "tasks")
if not tasks_status then
	return
end

neovimtasks.setup({
	default_params = { -- Default module parameters with which `.tasks.json` will be created.
		cmake_kits = {
			cmd = "cmake", -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
			build_type = "Release", -- default build type, can be changed using `:Task set_module_param cmake build_type`.
			build_kit = "default", -- default build kit, can be changed using `:Task set_module_param cmake build_kit`.
			dap_name = "codelldb", -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
			build_dir = "{home}/builds/{project_name}/{build_kit}/{build_type}", -- placeholders will be automatically replaced: {home} with path to home directory, {project_name} with name of the current working directory, {build_kit} with currently active build kit and {build_type} with currently active build type
			cmake_kits_file = vim.api.nvim_get_runtime_file("cmake_kits.json", false)[1], -- set path to JSON file containing cmake kits
			cmake_build_types_file = vim.api.nvim_get_runtime_file("cmake_build_types.json", false)[1], -- set path to JSON file containing cmake kits
			clangd_cmdline = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--offset-encoding=utf-8",
				"--pch-storage=memory",
				"--cross-file-rename",
				"-j=4",
			}, -- command line for invoking clangd - this array will be extended with
			--compile-commands-dir and --query-driver after each cmake configure with
			--parameters inferred from build_kit, build_type and build_dir
		},
	},
})
