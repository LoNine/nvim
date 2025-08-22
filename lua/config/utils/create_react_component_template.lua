local get_folder_name = require('config.utils.get_parent_folder_name');

return function()
  local folder_name = get_folder_name()

  local lines = {
    "import styles from './" .. folder_name .. ".module.scss';",
    "",
    "interface I" .. folder_name .. "Props {",
    "",
    "}",
    "",
    "const " .. folder_name .. " = ({",
    "",
    "}: I" .. folder_name .. "Props) => {",
    "  return (",
    "    <div>",
    "    </div>",
    "  );",
    "};",
    "",
    "export default " .. folder_name .. ";"
  }
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end
