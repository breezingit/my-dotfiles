" curl -fLO $HOME/.config/nvim/autoload/plug.vim --create-dirs \
"	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

set nocompatible " be iMproved, required
filetype off " required


call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'gruvbox-community/gruvbox'
Plug 'liuchengxu/vim-which-key'
Plug 'rbgrouleff/bclose.vim'
Plug 'romgrk/doom-one.vim'
Plug 'kevinhwang91/rnvimr'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'navarasu/onedark.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'Pocco81/AutoSave.nvim'
Plug 'savq/melange'
Plug 'Rigellute/shades-of-purple.vim'

if has("nvim")
	Plug 'neovim/nvim-lspconfig'
	Plug 'glepnir/lspsaga.nvim'
endif

call plug#end()

let mapleader = " " " map leader to Space


nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>




autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
nnoremap tt :terminal<CR>
:tnoremap <Esc> <C-\><C-n>

" for opening tabs using space
" endfor


let g:airline#extensions#tabline#enabled = 1
let g:shades_of_purple_airline = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='shades_of_purple'

let g:vimfiler_as_default_explorer = 1



" nnoremap <silent> <leader>s :tabnew <bar> :Ex<CR>
" nnoremap <silent> <leader>f :VimFiler<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

" if (has("termguicolors"))
"  set termguicolors
" endif

syntax enable
" :colorscheme shades_of_purple

" let g:molokai_original = 1

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"


""""""
let g:ackprg = 'ag --vimgrep'
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)



let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Replace `$EDITOR` candidate with this command to open the selected file
let g:rnvimr_edit_cmd = 'drop'

" Disable a border for floating window
let g:rnvimr_draw_border = 0

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70

" Draw border with both

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine


" nnoremap <silent> <leader>s :tabnew <bar> :Ex<CR>
""" leaving brackets
inoremap <C-e> <C-o>A
""""
nnoremap <silent> <leader>s :enew <bar> :RnvimrToggle<CR>
nnoremap <silent> <leader>f :Files<CR>
""""TOGGLING THROUGH BUFFERS
map gn :bn<cr>
map go :bp<cr>
nnoremap <silent> <leader>w :bd<CR>
" map gd :bd<cr>  

"""" For Rg
nnoremap <silent> <leader>r :Rg<CR>

""""
" Resize floating window by all preset layouts
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

" Resize floating window by special preset layouts
tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

" Resize floating window by single preset layout
tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]

" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }

" Customize multiple preset layouts
" '{}' represents the initial layout
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]

" Fullscreen for initial layout
" let g:rnvimr_layout = {
"            \ 'relative': 'editor',
"            \ 'width': &columns,
"            \ 'height': &lines - 2,
"            \ 'col': 0,
"            \ 'row': 0,
"            \ 'style': 'minimal'
"            \ }
"
" Only use initial preset layout
" let g:rnvimr_presets = [{}]

"""""
""""" Tree Sitter


""""" autosave

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF
"""""Prettier

command! -nargs=0 Prettier :CocCommand prettier.formatFile

""""
filetype on
filetype plugin on
filetype indent on
syntax on
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set list listchars=tab:»·,trail:·
""" Find word in directory""""
""" :vimgrep /pattern/gj ./**/*.rb
