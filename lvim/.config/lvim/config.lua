-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "nord"
lvim.shell = "/bin/fish"
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h16"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.gitsigns.active = true
lvim.builtin.dap.active = false
vim.opt.relativenumber = true

lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.terminal.shell = "/bin/fish"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.lang.python.formatters = {
	{
		exe = "black",
		args = {},
	},
}

lvim.lang.c.formatters = { { exe = "clang_format" } }
lvim.lang.cpp.formatters = lvim.lang.c.formatters
lvim.lang.javascript.formatters = { { exe = "prettier" } }
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
lvim.lang.rust.formatters = { { exe = "rustfmt" } }
lvim.lang.json.formatters = { { exe = "prettier" } }
lvim.lang.typescript.formatters = { { exe = "prettier" } }
lvim.lang.typescriptreact.formatters = lvim.lang.typescript.formatters
lvim.lang.go.formatters = { { exe = "gofmt" } }

lvim.lang.javascript.linters = { { exe = "eslint_d" } }
lvim.lang.javascriptreact.linters = lvim.lang.javascript.linters
lvim.lang.typescript.linters = { { exe = "eslint_d" } }
lvim.lang.typescriptreact.linters = lvim.lang.typescript.linters
lvim.lang.lua.formatters = { { exe = "stylua" } }

lvim.lang.python.linters = {
	{
		exe = "flake8",
		args = {},
	},
}

-- Additional Plugins
lvim.plugins = {
	{ "shaunsingh/nord.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "InsertEnter",
	},
	{ "andweeb/presence.nvim" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
	-- General options
	auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
	neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
	main_image = "file", -- Main image display (either "neovim" or "file")
	client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
	log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	enable_line_number = false, -- Displays the current line number instead of the current project
	blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

	-- Rich Presence text options
	editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer
	file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
	git_commit_text = "Committing changes", -- Format string rendered when commiting changes in git
	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
	reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
	workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
	line_number_text = "Line %s out of %s", -- Line number format string (for when enable_line_number is set to true)
})
