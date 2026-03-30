local specs = {}
local configs = {}

local files = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)

for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")

  if name ~= "init" then
    local ok, plugin = pcall(require, "plugins." .. name)

    if ok and type(plugin) == "table" then
      
      if plugin.urls then
        for _, u in ipairs(plugin.urls) do
          table.insert(specs, u)
        end
      elseif plugin.url then 
        table.insert(specs, plugin.url)
      end

      if type(plugin.config) == "function" then
        table.insert(configs, plugin.config)
      end

    elseif not ok then
      vim.notify("Ошибка загрузки плагина: " .. name .. "\n" .. tostring(plugin), vim.log.levels.ERROR)
    end
    
  end
end

if #specs > 0 then
  vim.pack.add(specs)
end

for _, config_fn in ipairs(configs) do
  config_fn()
end
