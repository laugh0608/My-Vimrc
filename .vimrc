"设置中文不乱码"
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"显示行号"
set nu
set number

"突出显示当前行"
set cursorline

"启用鼠标"
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"设置缩进tab为4空格"
set tabstop=4

"设置自动缩进长度为4空格"
set shiftwidth=4

"继承前一行的缩进方式，适用于多行注释"
set autoindent

"粘贴格式"
"set paste
set listchars=tab:>-,trail:-

"总是显示状态栏"
set laststatus=2
"状态行显示的内容"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

"vim配置变更立即生效"
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"打开文件类型检测"
filetype on
set completeopt=longest,menu

"打开语法高亮显示"
syntax on

"去除vim一致性"
set nocompatible

" 显示中文帮助"
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

" 设置当文件被改动时自动载入"
set autoread

"代码补全 "
set completeopt=preview,menu

"自动保存
set autowrite

"打开状态栏标尺"
set ruler

" 在处理未保存或只读文件的时候，弹出确认"
set confirm

" 自动缩进"
set autoindent
set cindent

"搜索忽略大小写"
set ignorecase

"搜索逐字符高亮"
set hlsearch
set incsearch

" 高亮显示匹配的括号"
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）"
set matchtime=1

"自动补全"
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
	else
		return a:char
endif
endfunction 

" indentline if等语句的代码块连接线"
let g:indentLine_color_term = 239
let g:indentLine_char = '¦' 
" 设置连接线的形状 , ¦, ┆, │, ⎸, or ▏"

"让vim记忆上次编辑的位置
autocmd BufReadPost *
if line("'\"")>0&&line("'\"")<=line("$") |
	exe "normal g'\"" |
endif



"新建.c,.h,.sh,.java文件，自动插入文件头"
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
"定义函数SetTitle，自动插入文件头 
func! SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
		call append(line(".")+1, "\# Author: laugh") 
		call append(line(".")+2, "\# mail: 1395404299@qq.com") 
		call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: laugh") 
		call append(line(".")+2, "	> Mail: 1395404299@qq.com") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
		if &filetype == 'java'
			call append(line(".")+6,"public class ".expand("%"))
			call append(line(".")+7,"")
		endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc





" ----------------------------- Vundle Start -----------------------------"
"设置包括vundle和初始化相关的运行时路径"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"启用vundle管理插件"
Plugin 'VundleVim/vundle.vim'

"启用YouCompleteMe插件"
Plugin 'ycm-core/YouCompleteMe' 

"函数跳转插件"
Plugin 'ludovicchabant/vim-gutentags'

"目录树插件nerdtree"
Plugin 'scrooloose/nerdtree'

"全局模糊搜索插件ctrlp”
Plugin 'ctrlpvim/ctrlp.vim'

"安装括号补全插件auto-pairs"
Plugin 'jiangmiao/auto-pairs'

"安装vim-airline"
Plugin 'bling/vim-airline'

"安装neocomplete插件"
Plugin 'Shougo/neocomplete'

"在此增加其他插件，安装的插件需要放在vundle#begin和vundle#end之间"
"安装github上的插件格式为Plugin '用户名/插件仓库名' "
call vundle#end()
" ----------------------------- Vundle End   -----------------------------"






"加载vim自带和插件相关的语法和文件类型相关脚本"
filetype plugin indent on

"gutentags配置"
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"需要注意的是，gutentags 需要靠上面定义的 gutentags_project_root 判断文件所在的工程，如果一个文件没有保存在包含 .git、.svn、.root等 定义在 gutentags_project_root 中的文件，gutentags就不会为该野文件生成 tags。"
"在为当前目录生成tags文件后，可以通过按键 Ctrl + ] 跳转到对应的定义位置，再使用命令 Ctrl + o 回退到原来的位置。"
"建议多使用 Ctrl + W + ] 用新窗口打开并查看光标下符号的定义，或者 Ctrl -W } 使用 preview 窗口预览光标下符号的定义。"

"NERADtree配置"
"在 vim 启动的时候默认开启 NERDTree"
autocmd VimEnter * NERDTree
au VimEnter * NERDTree

"将NERDTree的窗口设置在vim窗口的右侧(默认为左侧)"
"let NERDTreeWinPos="right"	"

"auto-paris配置”
"设置自动补全的符号"
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let b:AutoPairs = g:AutoPairs
"设置插件打开/关闭的快捷键，默认为ALT+p"
let g:AutoPairsShortcutToggle = '<M-p>'
"设置自动为文本添加圆括号的快捷键，默认为ALT+e"
let g:AutoPairsShortcutFastWrap = '<M-e>'
"设置调到下一层括号对的快捷键，默认为ALT+n"
let g:AutoPairsShortcutJump = '<M-n>'
"设置撤销飞行模式的快捷键，默认为ALT+b"
let g:AutoPairsShortcutBackInsert = '<M-b>'
"把BACKSPACE键映射为删除括号对和引号，默认为1"
let g:AutoPairsMapBS = 1
"把ctrl+h键映射为删除括号对和引号，默认为1"
let g:AutoPairsMapCh = 1
"把ENTER键映射为换行并缩进，默认为1"
let g:AutoPairsMapCR = 1
"当g:AutoPairsMapCR为1时，且文本位于窗口底部时，自动移到窗口中间"
let g:AutoPairsCenterLine = 1
"把SPACE键映射为在括号两侧添加空格，默认为1"
let g:AutoPairsMapSpace = 1
"启用飞行模式，默认为0"
let g:AutoPairsFlyMode = 0
"启用跳出多行括号对，默认为1，为0则只能跳出同一行的括号"
let g:AutoPairsMultilineClose = 1



"代码折叠"
"Vim支持多种折叠形式：手动折叠manual、基于缩进行折叠indent、基于语法进行折叠syntax、未更改文本折叠diff等"
"基于缩进进行代码折叠"
set foldmethod=indent

"启动 Vim 时关闭折叠"
set nofoldenable
"Vim打开文件后，重复使用操作命令 za 可打开或关闭当前折叠；zM 用于关闭所有折叠，zR 则用来打开所有折叠。"

"全局模糊搜索"
"在Vim命令行模式下使用命令 :help ctrlp.txt 获取ctrlp的官方说明文档"

"配置neocomplete"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

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
						let g:neocomplete#keyword_patterns['default'] = '\h\w*'

						" Plugin key-mappings.
						inoremap <expr><C-g>     neocomplete#undo_completion()
						inoremap <expr><C-l>     neocomplete#complete_common_string()

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
							  " Close popup by <Space>.
							  "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

							  " AutoComplPop like behavior.
							  "let g:neocomplete#enable_auto_select = 1

							  " Shell like behavior(not recommended).
							  "set completeopt+=longest
							  "let g:neocomplete#enable_auto_select = 1
							  "let g:neocomplete#disable_auto_complete = 1
							  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

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
								"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
								"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
								"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

								" For perlomni.vim setting.
								" https://github.com/c9s/perlomni.vim
								let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
