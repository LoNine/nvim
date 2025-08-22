return function ()
  local current_file_path = vim.fn.expand("%:p")

  if current_file_path == "" then
    print("Cannot find file path")
    return
  end

  local folder_name = vim.fn.fnamemodify(current_file_path, ":h:t")

  if folder_name == "" then
    print("Cannot get folder name")
    return
  end
  return folder_name
end
