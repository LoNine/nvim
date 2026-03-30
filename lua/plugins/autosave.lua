return {
  url = 'https://github.com/0x00-ketsu/autosave.nvim',
  config = function()
    require('autosave').setup {
      prompt = {
        enable = false,
        style = 'stdout',
      },
      write_all_buffers = true,
    }
  end
}
