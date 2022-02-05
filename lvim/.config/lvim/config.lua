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
lvim.builtin.dap.active = true
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
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "InsertEnter",
	},
	{ "machakann/vim-sandwich" },
	{ "tpope/vim-fugitive" },
}

-- Changes to clangd
vim.list_extend(lvim.lsp.override, { "clangd" })

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
	-- "--header-insertion=never",
	-- "--query-driver=<list-of-white-listed-complers>"
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
