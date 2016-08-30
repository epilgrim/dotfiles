" Juan Peri

" Settings {{{
" Vim Environment {{{
"set nocompatible              " required
"set modelines=0
"filetype off                  " required
"set t_Co=256
"set modelines=1

let mapleader = "\<space>"

"set shell=/bin/bash
"set lazyredraw
"set matchtime=3

" viminfo stores the the state of your previous editing session
if isdirectory($HOME . '/.vim/tmp') == 0
  :silent !mkdir -p ~/.vim/tmp >/dev/null 2>&1
endif
set viminfo+=n~/.vim/tmp/viminfo

"disable backups and swapfile
set nobackup
set nowritebackup
set noswapfile

" ,ev Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/tmp/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/tmp/undo') == 0
    :silent !mkdir -p ~/.vim/tmp/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/tmp/undo//
  set undofile
endif

"if !has('mac') && exists("+clipboard")
  "set clipboard=unnamedplus
"endif

" Working with split screen nicely resize Split When the window is resized"
"au VimResized * :wincmd =

"Make Sure that Vim returns to the same line when we reopen a file"
"augroup line_return
    "au!
    "au BufReadPost *
        "\ if line("'\"") > 0 && line("'\"") <= line("$") |
        "\ execute 'normal! g`"zvzz' |
        "\ endif
"augroup END

" }}}

" Vim Moving Around {{{
" Disabling default keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" windows management
nnoremap <leader>we <c-w>v<c-w>l
nnoremap <leader>ws <c-w>s<c-w>j
nnoremap <leader>wq <c-w>v<c-w>h
nnoremap <leader>w2 <c-w>s<c-w>k
nnoremap <leader>wc <c-w>c
nnoremap <c-x> <c-w>x
" }}}

" Vim Editing {{{
"set tags+=vendor.tags

"set title " Set title to window
"set dictionary=/usr/share/dict/words " Dictionary path, from which the words are being looked up.
set pastetoggle=<F3> " Make pasting done without any indentation break.
"set mouse=a " Enable Mouse

" More Common Settings.
"if !has('nvim')
    "set encoding=utf-8
"endif
"set scrolloff=3
"set autoindent
"set showmode
"set showcmd
"set hidden
"set completeopt=menu,preview
"set wildmenu
"set wildmode=list:longest
"set visualbell

"set cursorline
"set ttyfast
"set ruler
"set backspace=indent,eol,start
"set laststatus=2

"set relativenumber
set number
"if v:version >= 703
    "set norelativenumber
"endif

"Settings for Searching and Moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <leader><space> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Make Vim to handle long lines nicely.
"set wrap
"set textwidth=79
"set formatoptions=qrn1
"set synmaxcol=200 " do not syntax highlight lines longer than 200 chars
"" Long lines in diff mode also handled nicely
"autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" To  show special characters in Vim
"set listchars=tab:▸\ ,eol:¬

" Get Rid of help keys
"inoremap <F1> <ESC>
"nnoremap <F1> <ESC>
"vnoremap <F1> <ESC>

" Insert ; at the end of the line
"inoremap ;; <End>;<Esc>


" ,ft Fold tag, helpful for HTML editing.
"nnoremap <leader>ft vatzf

" ,q Re-hardwrap Paragraph
"nnoremap <leader>q gqip

" ,v Select just pasted text.
"nnoremap <leader>v V`]

" faster save
"nnoremap <leader>w :w<CR>

" jj For Quicker Escaping between normal and editing mode.
inoremap jj <ESC>

" This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file.
" while editing file /some/path/myfile.txt, typing :e %%/ on the command line
" will expand to :e /some/path/
"cabbr <expr> %% expand('%:p')

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
   silent exe "normal! `[v`]\"_c"
   silent exe "normal! p"
endfunction

"filetype plugin indent on

" }}}

" Autocomplete {{{
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType eco set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" autocomplete to longest common mantch and show even if there is only one option
set completeopt=menuone,longest

inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))
" }}}

" }}}

" Plugins {{{
" Start Setup Plugins{{{
call plug#begin('~/.vim/plugged')
" }}}

" vim-sensible {{{
Plug 'tpope/vim-sensible'
" }}}
" fzf {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
" }}}
" Ag {{{
Plug 'rking/ag.vim'
" Search word under cursor
nnoremap F :Ag<CR>
if executable('ag')
  let g:ag_prg='ag -S --nocolor --nogroup --column --ignore "./tags" --ignore "./public/stylesheets/*" --ignore "./tags.vendor" --ignore "./app/cache" --ignore "./app/logs"'
endif
" }}}
" Execute commands on quickfix files {{{
Plug 'henrik/vim-qargs'
" }}}
" NerdTree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
nmap <leader>n <ESC>:NERDTreeToggle<cr>
nmap <leader>nf <ESC>:NERDTreeFind<cr>
let NERDTreeIgnore=['\^.vim$', '\~$', '\.pyc$']
" }}}
" UndoTree {{{
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
" }}}
"" SimplePairs {{{
"if !has('nvim')
  "Plug 'vim-scripts/simple-pairs'
"endif
"" }}}
"" NerdCommenter {{{
Plug 'scrooloose/nerdcommenter'
"" }}}
"" Syntastic {{{
"if !has('nvim')
  "Plug 'scrooloose/syntastic'
  "" Syntastic disable style checkers
  "let g:syntastic_ruby_checkers = ['mri', 'rubocop']
"endif
"" }}}
" Neomake {{{
if has('nvim')
  Plug 'benekastah/neomake'
  autocmd! BufWritePost * Neomake
endif
" }}}
"" Tagbar {{{
"Plug 'majutsushi/tagbar'
"nmap <leader>l <ESC>:TagbarToggle<cr>
"" }}}
" Fugitive {{{
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs  :Gstatus<cr>
nnoremap <leader>gc  :Gcommit --verbose<cr>
nnoremap <leader>gp  :Gpush<cr>
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}
" Git Gutter {{{
Plug 'airblade/vim-gitgutter'
" }}}
" Git Log {{{
Plug 'junegunn/gv.vim'
" }}}
"" Supertab {{{
"Plug 'ervandew/supertab'
"" }}}
" Deoplete autocomplete {{{
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
" }}}
" UltiSnips {{{
if v:version >= 704 && (exists(':python2') || exists(':python3'))
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif
" }}}
" Lint Trailing Whitespace {{{
Plug 'ntpeters/vim-better-whitespace'
",W Command to remove white space from a file.
nnoremap <leader>W :StripWhitespace<CR>
" }}}
" Indent guides {{{
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" }}}
"" Airline {{{
"Plug 'bling/vim-airline'
""let g:airline_section_b = '%{getcwd()}'
""let g:airline_section_c = '%t'
"let g:airline#extensions#branch#displayed_head_limit = 15
"let g:airline#extensions#tabline#fnamemod = ':p:.'
"" }}}
"" Mkdir {{{
"Plug 'pbrisbin/vim-mkdir'
"" }}}
"" CoffeeScript {{{
"Plug 'kchmck/vim-coffee-script'
"Plug 'mustache/vim-mustache-handlebars'
"" }}}
"" Tabular {{{
"Plug 'godlygeek/tabular'
"nmap <Leader>t= :Tabularize /=/l1l0<CR>
"vmap <Leader>t= :Tabularize /=/l1l0<CR>
"nmap <Leader>t: :Tabularize /:\zs<CR>
"vmap <Leader>t: :Tabularize /:\zs<CR>
"" }}}
" Markdown {{{
" Syntax {{{
Plug 'tpope/vim-markdown'
" }}}
" Preview {{{
Plug 'kannokanno/previm' "Realtime preview Markdown, reStructuredText, textile
let g:previm_enable_realtime = 1
" }}}
" }}}
" Yaml {{{
Plug 'stephpy/vim-yaml'
" }}}
" Open In Browser {{{
Plug 'tyru/open-browser.vim' "Open URI with your favorite browser
" }}}
"" Javascript Syntax {{{
"Plug 'jelera/vim-javascript-syntax'
"" }}}
" PHP {{{
"" Namespaces {{{
"Plug 'arnaud-lb/vim-php-namespace'
""Import classes (add use statements)
"noremap <Leader>nu :call PhpInsertUse()<CR>
"" Make class names fully qualified
"noremap <Leader>ne :call PhpExpandClass()<CR>
"" }}}
" Sintax {{{
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" }}}
"" PHP Refactor {{{
"Plug 'vim-php/vim-php-refactoring'
"let g:php_refactor_command='php /usr/local/bin/refactor.phar'
"" }}}
" Vdebug {{{
Plug 'joonty/vdebug', { 'for': 'php' }
if !exists("g:vdebug_options")
    let g:vdebug_options={}
endif
let g:vdebug_options['break_on_open'] = 0
let g:vdebug_options['timeout'] = 40
let g:vdebug_options['server'] = "0.0.0.0"
" }}}
" }}}
" Ruby {{{
" Sintax {{{
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" }}}
" End blocks automatically {{{
Plug 'tpope/vim-endwise'
" }}}
" Slim Templates {{{
Plug 'slim-template/vim-slim', { 'for': 'slim' }
" }}}
" Rubocop {{{
Plug 'kagux/vim-rubocop-autocorrect', { 'for': 'ruby' }
" }}}
" }}}
" Elixir {{{
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
" }}}
"" Golang {{{
"Plug 'fatih/vim-go'
"" }}}
"" Twig Templates {{{
"Plug 'evidens/vim-twig'
"" }}}
" Tests Runner {{{
Plug 'janko-m/vim-test'
let g:test#strategy = 'vimux'
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
" }}}
" BufOnly {{{
Plug 'duff/vim-bufonly'
" }}}
" Color Theme:  gruvbox {{{
Plug 'morhetz/gruvbox'
" }}}
" Tmux {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
let g:VimuxUseNearest = 1 "use nearest pane for output
let g:VimuxOrientation = 'h'
let g:VimuxHeight = "30"
" }}}
"" Css - less {{{
"Plug 'groenewege/vim-less'
"" }}}
" Local Vimrc {{{
Plug 'embear/vim-localvimrc'
let g:localvimrc_persistent=2
" }}}
"" Local Escape Ansi Colors {{{
"Plug 'Improved-AnsiEsc'
"" }}}
" Convert from/to snake and camel case {{{
Plug 'tpope/vim-abolish'
" }}}
" Auto save files {{{
Plug '907th/vim-auto-save'
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
" }}}
" Auto read files {{{
Plug 'djoshea/vim-autoread'
" }}}
" highlight movement targets on line {{{
Plug 'unblevable/quick-scope'
" }}}
"" GoldenRatio for vim windows {{{
"Plug 'roman/golden-ratio'
"" }}}

" End Setup Plugins {{{
" Add plugins to &runtimepath
call plug#end()
" }}}
" }}}

" StartUp {{{
" FileTypes Config {{{
" Generic {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" }}}

"" Yaml {{{
"autocmd FileType yaml setlocal autoindent shiftwidth=2 tabstop=2 expandtab
"" }}}
"" CoffeeScript {{{
"autocmd BufRead,BufNewFile *.coffee setfiletype coffee
"autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 expandtab foldmethod=indent nofoldenable
"" }}}
"" Javascript {{{
"autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab foldmethod=indent nofoldenable
"" }}}
"" SCSS {{{
"autocmd FileType scss setlocal shiftwidth=2 tabstop=2 expandtab foldmethod=indent nofoldenable
"" }}}
" }}}

" Theme config  {{{
if !has("gui_running")
  let g:gruvbox_italic=0
endif
set background=dark
silent! colorscheme gruvbox
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=1
