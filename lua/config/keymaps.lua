-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- For conciseness
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<leader>wh", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>wl", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>wj", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<leader>wk", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- windows
vim.keymap.set("n", "<leader>wq", "<C-W>q", opts)
vim.keymap.set("n", "<leader>wv", "<C-W>v", opts)
vim.keymap.set("n", "<leader>wv", "<C-W>v", opts)

-- Функция для удобства настройки клавиш
local keymap = vim.api.nvim_set_keymap

-- Переключение между буферами
keymap("n", "<leader>bn", ":bnext<CR>", opts)     -- Следующий буфер
keymap("n", "<leader>bp", ":bprevious<CR>", opts) -- Предыдущий буфер
keymap("n", "<leader>bd", ":bdelete<CR>", opts)   -- Закрыть буфер

-- Показ всех буферов
keymap("n", "<leader>bl", ":ls<CR>:buffer<Space>", opts)

-- Переключение на последний буфер
keymap("n", "<leader>bb", ":b#<CR>", opts)

-- Закрыть все буферы, кроме текущего
keymap("n", "<leader>bo", ":%bd|e#|bd#<CR>", opts)

-- Git Conflicts!
vim.keymap.set('n', '<leader>Cn', '<cmd>GitConflictChooseNone<cr>', { desc = 'Choose None' });
vim.keymap.set('n', '<leader>Cb', '<cmd>GitConflictChooseBoth<cr>', { desc = 'Choose Both' });
vim.keymap.set('n', '<leader>Co', '<cmd>GitConflictChooseOurs<cr>', { desc = 'Choose Ours' });
vim.keymap.set('n', '<leader>Ct', '<cmd>GitConflictChooseTheirs<cr>', { desc = 'Choose Theirs' });
vim.keymap.set('n', '[c', '<cmd>GitConflictPrevConflict<cr>', { desc = 'Previous Conflict' });
vim.keymap.set('n', ']c', '<cmd>GitConflictNextConflict<cr>', { desc = 'Next Conflict' });

-- Copilot
vim.keymap.set('n', '<leader>ae', '<cmd>Copilot enable<CR>', { desc = 'Copilot Enable', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ad', '<cmd>Copilot disable<CR>', { desc = 'Copilot Disable', noremap = true, silent = true })
vim.keymap.set('n', '<leader>as', '<cmd>Copilot status<CR>', { desc = 'Copilot Status', noremap = true, silent = true })

local function get_opts(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame<cr>', get_opts('Git Blame'))
vim.keymap.set('n', '<leader>gl', '<cmd>Gitsigns blame_line_toggle<cr>', get_opts('Git Blame line'))

vim.keymap.set('n', '<leader>Tc', require('config.utils.create_react_component_structure'),
  get_opts('Create React Component Structure (oli.nvim)'));
vim.keymap.set('n', '<leader>Tr', require('config.utils.create_react_component_template'),
  get_opts('Create React Component Template'));
vim.keymap.set('n', '<leader>Ti', require('config.utils.create_react_index_template'),
  get_opts('Create React Index Template'));

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", {})       -- move line up(n)
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", {})       -- move line down(n)
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", {})   -- move line up(v)
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", {})   -- move line down(v)

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>ki", function()
  require("config.utils.kebab_import").kebabcase_import_under_cursor()
end, { desc = "Kebab-case import path (line)" })

vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
