-- ~/.config/nvim/lua/kebab_import.lua
local M = {}

local SUFFIXES = {
  "service", "util", "controller", "client", "router", "error", "config", "middleware", "factory", "schema", "repository", "builder"
}

local function ends_with_any(name, suffixes)
  for _, s in ipairs(suffixes) do
    if name:sub(-#s) == s then
      return true
    end
  end
  return false
end

local function replace_last_hyphen_with_dot_before_suffix(name)
  -- Ищем последнее '-' перед целевым суффиксом и заменяем на '.'
  for _, s in ipairs(SUFFIXES) do
    if #name > #s and name:sub(-#s) == s then
      local prefix = name:sub(1, #name - #s)        -- всё до суффикса
      -- найти последнее '-' в prefix
      local last_dash = prefix:match(".*()%-")      -- позиция последнего '-'
      if last_dash then
        return prefix:sub(1, last_dash - 1) .. "." .. prefix:sub(last_dash + 1) .. s
      end
      -- если '-' нет, вернуть как есть
      return name
    end
  end
  return name
end

local function to_kebab(s)
  s = s:gsub("([a-z0-9])([A-Z])", "%1-%2")
  s = s:gsub("([A-Z])([A-Z][a-z])", "%1-%2")
  return s:lower()
end

function M.kebabcase_import_under_cursor()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""

  local before, quote, path, after = line:match("^(.-)from%s+([\"'])(.-)%2(.*)$")
  if not path then
    before, quote, path, after = line:match("^(.-)import%s+([\"'])(.-)%2(.*)$")
  end
  if not path then return end

  local parts = {}
  for seg in path:gmatch("[^/]+") do table.insert(parts, seg) end
  if #parts == 0 then return end

  local name, ext = parts[#parts]:match("^(.*)(%.[%w%d]+)$")
  if not name then name = parts[#parts]; ext = "" end

  local kebab = to_kebab(name)
  if ends_with_any(kebab, SUFFIXES) then
    kebab = replace_last_hyphen_with_dot_before_suffix(kebab)
  end

  parts[#parts] = kebab .. ext
  local new_path = table.concat(parts, "/")

  local new_line
  if line:match("from%s+[\"']") then
    new_line = string.format("%sfrom %s%s%s%s", before, quote, new_path, quote, after)
  else
    new_line = string.format("%simport %s%s%s%s", before, quote, new_path, quote, after)
  end

  vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })
end

return M
