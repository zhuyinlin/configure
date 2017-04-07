
" Maintainer:	Bram Moolenaar <Bram@vim.org>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required
filetype plugin indent on    " required
" filetype plugin on
runtime macros/matchit.vim
" packadd! matchit
" vim 自身命令行模式智能补全
set wildmenu
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 基于缩进或语法进行代码折叠(za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠)
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" 指定屏幕上可以进行分割布局的区域 "
set splitbelow
set splitright

" split navigations"
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" scroll history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set t_Co=256
let mapleader=","
noremap \ ,
"set formatoptions=tcqmM
"set wrap
" ========================for python =============================
au BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

"au BufNewFile,BufRead *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/

au BufNewFile,BufRead *.js,*.html,*.css
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2

au BufRead,BufNewFile * if &l:modifiable | setlocal fileformat=unix | endif
set encoding=utf-8

command Td noautocmd vimgrep /TODO/j ** | cw
command Fx noautocmd vimgrep /FIXME/j ** | cw
" ============================vundle=================================
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" the 2 plugin bellow is for reStructured Text
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'tpope/vim-surround'
Plugin 'Townk/vim-autoclose'
" Plugin 'drmingdrmer/xptemplate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Shougo/neocomplete.vim'
"Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
" Plugin 'vim-scripts/taglist.vim'
Plugin 'python-mode/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-unimpaired'
" " Keep Plugin commands between vundle#begin/end.
" " All of your Plugins must be added before the following line
call vundle#end()            " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" ==================== neocomplete=======================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
     \ 'default' : '',
     \ 'vimshell' : $HOME.'/.vimshell_hist',
     \ 'scheme' : $HOME.'/.gosh_completions'
	 \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] ='\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>    neocomplete#undo_completion()
inoremap <expr><C-l>    neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ============================NerdTree================================
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 自启动
autocmd VimEnter * NERDTree
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.obj$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$', '\~$', '\.swp$', '\.swo$', '\.swn$', '\.swm$', '\.orig$']

" ======================NerdCommenter=================================
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

" =========================solarized======================= 

set background=dark
let g:solarized_termcolors=256
colorscheme solarized "molokai


" ============================airline===============================
"
if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
	if !exists('g:airline_theme')
		let g:airline_theme = 'solarized'
	endif
	if !exists('g:airline_powerline_fonts')
	" Use the default set of separators with a few customizations
		let g:airline_left_sep='›' "Slightly fancier than '>'
		let g:airline_right_sep='‹' "Slightly fancier tha '<'
	endif
endif

" =============================tagbar=================================
"
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30
autocmd VimEnter * nested :TagbarOpen

" ==============================CTags==================================  
"设置tags  
set tags=tags;  
set autochdir
" 按下F5重新生成tag文件，并更新taglist
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

" =============================taglist==================================
" let Tlist_Ctags_Cmd='ctags'  "因为我们放在环境变量里，所以可以直接执行
" let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
" let Tlist_Auto_Open=1    "在启动VIM后，自动打开taglist窗口
" let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
" let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表
" let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
" " 是否一直处理tags.1:处理;0:不处理
" let Tlist_Process_File_Always=1 "实时更新tags, 不管taglist窗口有没有打开
" let Tlist_Inc_Winwidth=0
" let Tlist_Use_SingleClick= 1  "缺省情况下，在双击一个tag时，才会跳到该tag定义的位置
" let Tlist_Sort_Type="name"   " tag按名字排序
" let Tlist_Compart_Format = 1    " 压缩方式
" nnoremap <silent> <leader>tl :TlistToggle<CR>

" ============================python-mode===============================
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0

" ============================jedi-vim===============================
" unable automatically initialized
" let g:jedi#auto_initialization = 0
" unable jedi-vim completion
" let g:jedi#completions_enabled = 0
let g:jedi#completions_command = "<leader><Space>"

" ============================YouCompleteMe===============================
let g:ycm_python_binary_path = 'python'
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu	
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	
" 跳转到定义处
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
"force recomile with syntastic
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>	
" nnoremap <leader>lo :lopen<CR>	"open locationlist
" nnoremap <leader>lc :lclose<CR>	"close locationlist
nmap <leader>gd :YcmDiags<CR>
inoremap <leader><leader> <C-x><C-o>

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
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
let g:syntastic_ignore_files = [".*\.py$"] 

" ============================riv===============================
let proj1 = { 'path': '~/Documents/reST_note/index.rst',}
let g:riv_projects = [proj1]

"==========================Quick Run=============================
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
		exec "!time python2.7 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		" exec "!go build %<"
		exec "!time go run %"
	endif
endfunc

