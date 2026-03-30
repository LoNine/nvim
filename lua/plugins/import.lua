return {
  'piersolenski/import.nvim',
  dependencies = {
   'ibhagwan/fzf-lua',
  },
  opts = {
   picker = "fzf-lua",
   insert_at_top = false,
  },
  keys = {
    {
      "<leader>i",
      function()
        require("import").pick()
      end,
      desc = "Import",
    },
  },
}
