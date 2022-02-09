scriptencoding utf-8

let g:coc_global_extensions = [
  \ 'coc-phpls', 
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ ]

function! s:ask(message) abort
  call inputsave()
  echohl WarningMsg
  let answer = input(a:message)
  echohl None
  call inputrestore()
  echo "\r"
  return (answer =~? '^y') ? 1 : 0
endfunction

" Avoid hit-enter prompt when the message being echoed is too long.
function! s:truncate(msg) abort
  let l:maxlen = &columns * &cmdheight - 2
  let l:maxlen = &showcmd ? l:maxlen - 11 : l:maxlen
  let l:maxlen = &ruler ? l:maxlen - 18 : l:maxlen
  return len(a:msg) < maxlen ? a:msg : a:msg[:maxlen-3].'...'
endfunction

" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
function! CheckPlug(...) abort
  let l:msg = 'Install the missing plugins: '
  let missing = filter(values(g:plugs), '!isdirectory(v:val.dir)')
  if len(missing)
    let plugs = map(missing, 'split(v:val.dir, "/")[-1]')
    let l:msg .= string(plugs).' (y/N): '
    let l:msg = s:truncate(l:msg)
      if exists('*popup_dialog')
        call s:popup_dialog(l:msg)
        return
      endif
      if s:ask(l:msg)
        silent PlugInstall --sync | q
      endif
  endif
endfunction
autocmd VimEnter * call timer_start(1500, 'CheckPlug')

" vim-buffet
let g:buffet_show_index = 1
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_hidden_buffers = ['terminal', 'quickfix', 'git', 'fugitive']
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>
" Note: Make sure the function is defined before `vim-buffet` is loaded.
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=170 ctermfg=8 guibg=#82b1ff guifg=#000000
  hi! BuffetTab cterm=NONE ctermbg=235 ctermfg=8 guibg=#292D3E guifg=#bfc7d5
  hi! BuffetBuffer cterm=NONE ctermbg=170 ctermfg=8 guibg=#292D3E guifg=#bfc7d5
endfunction

nnoremap <leader>rc :%s/\<<C-r><C-w>\>/
if line('$') > 1000
  silent! setlocal norelativenumber
endif

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
elseif (coc#rpc#ready())
  call CocActionAsync('doHover')
else
  execute '!' . &keywordprg . " " . expand('<cword>')
endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

