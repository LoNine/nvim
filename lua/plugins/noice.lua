return {
  urls = {
    'https://github.com/folke/noice.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/rcarriga/nvim-notify',
  },

  config = function()
    require('noice').setup({})
    
    require('notify').setup({
      background_colour = "#000000",
    })
  end
}
