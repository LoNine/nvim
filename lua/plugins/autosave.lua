return {
  {
    '0x00-ketsu/autosave.nvim',
    event = { "InsertLeave", "TextChanged" },
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
}
