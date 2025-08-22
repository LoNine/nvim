local get_folder_name = require('config.utils.get_parent_folder_name');

return function()
  local folder_name = get_folder_name();

  local lines = {
    "export { default } from './" .. folder_name .. "';"
  }

  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end
