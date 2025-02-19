return {
  "hrsh7th/nvim-cmp",
  init = function()
    vim.g.cmp_disabled = false -- Set the default state to enabled
  end,
  keys = {
    {
      "<leader>uA", -- Keybinding to toggle nvim-cmp
      function()
        vim.g.cmp_disabled = not vim.g.cmp_disabled -- Toggle the state

        -- Update the nvim-cmp configuration dynamically
        require("cmp").setup({
          enabled = function()
            return not vim.g.cmp_disabled
          end,
        })

        -- Notify the user of the current state
        local msg = vim.g.cmp_disabled and "Autocompletion (cmp) disabled" or "Autocompletion (cmp) enabled"
        vim.notify(msg, vim.log.levels.INFO)
      end,
      noremap = true,
      silent = true,
      desc = "Toggle autocompletion",
    },
  },
}
