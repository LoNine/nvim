return {
  urls = {
    'https://github.com/youyoumu/pretty-ts-errors.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  },
  
  config = function()
    require('render-markdown').setup({})
    
    require('pretty-ts-errors').setup({
      float_opts = {
        border = "rounded",
        max_width = 80,
        max_height = 20,
        wrap = false,
      },
      auto_open = false,
      lazy_window = false,
    })

    vim.keymap.set('n', '<leader>d', function()
      local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
      
      if #line_diagnostics == 0 then
        print("No diagnostics on this line")
        return
      end
      
      local has_ts_error = false
      for _, diag in ipairs(line_diagnostics) do
        if diag.source == "ts" or diag.source == "eslint" then
          has_ts_error = true
          break
        end
      end
      
      if has_ts_error then
        require('pretty-ts-errors').show_formatted_error()
      else
        vim.diagnostic.open_float()
      end
    end, { desc = "Show diagnostic" })
    
    vim.keymap.set('n', '<leader>q', function()
      local bufnr = vim.api.nvim_get_current_buf()
      local diagnostics = vim.diagnostic.get(bufnr)
      
      if #diagnostics == 0 then
        print("No diagnostics in buffer")
        return
      end
      
      -- Создаем вертикальный split окно
      vim.cmd('botright vsplit')
      local win = vim.api.nvim_get_current_win()
      local new_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_win_set_buf(win, new_buf)
      
      -- Настройки буфера
      vim.api.nvim_buf_set_option(new_buf, 'buftype', 'nofile')
      vim.api.nvim_buf_set_option(new_buf, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_option(new_buf, 'modifiable', false)
      vim.api.nvim_buf_set_name(new_buf, 'Diagnostics')
      
      -- Форматируем диагностики в markdown
      local lines = { '# Diagnostics', '' }
      local severity_icons = { '✖', '⚠', 'ℹ', '💡' }
      local severity_colors = { '**ERROR**', '**WARN**', 'INFO', 'HINT' }
      
      -- Группируем по severity
      local groups = { {}, {}, {}, {} }
      for _, diag in ipairs(diagnostics) do
        table.insert(groups[diag.severity], diag)
      end
      
      -- Выводим по группам
      for severity = 1, 4 do
        if #groups[severity] > 0 then
          table.insert(lines, string.format('%s %s (%d)', severity_icons[severity], severity_colors[severity], #groups[severity]))
          table.insert(lines, '')
          
          for _, diag in ipairs(groups[severity]) do
            local source = diag.source or 'unknown'
            local line_num = diag.lnum + 1
            local message = diag.message:gsub('\n', ' ')
            
            table.insert(lines, string.format('**Line %d** · `%s` · %s', line_num, source, message))
            table.insert(lines, '')
          end
        end
      end
      
      -- Записываем в буфер
      vim.api.nvim_buf_set_option(new_buf, 'modifiable', true)
      vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)
      vim.api.nvim_buf_set_option(new_buf, 'modifiable', false)
      vim.api.nvim_buf_set_option(new_buf, 'filetype', 'markdown')
      
      -- Добавляем цветовую подсветку для ERROR и WARN
      local ns_id = vim.api.nvim_create_namespace('diagnostics_colors')
      for i, line in ipairs(lines) do
        if line:match('%*%*ERROR%*%*') then
          vim.api.nvim_buf_add_highlight(new_buf, ns_id, 'DiagnosticError', i - 1, 0, -1)
        elseif line:match('%*%*WARN%*%*') then
          vim.api.nvim_buf_add_highlight(new_buf, ns_id, 'DiagnosticWarn', i - 1, 0, -1)
        end
      end
      
      -- Настройка окна
      vim.api.nvim_win_set_width(win, 60)
      
      -- Keymap для закрытия
      vim.api.nvim_buf_set_keymap(new_buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(new_buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
    end, { desc = "Show all diagnostics" })
    
    vim.keymap.set('n', '<leader>tt', function() require('pretty-ts-errors').toggle_auto_open() end, { desc = "Toggle TS error auto-display" })
  end,
}
