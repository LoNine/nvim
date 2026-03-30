return {
  {
    "ggandor/leap.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("leap")
    end,
  },
}

