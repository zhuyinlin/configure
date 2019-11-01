" Maintainer: Emily

" This must be first, because it changes other options as a side effect.
if has('vim_starting')
    set nocompatible    " 关闭vi兼容
endif

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let g:vim_bootstrap_editor = "vim"    " nvim or vim

if g:vim_bootstrap_editor == 'nvim'
    let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
else
    let vimplug_exists=expand('~/.vim/autoload/plug.vim')
endif

if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    if g:vim_bootstrap_editor == 'nvim'
        silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
if g:vim_bootstrap_editor == 'nvim'
    call plug#begin(expand('~/.local/share/nvim/plugged'))
else
    call plug#begin(expand('~/.vim/plugged'))
endif

" ========================== Plug install packages ==========================
" window
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'flazz/vim-colorschemes'
" Plug 'tomasr/molokai'
" Plug 'altercation/vim-colors-solarized'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'

"" search
if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
endif
"" terminal?
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}
"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'majutsushi/tagbar'
" Plug 'vim-scripts/taglist.vim'
Plug 'ervandew/supertab'
Plug 'ryanoasis/vim-devicons'    " must be loaded after Nerdtree, powerline ...

"auto complete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'deoplete-plugins/deoplete-jedi'
endif

Plug 'sheerun/vim-polyglot'    " 多种语言的语法高亮包, 详情查看官网。
                               " 注意并不一定提供所包含插件的完整功能
Plug 'Valloric/YouCompleteMe'
if v:version >= 704
    "" Snippets
    Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'    " for ultisnips
" Plug 'drmingdrmer/xptemplate'
Plug 'vim-scripts/DoxygenToolkit.vim'

" syntax
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'    " async lint engine, 需要安装相应linter

" coding
if v:version >= 800
    " gtags相关
    Plug 'ludovicchabant/vim-gutentags'    "索引自动管理
    Plug 'skywind3000/gutentags_plus'    "索引数据库切换
    " Plug 'skywind3000/vim-preview'    "索引预览
endif
Plug 'jiangmiao/auto-pairs'
" Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'    " 多行同时编辑

" format
Plug 'Chiel92/vim-autoformat'
Plug 'AndrewRadev/linediff.vim'

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'

" reStructuredText
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Latex
Plug 'lervag/vimtex'

" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'python-mode/python-mode'
" Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" c / c++
" Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp', 'h', 'txx']}     " <C-J>快捷键冲突
Plug 'ludwig/split-manpage.vim'
Plug 'vim-scripts/a.vim'    " Alternate Files quickly (.c --> .h etc)

" go
"" Go Lang Bundle
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

" html, css
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
" Plug 'gorodinskiy/vim-coloresque'
" Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

" javascript
"" Javascript Bundle
" Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'

" React Native
Plug 'mxw/vim-jsx'
" Plug 'sbdchd/neoformat'
" Plug 'flowtype/vim-flow'
Plug 'justinj/vim-react-snippets'    "new

" lisp
"" Lisp Bundle
" Plug 'vim-scripts/slimv.vim'

" lua
"" Lua Bundle
" Plug 'xolox/vim-lua-ftplugin'
" Plug 'xolox/vim-lua-inspect'

" perl
"" Perl Bundle
" Plug 'vim-perl/vim-perl'
" Plug 'c9s/perlomni.vim'

" php
"" PHP Bundle
" Plug 'arnaud-lb/vim-php-namespace'

" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'


" rust
" Vim racer
" Plug 'racer-rust/vim-racer'
" Rust.vim
Plug 'rust-lang/rust.vim'

Plug 'neomake/neomake'

call plug#end()    " required

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
filetype plugin indent on    " required
filetype off    " required for vundle, 关闭文件类型侦测

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
if g:vim_bootstrap_editor == 'vim'
    set ttyfast
endif

set fileformats=unix,dos,mac

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Enable hidden buffers
set hidden    " 允许在有未保存的修改时切换缓冲区

"" Searching
set hlsearch
set incsearch    " do incremental searching
set ignorecase
set smartcase

"" autocomplete
" 让Vim的补全菜单行为与一般IDE一致(智能补全,弹出菜单，无歧义时才自动填充)
set completeopt=longest,menu
set wildmenu    " vim 自身命令行模式智能补全

"" Map leader to ,
let mapleader=","

set wildignore+=*/tmp/*,*.so,*.swp,*.swo,*.pyc,*.db,*.sqlite,*.zip,*.tar,*.tar.gz,*.jpg,*.png,*.gif,*.jpeg,*~,.DS_Store    " MacOSX/Linux

"" Directories for swp files
if has("vms")
    set nobackup    " do not keep a backup file, use versions instead
else
    set backup    " keep a backup file
endif
set noswapfile

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
if g:vim_bootstrap_editor == 'nvim'
    let g:session_directory = "~/.config/nvim/session"
else
    let g:session_directory = "~/.vim/session"
endif
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on    " 语法高亮
set ruler    " show the cursor position all the time
set number    " 开启行号显示
set relativenumber    " show related row numbers

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"     set mouse=a
" endif
set mousemodel=popup    "?
set t_Co=256
set guioptions=egmrti    "?
set gfn=Monospace\ 10    "?

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3    " 光标移动到距离顶部或底部开始滚到距离

"" Status bar
set laststatus=2    " 显示状态行
if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

set bsdir=buffer    " 设定文件浏览器目录为当前目录
runtime macros/matchit.vim
" packadd! matchit
"
set cursorline    " 高亮显示当前行
set cursorcolumn    " 高亮显示当前列

" 基于缩进或语法进行代码折叠(za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠)
set foldmethod=indent
set foldmethod=syntax
set nofoldenable    " 启动 vim 时关闭折叠代码

" 指定屏幕上可以进行分割布局的区域 "
set splitbelow
set splitright

" noremap \ ,
set history=50    " keep 50 lines of command line history
set showcmd    " display incomplete commands

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" ========================== solarized ==========================
if !exists('g:not_finish_vimplug')
    set background=dark
    let g:solarized_termcolors=256
    colorscheme jellybeans
    "Tomorrow-Night-Eighties
    "Zenburn
    "jellybeans
    "gruvbox
    "solarized
    "molokai
endif

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
    autocmd!
    autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"" C++
au BufNewFile,BufRead *.c,*.cpp,*.h
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix |
            \ set cindent

au BufNewFile,BufRead *.txx set filetype=cpp

"" python
au BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix

let python_highlight_all = 1
"au BufNewFile,BufRead *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/

"" for reStructuredText
au BufNewFile,BufRead *.rs
            \set textwidth=79


"" javascript
au BufNewFile,BufRead *.js,*.html,*.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2

"" for react native
" autocmd BufWritePre *.js Neoformat

au BufRead,BufNewFile * if &l:modifiable | setlocal fileformat=unix | endif

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Switching windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" Split
" noremap <Leader>h :<C-u>split<CR>
" noremap <Leader>v :<C-u>vsplit<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" scroll history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
" tab navigation like zsh
" :nmap <leader>h :tabprevious<CR>
" :nmap <leader>l :tabnext<CR>

"" Set working directory
" nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
" noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTICE\|INFO\|IDEA\)')
    endif
endif

command Td noautocmd vimgrep /TODO/j ** | cw
command Nt noautocmd vimgrep /NOTICE/j ** | cw
command Fx noautocmd vimgrep /FIXME/j ** | cw

"*****************************************************************************
"" Plugin configure
"*****************************************************************************
" ========================== NerdTree ==========================
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 自启动
" autocmd VimEnter * NERDTree
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.obj$', '\.egg$', '^\.git$', '^\.svn$', '\.rbc$', '\.db$', '^\.hg$', '\~$', '\.swp$', '\.swo$', '\.swn$', '\.swm$', '\.orig$']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']

" ========================== NerdCommenter ==========================
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ========================== fugiter ==========================
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" ========================== airline ==========================
"
" if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
"     if !exists('g:airline_theme')
"         let g:airline_theme = 'solarized'
"     endif
"     if !exists('g:airline_powerline_fonts')
"         " Use the default set of separators with a few customizations
"         let g:airline_left_sep='›'     " Slightly fancier than '>'
"         let g:airline_right_sep='‹'    " Slightly fancier tha '<'
"         let g:airline_powerline_fonts = 1
"     endif
" endif
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline_skip_empty_sections = 1
" let g:airline#extensions#virtualenv#enabled = 1
"
" "" Convenience variables
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
"
" if !exists('g:airline_powerline_fonts')
"     let g:airline#extensions#tabline#left_sep = ' '
"     let g:airline#extensions#tabline#left_alt_sep = '|'
"     let g:airline_left_sep = '▶'
"     let g:airline_left_alt_sep = '»'
"     let g:airline_right_sep = '◀'
"     let g:airline_right_alt_sep = '«'
"     let g:airline#extensions#branch#prefix = '⤴'    " ➔, ➥, ⎇
"     let g:airline#extensions#readonly#symbol = '⊘'
"     let g:airline#extensions#linecolumn#prefix = '¶'
"     let g:airline#extensions#paste#symbol = 'ρ'
"     let g:airline_symbols.linenr = '␊'
"     let g:airline_symbols.branch = '⎇'
"     let g:airline_symbols.paste = 'ρ'
"     let g:airline_symbols.paste = 'Þ'
"     let g:airline_symbols.paste = '∥'
"     let g:airline_symbols.whitespace = 'Ξ'
" else
"     let g:airline#extensions#tabline#left_sep = ''
"     let g:airline#extensions#tabline#left_alt_sep = ''
"
"     " powerline symbols
"     let g:airline_left_sep = ''
"     let g:airline_left_alt_sep = ''
"     let g:airline_right_sep = ''
"     let g:airline_right_alt_sep = ''
"     let g:airline_symbols.branch = ''
"     let g:airline_symbols.readonly = ''
"     let g:airline_symbols.linenr = ''
" endif

" ========================== startify ==========================
if g:vim_bootstrap_editor == 'vim'
    set viminfo='100,n$HOME/.vim/files/info/viminfo
else
    " set viminfo='100,n$HOME/.local/share/nvim/shada/main.shada
endif
" 设置书签
" let g:startify_bookmarks = [
"             \ '~/Project/test.cpp',
"             \]
" 起始页显示的列表长度
let g:startify_files_number = 20
" 自动加载session
let g:startify_session_autoload = 1
" 过滤列表，支持正则表达式
" let g:startify_skiplist = [
"             \ '^/tmp',
"             \ ]
" 自定义Header和Footer
" let g:startify_custom_header = [
"             \ '+------------------------------+',
"             \ '|                              |',
"             \ '|    Still waters run deep!    |',
"             \ '|                              |',
"             \ '+----------------+-------------+',
"             \]
" let g:startify_custom_footer = [
"             \ '+------------------------------+',
"             \ '|     Keep an open mind!       |',
"             \ '+----------------+-------------+',
"             \]

" ========================== fzf ==========================
nnoremap <silent> <C-p> :Files<CR>

" ========================== tagbar ==========================
"
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
" autocmd VimEnter * nested :TagbarOpen

" ========================== supertab ==========================
let g:SuperTabRetainCompletionType="context"

" ========================== vim-devicons ==========================
" Set encoding to UTF-8 to show glyphs
set encoding=utf-8
" Set Vim font to a Nerd Font
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11    " linux
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11    " mac
" If you use vim-airline you need this
" let g:airline_powerline_fonts = 1

" ========================== deoplete ==========================
let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert

" ========================== vim-polyglot ==========================
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python']
let g:polyglot_disabled = ['latex']

" ========================== YouCompleteMe ==========================
let g:ycm_python_binary_path = 'python'
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 跳转到定义处
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
" force recomile with syntastic
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>
" nnoremap <leader>lo :lopen<CR>    " open locationlist
" nnoremap <leader>lc :lclose<CR>    " close locationlist
nmap <leader>gd :YcmDiags<CR>
inoremap <leader><leader> <C-x><C-o>
if g:vim_bootstrap_editor == 'nvim'
    let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
else
    let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
endif
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 开启基于tag的补全，可以在这之后添加需要的标签路径
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'nerdtree' : 1,
            \}
" python has its own check engine
" let g:syntastic_ignore_files = [".*\.py$"]

" ========================== ultisnips ==========================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ========================== syntastic ==========================
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_python_checkers=['pylint', 'flake8']    " python
"
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_rst_checkers = ['sphinx']    " sphinx for reStructuredText

" ========================== ale ==========================
" 始终开启标志列
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
" let g:airline#extensions#ale#enabled = 1
let g:ale_open_list=1
let g:ale_set_highlights = 0
" 自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
" 在vim自带的状态栏中整合ale
" let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
" 显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 文件内容发生变化时不检查
" let g:ale_lint_on_text_changed = 'never'
" 打开文件时不进行检查
let g:ale_lint_on_enter = 0
" 指定linter
" let g:ale_linters = {
"             \ 'c++': ['clang'],
"             \ 'c': ['clang'],
"             \ 'python': ['pylint'],
" }
" 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
" nmap sp <Plug>(ale_previous_wrap)
" nmap sn <Plug>(ale_next_wrap)
" <Leader>s触发/关闭语法检查
" nmap <Leader>s :ALEToggle<CR>
" <Leader>d查看错误或警告的详细信息
" nmap <Leader>d :ALEDetail<CR>

" ========================== vim-autoformat ==========================

" au BufWrite * :Autoformat "自动格式化代码，针对所有文件
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" ========================== riv ==========================
let proj1 = { 'path': '~/Documents/reST_note',}
let g:riv_projects = [proj1]

" ========================== jedi-vim ==========================
let g:jedi#popup_on_dot = 0
" unable automatically initialized
" let g:jedi#auto_initialization = 0
" unable jedi-vim completion
" let g:jedi#completions_enabled = 0
let g:jedi#completions_command = "<Tab>"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#smart_auto_mappings = 0

" ========================== python-mode ==========================
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # Emily BREAKPOINT'

" ========================== vim-jsx ==========================
let g:jsx_ext_required = 0

" ========================== neomake ==========================
map <leader>m :Neomake<CR>
let g:neomake_open_list = 2
let g:neomake_list_height = 7

" ========================== DoxygenToolkit ==========================
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_authorName = "Emily"
let g:doxygen_enhanced_color = 1
"let g:load_doxygen_syntax = 1

" for C++ style, change the '@' to '\'
" let g:DoxygenToolkit_commentType = "C++"
" let g:DoxygenToolkit_briefTag_pre = "\\brief "
" let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
" let g:DoxygenToolkit_paramTag_pre = "\\param "
" let g:DoxygenToolkit_returnTag = "\\return "
" let g:DoxygenToolkit_throwTag_pre = "\\throw "    " @exception is also valid
" let g:DoxygenToolkit_fileTag = "\\file "
" let g:DoxygenToolkit_dateTag = "\\date "
" let g:DoxygenToolkit_authorTag = "\\author "
" let g:DoxygenToolkit_versionTag = "\\version "
" let g:DoxygenToolkit_blockTag = "\\name "
" let g:DoxygenToolkit_classTag = "\\class "

" ========================== session management ==========================
" nnoremap <leader>so :OpenSession<Space>
" nnoremap <leader>ss :SaveSession<Space>
" nnoremap <leader>sd :DeleteSession<CR>
" nnoremap <leader>sc :CloseSession<CR>

" ========================== CTags and GTags ==========================
" =====gutentags
let g:gutentags_define_advanced_commands = 1
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持
let g:gutentags_modules = []
if executable('ctags')
   let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
   let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数
" 设置tags
" set tags=tags;
" set autochdir
" 按下F5重新生成tag文件，并更新taglist
" map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
" imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
" 避免多个项目数据库相互干扰
" 使用plus插件解决问题
let g:gutentags_auto_add_gtags_cscope = 0

" =====gutentags_plus
let g:gutentags_plus_nomap = 1  " 快捷键与nerdcommenter 冲突，这里重新定义
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

" =====vim-preview
" 预览 quickfix 窗口 ctrl-w z 关闭
" P 预览 大p关闭
" autocmd FileType qf nnoremap <silent><buffer> <Leader>p :PreviewQuickfix<cr>
" autocmd FileType qf nnoremap <silent><buffer> <Leader>P :PreviewClose<cr>
" noremap <Leader>u :PreviewScroll -1<cr>    " 往上滚动预览窗口
" noremap <leader>d :PreviewScroll +1<cr>    " 往下滚动预览窗口

" ========================== taglist ==========================
" let Tlist_Ctags_Cmd='ctags'  "因为我们放在环境变量里，所以可以直接执行
" let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
" let Tlist_Auto_Open=1    "在启动VIM后，自动打开taglist窗口
" let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
" let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表
" let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
" " 是否一直处理tags.1:处理;0:不处理
" let Tlist_Process_File_Always=1 "实时更新tags, 不管taglist窗口有没有打开
" let Tlist_Inc_Winwidth=0
" let Tlist_Use_SingleClick= 1    " 缺省情况下，在双击一个tag时，才会跳到该tag定义的位置
" let Tlist_Sort_Type="name"    " tag按名字排序
" let Tlist_Compart_Format = 1    " 压缩方式
" nnoremap <silent> <leader>tl :TlistToggle<CR>

" ========================== Quick Run ==========================
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype =='cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        " exec "!go build %<"
        exec "!time go run %"
    endif
endfunc

