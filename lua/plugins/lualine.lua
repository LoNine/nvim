return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local noice = require("noice");

      require('lualine').setup({
        options = {
          theme = 'auto',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = {
            {
              noice.api.status.message.get_hl,
              cond = noice.api.status.message.has,
            },
            {
              noice.api.status.command.get,
              cond = noice.api.status.command.has,
              color = { fg = "#ff9e64" },
            },
            {
              noice.api.status.mode.get,
              cond = noice.api.status.mode.has,
              color = { fg = "#ff9e64" },
            },
            {
              noice.api.status.search.get,
              cond = noice.api.status.search.has,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      })
    end
  }
}
