-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.shell = "/bin/fish"
lvim.leader = "space"
vim.opt.relativenumber = true

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.gitsigns.active = true
lvim.builtin.notify.active = false
lvim.builtin.dap.active = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.builtin.nvimtree.side = "left"
lvim.builtin.terminal.shell = "/bin/fish"

vim.termguicolors = true
vim.background = "dark"
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.termguicolors = true
lvim.colorscheme = "nord"
vim.api.nvim_set_var("Hexokinase_highlighters", { "backgroundfull" })

lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "" }
lvim.builtin.treesitter.highlight.enabled = true

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

formatters.setup({
	{
		exe = "black",
		filetypes = { "python" },
		args = { "--quiet", "--fast", "-" },
	},
	{
		exe = "clang_format",
		filetypes = { "c", "cpp" },
	},
	{
		exe = "rustfmt",
		filetype = { "rust" },
	},
	{ exe = "prettier" },
	{ exe = "gofmt", filetypes = { "go" } },
	{ exe = "eslint_d" },
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "brittany", filetypes = { "haskell" } },
})

linters.setup({
	{ exe = "flake8" },
})

-- Additional Plugins
lvim.plugins = {
	{ "shaunsingh/nord.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{ "machakann/vim-sandwich" },
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	{ "ggandor/lightspeed.nvim", requires = { "tpope/vim-repeat" }, event = "InsertEnter" },
	{ "ellisonleao/glow.nvim" },
	{ "andweeb/presence.nvim" },
	{
		"RRethy/vim-hexokinase",
		run = "cd ~/.local/share/lunarvim/site/pack/packer/start/vim-hexokinase && make hexokinase",
	},
	{
		"m-demare/hlargs.nvim",
		config = function()
			require("hlargs").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
		event = "InsertEnter",
	},
	{
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup({
				copy_sync = {
					enable = false,
				},
				navigation = {
					enable_default_keybindings = true,
				},
				resize = {
					enable_default_keybindings = true,
				},
			})
		end,
	},
}

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
	file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

	-- Rich Presence text options
	editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
	workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
	line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

-- Changes to clangd
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

-- some settings can only passed as commandline flags `clangd --help`
local clangd_flags = {
	"--all-scopes-completion",
	"--suggest-missing-includes",
	"--background-index",
	"--pch-storage=disk",
	"--cross-file-rename",
	"--log=info",
	"--completion-style=detailed",
	"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
	"--clang-tidy",
	"--offset-encoding=utf-16",
	"--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
	"--fallback-style=Google",
}

local clangd_bin = "clangd"

local custom_on_attach = function(client, bufnr)
	require("lvim.lsp").common_on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
	cmd = { clangd_bin, unpack(clangd_flags) },
	on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", opts)

-- vim sandwhich with vim surround keybindings
vim.cmd("runtime macros/sandwich/keymap/surround.vim")
