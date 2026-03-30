return {
  url = { 
    src = 'https://github.com/saghen/blink.cmp', 
    version = 'v1.10.1',
  },

  config = function()
    require('blink.cmp').setup({
      fuzzy = {
        frecency = {
          enabled = true,
        },
        use_proximity = true,
      },
      
      keymap = {
        ["<C-j>"] = { "show", "select_next", "fallback" },
        ["<C-k>"] = { "show", "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-space>"] = { "show", "select_and_accept", "fallback" },
        ["<up>"] = { "select_prev", "fallback" },
        ["<down>"] = { "select_next", "fallback" },
        ["<C-]>"] = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "snippet_forward", "fallback" },
        ["<C-b>"] = { "snippet_backward", "fallback" },
      },
      
      appearance = {
        nerd_font_variant = 'mono'
      },
      
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          dadbod = { module = 'vim_dadbod_completion.blink' },
        },
      },
    })
  end
}
