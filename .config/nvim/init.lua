vim.cmd[[
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]]

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
g.nowrap = true
-- Under default settings, making changes and then opening a new file will display E37: No write since last change (add ! to override)
-- :set hidden will change this behaviour
-- With :set hidden, opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed
opt.hidden = true
-- use same clipboard register for vim and OS
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.smartcase = true

local Plug = vim.fn['plug#']

-- local pluginHome = '~/.vim/plugged';
local pluginHome = '~/.config/nvim/plugged';

vim.call('plug#begin', pluginHome)

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvimdev/dashboard-nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug('neoclide/coc.nvim', {branch = 'release'})
  Plug('mg979/vim-visual-multi', {branch = 'master'})
  Plug 'akinsho/toggleterm.nvim'
  Plug 'sindrets/diffview.nvim'

-- Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
--  Plug 'mhinz/vim-signify'
  Plug 'airblade/vim-gitgutter'
  Plug 'bagrat/vim-buffet'
  Plug 'junegunn/vim-easy-align'
  Plug '907th/vim-auto-save'
  Plug 'sheerun/vim-polyglot'
--  Plug 'honza/vim-snippets'
  Plug 'itchyny/lightline.vim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'unblevable/quick-scope'

-- Fold column
  Plug 'kevinhwang91/promise-async'
  Plug 'kevinhwang91/nvim-ufo'
  Plug 'luukvbaal/statuscol.nvim'

-- UI things:
--  Plug 'MunifTanjim/nui.nvim'
--  Plug 'rcarriga/nvim-notify'
--  Plug 'folke/noice.nvim'

  Plug 'folke/zen-mode.nvim'
  Plug('folke/tokyonight.nvim', {branch = 'main' })

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

map('n', 'H', '^')
map('n', 'L', '$')
map('v', 'H', '^')
map('v', 'L', '$')
-- redo
map('n', 'U', '<C-r>')
-- map('n', 'U', '<cmd>redo<cr>')
map('n', '<CR>', ':')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>fs', ':w<CR>')
map('i', 'jj', '<Esc>')
map('n', '<leader>fd', ':NvimTreeFindFile<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fw', ':lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>')
map('n', '<leader>pw', ':lua require(\'telescope.builtin\').grep_string { search = vim.fn.expand("<cword>") }<CR>')
map('n', '<C-p>', ':Telescope find_files<CR>')
map('n', '<leader>fb', ':NvimTreeToggle<CR>')
map('n', '<leader>gs', ':Git<CR>')
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gd', ':Git diff<CR>')
map('n', '<leader>gp', ':Git -c push.default=current push<CR>')
map('n', '<Esc>', ':noh <CR>')
map('n', '<leader>dv', ':DiffviewOpen<CR>')
map('n', '<leader>dc', ':DiffviewClose<CR>')

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
map('n', 'C', '"_C')
map('v', 'C', '"_C')
-- keep in visual mode after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

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

g.lightline = { colorscheme = 'tokyonight', enable = { tabline = false } }
g.auto_save = true
g.dashboard_default_executive = 'telescope'
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

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

local builtin = require("statuscol.builtin")
require("statuscol").setup(
  {
    relculright = true,
    segments = {
      {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"},
      {text = {"%s"}, click = "v:lua.ScSa"},
      {text = {builtin.foldfunc, " "}, click = "v:lua.ScFa"},
    },
    bt_ignore = {"terminal"},
    ft_ignore = {"NvimTree", "git"}
  }
)


require('ufo').setup()

require('diffview').setup({ 
    hooks = {
      view_opened = function(view)
        vim.api.nvim_exec2("CocDisable", { output = false })
      end,
      view_closed = function(view)
        vim.api.nvim_exec2("CocEnable", { output = false })
      end,
    }
})

--[[
NvimTree
--]]
require('nvim-tree').setup({})

require('dashboard').setup({})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})

--[[
Telescope
--]]
local actions = require('telescope.actions')
local telescope = require('telescope')
local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous
        },
      },
    },
    pickers = {
      live_grep = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
        additional_args = function(_)
          return { "--hidden" }
        end
      },
      find_files = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
        hidden = true
      },
      grep_string = { 
        hidden = true
      }
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            -- freeze the current list and start a fuzzy search in the frozen list
            ["<C-space>"] = actions.to_fuzzy_refine,
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      }
    }
  })
telescope.load_extension("live_grep_args")

--[[
Zen mode
--]]
require("zen-mode").setup {
  plugins = { tmux = { enabled = true }}
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
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', 'jj', [[<c-\><c-n>]], opts)
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

vim.cmd('colorscheme tokyonight')
vim.cmd 'source ~/.config/nvim/config.vim'

