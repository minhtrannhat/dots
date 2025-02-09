return {
  "nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
  },
  servers = {
    rust_analyzer = {
      mason = false,
    },
  },
}
