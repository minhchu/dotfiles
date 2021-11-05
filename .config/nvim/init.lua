local opt = vim.opt
local g = vim.g

g.mapleader = ' '
opt.writebackup = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 300
-- Under default settings, making changes and then opening a new file will display E37: No write since last change (add ! to override)
-- :set hidden will change this behaviour
-- With :set hidden, opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
opt.hidden = true
-- use same clipboard register for vim and OS
opt.clipboard = 'unnamedplus'

local Plug = vim.fn['plug#']

-- local pluginHome = '~/.vim/plugged';
local pluginHome = '~/.config/nvim/plugged';

vim.call('plug#begin', pluginHome)

  Plug 'nvim-lua/plenary.nvim'
  Plug 'glepnir/dashboard-nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug('neoclide/coc.nvim', {branch = 'release'})
  Plug 'akinsho/toggleterm.nvim'

  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'
  Plug 'bagrat/vim-buffet'
  Plug 'junegunn/vim-easy-align'
  Plug '907th/vim-auto-save'
  Plug 'sheerun/vim-polyglot'
  Plug 'honza/vim-snippets'
  Plug 'itchyny/lightline.vim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'dominikduda/vim_current_word'
  Plug 'unblevable/quick-scope'

vim.call('plug#end')
g.yoinkIncludeDeleteOperations=1
g.yoinkAutoFormatPaste=1

local vim_map = vim.api.nvim_set_keymap;
local map = function (mode, key, map, options)
  if not options then
    options = {noremap = true}
  end

  vim_map(mode, key, map, options)
end

map('n', 'H', '0')
map('n', 'L', '$')
-- redo
map('n', 'U', '<C-r>')
-- map('n', 'U', '<cmd>redo<cr>')
map('n', '<CR>', ':')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>fs', ':w<CR>')
map('i', 'jj', '<Esc>')
map('n', '<leader>fd', ':NvimTreeFindFile<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fw', ':Telescope live_grep<CR>')
map('n', '<C-p>', ':Telescope find_files<CR>')
map('', '<F4>', ':NvimTreeToggle<CR>')
map('n', '<leader>gs', ':Git<CR>')
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gd', ':Git diff<CR>')
map('n', '<leader>gp', ':Git -c push.default=current push<CR>')
map('n', '<Esc>', ':noh <CR>')

-- Don't copy the replaced text after pasting in visual mode
map('v', 'p', '"_dP')
-- don't yank text on cut ( x )
-- map('n', 'x', '"_x')
-- map('v', 'x', '"_x')
-- don't yank text on delete ( dd )
map('n', 'd', '"_d')
map('v', 'd', '"_d')
map('n', 'c', '"_c')
map('v', 'c', '"_c')

local M = {}
M.mappings = {
  insert_nav = {
    backward = "<C-h>",
    end_of_line = "<C-e>",
    forward = "<C-l>",
    next_line = "<C-k>",
    prev_line = "<C-j>",
    top_of_line = "<C-a>",
  },
}
local inav = M.mappings.insert_nav
map("i", inav.backward, "<Left>")
map("i", inav.end_of_line, "<End>")
map("i", inav.forward, "<Right>")
map("i", inav.next_line, "<Up>")
map("i", inav.prev_line, "<Down>")
map("i", inav.top_of_line, "<ESC>^i")

g.lightline = { colorscheme = 'palenight', enable = { tabline = false } }
g.auto_save = true
g.dashboard_default_executive = 'telescope'
g.nvim_tree_ignore = { '.git', 'node_modules' }
g.nvim_tree_window_picker_exclude = {
  filetype = {
    'notify',
    'packer',
    'fugitive',
    'fugitiveblame',
    'vim-plug',
    'git',
    '' -- no filetype, ex: __coc_search__0 buffer has no ft
  },
  buftype = { 'terminal' }
}
g.dashboard_custom_header = {
      '     ⠀⠀⠀⠀⠀⠀⠀⡴⠞⠉⢉⣭⣿⣿⠿⣳⣤⠴⠖⠛⣛⣿⣿⡷⠖⣶⣤⡀⠀⠀⠀  ',
      '   ⠀⠀⠀⠀⠀⠀⠀⣼⠁⢀⣶⢻⡟⠿⠋⣴⠿⢻⣧⡴⠟⠋⠿⠛⠠⠾⢛⣵⣿⠀⠀⠀⠀  ',
      '   ⣼⣿⡿⢶⣄⠀⢀⡇⢀⡿⠁⠈⠀⠀⣀⣉⣀⠘⣿⠀⠀⣀⣀⠀⠀⠀⠛⡹⠋⠀⠀⠀⠀  ',
      '   ⣭⣤⡈⢑⣼⣻⣿⣧⡌⠁⠀⢀⣴⠟⠋⠉⠉⠛⣿⣴⠟⠋⠙⠻⣦⡰⣞⠁⢀⣤⣦⣤⠀  ',
      '   ⠀⠀⣰⢫⣾⠋⣽⠟⠑⠛⢠⡟⠁⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠘⣷⡈⠻⣍⠤⢤⣌⣀  ',
      '   ⢀⡞⣡⡌⠁⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠸⣇⠀⢾⣷⢤⣬⣉  ',
      '   ⡞⣼⣿⣤⣄⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠸⣿⣇⠈⠻  ',
      '   ⢰⣿⡿⢹⠃⠀⣠⠤⠶⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⣿⠛⡄⠀  ',
      '   ⠈⠉⠁⠀⠀⠀⡟⡀⠀⠈⡗⠲⠶⠦⢤⣤⣤⣄⣀⣀⣸⣧⣤⣤⠤⠤⣿⣀⡀⠉⣼⡇⠀  ',
      '   ⣿⣴⣴⡆⠀⠀⠻⣄⠀⠀⠡⠀⠀⠀⠈⠛⠋⠀⠀⠀⡈⠀⠻⠟⠀⢀⠋⠉⠙⢷⡿⡇⠀  ',
      '   ⣻⡿⠏⠁⠀⠀⢠⡟⠀⠀⠀⠣⡀⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⢀⠈⠀⢀⣀⡾⣴⠃⠀  ',
      '   ⢿⠛⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠈⠢⠄⣀⠠⠼⣁⠀⡱⠤⠤⠐⠁⠀⠀⣸⠋⢻⡟⠀⠀  ',
      '   ⠈⢧⣀⣤⣶⡄⠘⣆⠀⠀⠀⠀⠀⠀⠀⢀⣤⠖⠛⠻⣄⠀⠀⠀⢀⣠⡾⠋⢀⡞⠀⠀⠀  ',
      '   ⠀⠀⠻⣿⣿⡇⠀⠈⠓⢦⣤⣤⣤⡤⠞⠉⠀⠀⠀⠀⠈⠛⠒⠚⢩⡅⣠⡴⠋⠀⠀⠀⠀  ',
      '   ⠀⠀⠀⠈⠻⢧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣻⠿⠋⠀⠀⠀⠀⠀⠀  ',
      '   ⠀⠀⠀⠀⠀⠀⠉⠓⠶⣤⣄⣀⡀⠀⠀⠀⠀⠀⢀⣀⣠⡴⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀  '
}

g.dashboard_custom_section = {
   a = { description = { "  Recents                   SPC f o" }, command = "Telescope oldfiles" },
   b = { description = { "  Find File                 SPC f f" }, command = "Telescope find_files" },
   c = { description = { "  Find Word                 SPC f w" }, command = "Telescope live_grep" },
   d = { description = { "洛 New File                  SPC f n" }, command = "DashboardNewFile" },
   e = { description = { "  Bookmarks                 SPC b m" }, command = "Telescope marks" },
   f = { description = { "  Load Last Session         SPC l  " }, command = "SessionLoad" },
}

--[[
NvimTree
--]]
require'nvim-tree'.setup{
  auto_close = true,
}

--[[
Telescope
--]]
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  }
}

--[[
ToggleTerm
--]]
require('toggleterm').setup{
  -- size can be a number or function which is passed the current terminal
  size = 10,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}
map('n', '<leader>t', '<cmd>ToggleTerm<CR>')
map('t', '<C-\\>', '<cmd>ToggleTerm<CR>')

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', 'jj', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
local htop = Terminal:new({ cmd = "htop", hidden = true, direction =  'float' })

function _G.htopToggle()
  htop:toggle()
end

map("n", "<leader>ht", "<cmd>lua htopToggle()<CR>", {noremap = true, silent = true})

vim.cmd('colorscheme palenight')
vim.cmd 'source ~/.config/nvim/config.vim'


