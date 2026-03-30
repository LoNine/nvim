return {
  {
  "zbirenbaum/copilot.lua",
    dependencies = { "copilotlsp-nvim/copilot-lsp" },
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",           -- Accept на Tab (стандарт для автодополнений)
            accept_word = false,
            accept_line = false,
            next = "<C-n>",             -- Next suggestion (Ctrl+N, как в классических редакторах)
            prev = "<C-p>",             -- Prev suggestion (Ctrl+P, пара с Ctrl+N)
            dismiss = "<C-e>",          -- Dismiss (Ctrl+E, привычно для отмены)
          },
        },
      })
    end,
  },
}

