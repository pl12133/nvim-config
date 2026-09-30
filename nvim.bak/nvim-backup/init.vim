set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" colorscheme vim
set encoding=utf-8
scriptencoding utf-8
filetype on                  " required
" nnoremap <SPACE> <Nop>
" let mapleader = " "
let mapleader = "g"

set noincsearch

" source ~/.vimrc

call plug#begin()

" Enhanced JS Syntax Plugin
" Plug 'jelera/vim-javascript-syntax'

" Based on https://github.com/nikolalsvk/dotfiles/blob/master/.vimrc
"Plug 'pangloss/vim-javascript'    " JavaScript support
"Plug 'leafgarland/typescript-vim' " TypeScript syntax
"Plug 'maxmellon/vim-jsx-pretty'   " JSX syntax
"Plug 'peitalin/vim-jsx-typescript' " Typescript replacement for maxmellon/vim-jsx-pretty
"Plug 'jparise/vim-graphql'        " GraphQL syntax
"Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" trying this out to fix out-of-sync syntax highlight
"autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
"autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
"autocmd BufEnter * let @f=expand('%:t:r')

" Treesitter for syntax - instead of all above plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Taboo tab renamer
Plug 'sirbrillig/taboo.vim'

" SCSS Syntax hilighting
Plug 'cakebaker/scss-syntax.vim'

" .editorconfig support: editorconfig-vim
Plug 'editorconfig/editorconfig-vim'

" GraphQL Syntax Plugin
" Plug 'jparise/vim-graphql'

" Sublime multiple cursors
" Plug 'terryma/vim-multiple-cursors'

" Improved JSX syntax highligh and indentation
" Plug 'chemzqm/vim-jsx-improve' " OLD?
" Plug 'neoclide/vim-jsx-improve'

" Auto-imports 
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" Debugger
" Plug 'vim-vdebug/vdebug'

" CoC engine
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Commenting
" Plug 'preservim/nerdcommenter' " idk if i need this im trying out gcc and gc 

" Kotlin
" Plug 'udalov/kotlin-vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Vimspector Debugger - requires Vim compiled with Python
" Plug 'puremourning/vimspector'

" Many languages supported
" Plug 'sheerun/vim-polyglot'

" Neovim plugins start here
Plug 'github/copilot.vim' " replace this with zbirenbaum/copilot.lua soon
" Plug 'zbirenbaum/copilot.lua' " use this when you are on Node 20
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

" LSP config starter
Plug 'neovim/nvim-lspconfig'

" Tree explorer
" Plug 'nvim-tree/nvim-tree.lua'

" interactive keybind menu when pressing a leader / modifier
" Plug 'folke/which-key.nvim'

" relaxing chill theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" formatter
Plug 'stevearc/conform.nvim'

" autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" snippet library
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" statusline generator 
" Plug 'nvim-lua/lsp-status.nvim'

" Fidget to display lsp info in bottom right
Plug 'j-hui/fidget.nvim'

" statusline 
Plug 'nvim-lualine/lualine.nvim'

" Put your non-Plugin stuff after this line
call plug#end()

colorscheme catppuccin
highlight LineNr guifg=#eeeeee " set line number color

" Pick one
filetype plugin indent on
" filetype plugin off

syn on
set synmaxcol=1000
syntax sync minlines=200
syntax sync maxlines=500

"autocmd BufNewFile,BufRead *.graphql   set syntax=graphql
"autocmd BufNewFile,BufRead *.ts   set syntax=javascript

" Whitespace settings
set softtabstop=0 tabstop=2 shiftwidth=2 expandtab
" set expandtab

" Tab hotkeys
"nnoremap    th  :tabprevious<CR>
nnoremap    gb          gT
nnoremap    g[          gT
nnoremap    gh          gT
"nnoremap    tl  :tabnext<CR>
nnoremap    g]          gt
nnoremap    gl          gt
nnoremap    <leader>t   :tabnew<CR>
" nnoremap    <leader>l   :set number!<CR>

" Open new tab with FZF File searcher
" command     TabFuzzyFile      tabe|Files
nnoremap    <leader>p         :TabFuzzyFile<CR>
" this is preferred but it messes up other tabe actions
let g:fzf_action = { 'enter': 'tabe' }
nnoremap    <leader>p         :Files<CR>
nnoremap    g1   :1<CR>

" nnoremap    <leader>f   :tabe \| :Files<CR>

" New tab straight into Explore
command     TabExplore        tabe|Explore
cnoreabbrev tabE TabExplore

inoremap ˙ <Left>
inoremap ∆ <Down>
inoremap ˚ <Up>
inoremap ¬ <Right>

" CTRL+C to system copy in visual mode
vnoremap <C-c> :y +<CR>

" Taboo config
let g:taboo_tab_format = " %1a%m "

" Nerdcommenter Plugin Config
let g:NERDDefaultAlign = 'left'

" Map ESLint fixer to <leader>p
" noremap <leader>p :!npx eslint % --fix<cr>:cwindow<cr>:redraw!<cr>:e<cr>
" noremap <leader>s :!npx stylelint % --fix<cr>:cwindow<cr>:redraw!<cr>:e<cr>

set relativenumber
set number
set hlsearch
set backspace=2 " i never really understood this

set tags=tags

" console.log variable under cursor 
let @l = 'yeoconsole.log("[FILTERED] p:", p);'

" Add new-line prop from latest register
let @k = 'O={}0f=Pf{p'

" Add prop from latest register
let @p = 'pa={} klP'

" Normal mode on jj
inoremap jj <Esc>

" Helper to copy the current filename to clipboard
command! CopyFilename :let @+=@%

lua require('config')

" Fix syntax highlighting for specific file types
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
