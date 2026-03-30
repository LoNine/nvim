return {
  url = "https://github.com/catppuccin/nvim",
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
    })

    vim.cmd.colorscheme("catppuccin-frappe")
  end
}
