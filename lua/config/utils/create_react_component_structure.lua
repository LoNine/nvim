return function()
  local input_dir = vim.fn.input("Component Name: ")

  if input_dir == "" then
    print("Component name cannot be empty")
    return
  end

  local lines = {
    input_dir .. "/index.ts",
    input_dir .. "/" .. input_dir .. ".tsx",
    input_dir .. "/" .. input_dir .. ".module.scss",
  }

  local current_line = vim.fn.line(".") -- Текущая строка курсора
  vim.api.nvim_buf_set_lines(0, current_line, current_line, false, lines)
end
