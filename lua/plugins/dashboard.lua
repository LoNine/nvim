return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      change_to_vcs_root = true,
      config = {
        week_header = {
          enable = true,
        },
        project = {
          enable = false,
        },
        mru = {
          enable = true,
          cwd_only = true,
          limit = 10,
        },
      },
    })
  end,
}
