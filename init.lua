require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocomands")
require('mini.icons').setup({
  file = {
    ['%.controller%.ts$'] = { glyph = '󰞷', hl = 'MiniIconsAzure' },
  },
})

