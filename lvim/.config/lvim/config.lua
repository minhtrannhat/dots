-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.shell = "/bin/zsh"
lvim.leader = "space"
vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.gitsigns.active = true
lvim.builtin.dap.active = true
lvim.reload_config_on_save = true
lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.breadcrumbs = { active = false }
lvim.builtin.nvimtree.side = "left"
lvim.builtin.terminal.shell = "/bin/zsh"
lvim.lsp.installer.setup.automatic_installation = false
vim.diagnostic.config({ virtual_text = false })

vim.termguicolors = true
vim.background = "dark"

lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "" }
lvim.builtin.treesitter.highlight.enabled = true

require("mason-lspconfig").setup_handlers({
	["rust_analyzer"] = function() end,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.diagnostics.ruff,
	},
})

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
	{ exe = "prettier" },
	{ exe = "gofmt", filetypes = { "go" } },
	{ exe = "eslint_d" },
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "brittany", filetypes = { "haskell" } },
})

linters.setup({
	{ exe = "ruff", filetype = { "python" } },
})

-- Additional Plugins
lvim.plugins = {
	-- { "shaunsingh/nord.nvim" },
	{
		"gbprod/nord.nvim",
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = require("lvim.lsp").common_on_attach,
				},
			}
		end,
	},
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
	{ "ellisonleao/glow.nvim" },
	{ "IogaMaster/neocord" },
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
		"HiPhish/rainbow-delimiters.nvim",
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
	"haya14busa/is.vim",
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup(
				{ keys = "etovxqpdygfblzhckisuran" },
				vim.api.nvim_set_keymap("n", "t", ":HopChar2<cr>", { silent = true }),
				vim.api.nvim_set_keymap("n", "T", ":HopPattern<cr>", { silent = true })
			)
		end,
	},
	"norcalli/nvim-colorizer.lua",
}

require("colorizer").setup()

require("better_escape").setup({
	mapping = { "jk", "kj" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

require("nord").setup({
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
	borders = true, -- Enable the border between verticaly split windows visible
	errors = { mode = "bg" }, -- Display mode for errors and diagnostics
	-- values : [bg|fg|none]
	search = { theme = "vscode" }, -- theme for highlighting search results
	-- values : [vim|vscode]
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { bold = true },
		functions = { bold = true },
		variables = { bold = true },

		-- To customize lualine/bufferline
		bufferline = {
			current = {},
			modified = { italic = true },
		},
	},

	on_highlights = function(highlights, colors)
		highlights["@lsp.type.parameter"] = { fg = require("nord.utils").darken(colors.aurora.yellow, 0.90) }
	end,
})

lvim.colorscheme = "nord"
lvim.builtin.lualine.options = { theme = "nord" }
lvim.builtin.bufferline.options = { separator_style = "thin" }
lvim.builtin.bufferline.highlights = require("nord.plugins.bufferline").akinsho()

-- The setup config table shows all available config options with their default values:
require("neocord").setup({
	-- General options
	logo = "auto", -- "auto" or url
	logo_tooltip = nil, -- nil or string
	main_image = "language", -- "language" or "logo"
	client_id = "1157438221865717891", -- Use your own Discord application client id (not recommended)
	log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
	show_time = true, -- Show the timer
	global_timer = false, -- if set true, timer won't update when any event are triggered

	-- Rich Presence text options
	editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
	workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
	line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
	terminal_text = "Using Terminal", -- Format string rendered when in terminal mode.
})

lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
