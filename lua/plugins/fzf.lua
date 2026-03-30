return {
  urls = {
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-tree/nvim-web-devicons',
  },

  config = function()
    local fzf = require('fzf-lua')

    fzf.setup()

    vim.keymap.set("n", "<leader>sf", function() fzf.files() end, {})
    vim.keymap.set('n', '<leader>sg', function() fzf.live_grep() end, {})
    vim.keymap.set('n', '<leader>sG', function()
        fzf.live_grep({ resume = true })
    end, { desc = 'Fzf Live Grep Resume' })
    vim.keymap.set('n', '<leader><leader>', function() fzf.buffers() end, {})
    vim.keymap.set('n', '<leader>ss', function() fzf.git_status() end, {})
    vim.keymap.set('n', '<leader>sb', function() fzf.git_blame() end, {})
  end,
}
