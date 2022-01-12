-- general
lvim.format_on_save = true
lvim.lint_on_save = true

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.termguicolors = true

lvim.colorscheme = "nord"
lvim.shell = "/bin/fish"

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
	},
	{ exe = "prettier" },
	{ exe = "gofmt" },
	{ exe = "eslint_d" },
	{ exe = "stylua" },
	{ exe = "brittany" },
})

linters.setup({
	{ exe = "flake8" },
})

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
	{ "tpope/vim-fugitive" },
	{ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" },
}

-- Neogit - A emacs magit clone
local neogit = require("neogit")

neogit.setup({})

lvim.builtin.which_key.mappings["gg"] = {
	"<cmd>Neogit kind=split<CR>",
	"Neogit",
}
