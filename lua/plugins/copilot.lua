return {
  urls = {
    'https://github.com/zbirenbaum/copilot.lua',
    'https://github.com/copilotlsp-nvim/copilot-lsp',
  },

  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-e>",
        },
      },
    })
  end,
}
