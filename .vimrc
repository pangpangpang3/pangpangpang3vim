" *****************
" muzuiget 的 vimrc
" modifid by iceleaf
" *****************

" 初始化 {{{1
" ======

"自动加载配置文件
autocmd! bufwritepost *.vimrc source $HOME/.vimrc

" 关闭 vi 的兼容
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Bundle 'Lokaltog/vim-powerline'
"set laststatus=2
"set t_Co=256
"let g:powerline_symbols='fancy'
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'scrooloose/nerdcommenter'
Bundle 'L9'
Bundle 'taglist.vim'
Bundle 'ctrlpvim/ctrlp.vim'
"------------------
" code Completions
" -----------------
Bundle 'shougo/neocomplcache'
Bundle 'shougo/neosnippet'
Bundle 'honza/vim-snippets'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
"let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
filetype plugin indent on
" 内置插件 {{{2
" --------

" 使用 matchit 插件
source $VIMRUNTIME/macros/matchit.vim

" 使用跟 Windows 兼容的快捷键设定
"source $VIMRUNTIME/mswin.vim

" Windows 特别设置
if has("win32")
    source $VIMRUNTIME/vimrc_example.vim
endif

" 第三方插件 {{{2
" ----------

" 使用 pathogen 插件
try
    runtime bundle/pathogen.git/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" 选项 {{{1
" ====

" 常规 {{{2
" ----

set nobackup                       " 不使用备份功能
set bufhidden=hide                 " 隐藏缓冲区
set hlsearch                       " 开启查找高亮
set incsearch                      " 开启即时查找
set showcmd                        " 开启显示命令
set history=1000                   " 历史最大记录
set number                         " 显示行数
set display=lastline               " 显示所有内容
set scrolloff=3                    " 距离垂直边界 n 行就开始滚动
set sidescroll=1                   " 水平滚动列数
set sidescrolloff=10               " 距离水平边界 n 行就开始滚动
set isfname-==                     " 文件名过滤不包含等号
set ruler                          " 总是显示当前位置
set fileencoding=utf-8             " 文件默认编码
set fileencodings=utf-8,ucs-bom,gb18030,big5,default " 检测编码顺序
set ignorecase                     " 忽略大小写查找
set helplang=cn                    " 使用中文文档
set listchars=tab:\|_,trail:·      " list样式制表符和空格显示
set foldlevel=1					   " 自动折叠等级为1
set foldlevelstart=99              " 默认打开不折叠
set completeopt-=preview           " 补全不显示预览窗口
set splitbelow                     " 分割窗口时新窗口在下方
set title                          " 修改终端窗口标题

if &binary == 1                    " 二进制编辑模式
    set display+=uhex              " 以十六进制显示不可打印字符
endif

let mapleader = ";"                " 使用逗号作 leader 键
let maplocalleader = "\\"          " 使用反斜杠作 localleader 键

" 恢复上次文件打开位置
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 命令行补全 {{{2
" ----------

set wildmenu                       " 命令行补全使用增强模式
set wildmode=list:longest          " 补全时显示样式为多行
set wildignore+=.hg,.git,.svn                    " 版本控制
set wildignore+=*.pyc                            " Python 字节码
set wildignore+=*.sw?                            " Vim 交换文件
set wildignore+=*.aux,*.out,*.toc                " LaTeX 文件
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " 二进制图像
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " 已编译的对象文件
set wildignore+=*.luac                           " Lua 字节码
set wildignore+=*.DS_Store                       " OSX 糟糕物

" 缩进 {{{2
" ----

set autoindent                     " 开启自动缩进
set cindent                        " 开启C语言的自动缩进
set expandtab                      " 开启把Tab扩展为空格
set tabstop=4                      " 设置Tab宽度为4个字符
set softtabstop=4                  " 软缩进宽度
set shiftwidth=4                   " 设置移动代码块宽度
set shiftround                     " 移动代码块时取整到缩进宽度

" 状态栏 {{{2
" ------

set laststatus=2
set statusline=%<%f\ %h%m%r        " 文件名及状态
set statusline+=%=                 " 中间空白
set statusline+=%-20.(%{&ff}:%{strlen(&fenc)?&fenc:&enc}:%{strlen(&ft)?&ft:'text'}%) " 格式:编码:类型
set statusline+=\ %-10.(%l,%c%V%)\ %P " 标尺信息

" 语法 {{{2
" ----

filetype plugin on                 " 开启文件类型插件
filetype indent on                 " 开启文件类型自动缩进
syntax enable                      " 开启语法高亮
try                                " 设置色彩方案
    colorscheme firefly
catch
    colorscheme desert
endtry

" 不同界面特别设置
if has("gui_running")              " 使用GUI时
    set guioptions-=T              " 关闭工具栏
    "set guioptions-=m              " 关闭菜单栏
    set guioptions-=t              " 菜单不可撕下
    set guioptions-=e              " 非GUI标签栏
    set winaltkeys=no              " Alt键不映射到菜单上
    set columns=120                " 设置窗口列数
    set lines=26                   " 设置窗口行数
    set guifont=Yahei\ Mono\ 10
    set autochdir
else                               " 使用CLI时
    if &term == "xterm"            " 虚拟终端
        set t_Co=256               " 终端颜色数
    elseif &term == "linux"        " 控制台
        colorscheme torte          " 设置色彩方案
    endif
endif

" 默认配色修改
if g:colors_name == "torte"
    highlight Normal guifg=White ctermfg=NONE ctermbg=NONE
elseif g:colors_name == "desert"
    highlight Normal guibg=Black
    highlight NonText guibg=Black
endif

"color murphy " 颜色主题
"color torte
set cursorline
highlight CursorLine cterm=NONE ctermbg=darkgray

" 键位映射 {{{1
" ========

" 界面 {{{2
" ----

nnoremap <leader>gt :set guioptions+=T <cr>
nnoremap <leader>gT :set guioptions-=T <cr>
nnoremap <leader>gm :set guioptions+=m <cr>
nnoremap <leader>gM :set guioptions-=m <cr>
nnoremap <leader>gs :set guioptions+=mT <cr>
nnoremap <leader>gh :set guioptions-=mT <cr>
nnoremap <leader>ss :w<cr>

" 标签 {{{2
" ----
map <c-p> :tabnext<cr>
map <c-i> :tabprevious<cr>

nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tw :tabclose<cr>
nnoremap <leader>ty :tabnext<cr>
nnoremap <leader>tr :tabprevious<cr>

" 窗口操作 {{{2
" ----
"map <s-F12> :split<CR>  		"横向分割窗口
"map <c-F12> :vsplit<CR>		"坚向侵害窗口
"map <s-F10> :close<CR>   "关闭当前窗口
"map <c-F10> :only<CR>    "只留当前窗口

" 高亮 {{{2
" ----
set colorcolumn=81

" 高亮第 81 列
nnoremap <leader>m :set colorcolumn=81<cr>
"
" 关闭高亮列
nnoremap <leader>M :set colorcolumn=""<cr>

" 取消查找高亮
nnoremap <a-/> :nohlsearch<cr>
inoremap <a-/> <esc>:nohlsearch<cr>i
nnoremap <leader>/ :nohlsearch<cr>

" 样式 {{{2
" ----

" 切换制表符和空格样式
nnoremap <leader>l :set invlist<cr>

" 切换行数
nnoremap <leader>n :set invnu<cr>

" 手动折叠
nnoremap <leader>fm :set foldmethod=manual<cr>

" 按缩进折叠
nnoremap <leader>fi :set foldmethod=indent<cr>

" 将自动折叠等级设置为1
nnoremap <leader>fl :set foldlevel=1<cr>

" " 用空格键来开关折叠
set foldmethod=indent
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 移动 {{{2
" ----

" 光标 {{{3
" ~~~~

nnoremap H ^
nnoremap L $

inoremap <a-h> <left>
inoremap <a-j> <down>
inoremap <a-k> <up>
inoremap <a-l> <right>
inoremap <a-a> <esc>$a
inoremap <a-i> <esc>^i

" 行间 {{{3
" ~~~~

inoremap <a-J> <esc>O<esc>jA
inoremap <a-K> <esc>kddA

" 窗口 {{{3
" ~~~~

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" 插入 {{{3
" ~~~~

" 插入上次删除的单词
inoremap <a-W> <c-r>w

" 在光标下插入新行
inoremap <a-o> <esc>o

" 在光标上插入新行
inoremap <a-O> <esc>O

" 插入当前行第一个单词到下一行,用b寄存器
inoremap <a-b> <esc>^"byeo<c-r>b

" 插入光标出上一行单词，用g寄存器
inoremap <a-g> <esc>keb"gyejA<c-r>i

" 删除 {{{3
" ~~~~

" 删除当前行并重写
inoremap <a-r> <esc>ddO

" 删除到行尾
inoremap <a-u> <esc>wd$a

" 删除光标处的单词
inoremap <a-w> <esc>eb"wdei

" 删除光标处双引号之间的字符串
inoremap <a-S> <esc>di"i

" 查找和替换 {{{2
" ----------

" 全文
nnoremap <c-s> :%s/
inoremap <c-s> <esc>:%s/
nnoremap <leader>s :%s/

" 选择
vnoremap <a-s> <esc>:s/
vnoremap <leader>s :s/

" 打开 {{{2
" ----

" 本文件
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>tev :tabedit $MYVIMRC<cr>

" 命令行 {{{2
" ------

" 移动
"nnoremap <c-h> <home>
"nnoremap <c-l> <end>

" 插入特殊字符
"cnoremap <c-q> <c-v>

" 其它 {{{2
" ----

" 禁用 K 键看手册
nnoremap K <nop>

" 文件类型切换
nnoremap <leader>ft :set filetype=

" 文件换行格式切换
nnoremap <leader>ff :set fileformat=unix

" 文件编码切换
nnoremap <leader>fe :set fileencoding=utf-8

" diff 操作
nnoremap <leader>dt :windo diffthis<cr>
nnoremap <leader>df :windo diffoff<cr>

" 写入
nnoremap <leader>w :w<cr>

" 退出
nnoremap <leader>q :q<cr>

" sudo 写入
nnoremap <leader>W :w !sudo tee % >/dev/null

" 在 quickfix 窗口显示上次查找
nnoremap <leader>? :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" 函数 {{{1
" ====

" 清除光标前空格
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

" 预览窗口显示在屏幕下方
function! PreviewDown()
   if !&previewwindow
       silent! wincmd P
   endif
   if &previewwindow
       silent! wincmd J
       silent! wincmd p
   endif
endf

" 自动命令 {{{1
" ========

" 常规 {{{2
" ----

" 预览窗口显示在屏幕下方
autocmd BufWinEnter * call PreviewDown()

" 禁用视觉响铃
autocmd GUIEnter * set visualbell t_vb=

" 文件类型 {{{2
" --------

" vimperatorrc 配置文件高亮
autocmd BufNewFile,BufRead *vimperatorrc* setfiletype vim

" proto 语法高亮
autocmd! BufNewFile,BufRead *.proto setfiletype proto

" moin 语法高亮
autocmd BufNewFile,BufRead *.moin setfiletype moin

" lrc 语法高亮
autocmd BufNewFile,BufRead *.lrc setfiletype lrc

" cue 语法高亮
autocmd BufNewFile,BufRead *.cue setfiletype cue

" 插件设置 {{{1
" ========

" Minibufexpl
"let g:miniBufExplMapCTabSwitchBufs = 1
"nn <c-j> :bn<cr>
"nn <c-k> :bp<cr>

" NerdTree {{{2
" --------

let NERDTreeIgnore=['\.pyc$']
let NERDTreeDirArrows=0
let NERDTreeWinPos="left"
let NERDTreeQuitOnOpen=1
noremap <f2> :NERDTreeToggle<cr>

" PyRef {{{2
" -----

let g:pyref_mapping = '<leader>k'

" Voom {{{2
" ----

"nnoremap <leader>O :Voom<cr>
"nnoremap <leader>o :Voom

nnoremap <leader>o <c-w>gf<cr>

" Tagbar设置
nnoremap <silent> <F12> :TagbarToggle<CR>

nnoremap <silent> <F3> :!python % <CR>
nnoremap <silent> <F4> :!qmlscene % <CR>
nnoremap <silent> <F5> gd<CR>
nnoremap <silent> <F8> :%s/\s\+$//g<CR>

" for vim-godef
let g:godef_split=2

"syntastic 语法检查设置
let g:syntastic_check_on_open=1
let g:syntastic_quiet_warning=0
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=0
let g:syntastic_python_checker_args='--ignore=E501,E302,E231,E261,E201,W402,W293,W291,E225,E203,E226'
nmap cs :SyntasticCheck<CR>

" css color 设置
"let g:cssColorVimDoNotMessMyUpdatetime = 1

" 未整理 {{{1
" ======

" 复制到系统剪贴板
"vnoremap <leader>y <esc>"+y
vnoremap <leader>y "+y

" 插入系统剪贴板内容
"nnoremap <leader>p <esc>"+p
nnoremap <leader>P <esc>"+P

" 主窗口大小变化时，vim里的分割窗口也自动调整
"autocmd VimResized * exe "normal! \<c-w>="

" 下划线分隔转驼峰
"nmap <leader>c viw:s/_\([a-z]\)/\u\1/g<cr>gUl:nohl<cr>

" 驼峰转下划线分隔
"nmap <leader>u viw:s/\<\@!\([A-Z]\)/\_\l\1/g<cr>gul:nohl<cr>
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
autocmd BufNewFile *.py 0r ~/.vim/template/pythonconfig.py
autocmd BufNewFile *.qml 0r ~/.vim/template/qmlconfig.qml
autocmd BufWritePre,FileAppendPre,FileWritePre,FilterWritePre *.qml: silent <F8>
autocmd BufEnter *.qss silent setlocal ft=css syntax=css
autocmd BufEnter *.qrc silent setlocal ft=xml syntax=xml
