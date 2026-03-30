return {
  urls = {
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/stevearc/oil.nvim",
  },

  config = function()
    CustomOilBar = function()
      local path = vim.fn.expand "%"
      path = path:gsub("oil://", "")
      return "  " .. vim.fn.fnamemodify(path, ":.")
    end

    require("oil").setup {
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        ["<C-s>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      win_options = {
        winbar = "%{v:lua.CustomOilBar()}",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
          return vim.tbl_contains(folder_skip, name)
        end,
      },
    }

    require('mini.icons').setup({
      file = {
        ['%.controller%.ts$'] = { glyph = '󰞷', hl = 'MiniIconsAzure' },
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  end,
}
