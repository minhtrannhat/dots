return {
  "IogaMaster/neocord",
  event = "VeryLazy",
  opts = function()
    return {
      require("neocord").setup({}),
    }
  end,
}
