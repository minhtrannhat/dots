return {
  "nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      rust_analyzer = {
        mason = false,
      },
      pyright = {
        mason = false,
        autostart = false,
      },
      clangd = {
        mason = false,
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
}
