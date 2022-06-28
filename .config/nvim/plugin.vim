call plug#begin('~/.vim/plugged')
" ------------------------------------------------------
" 底部狀態增強/美化外掛
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" @airline
set t_co=256      "在windows中用xshell連線開啟vim可以顯示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否開啟tabline
"這個是安裝字型後 必須設定此項" 
let g:airline_powerline_fonts = 1   " 使用powerline外觀
set laststatus=2  "永遠顯示狀態列
" let g:airline_theme='dark' "選擇主題
let g:airline_theme='bubblegum'               "選擇主題
let g:airline_minimalist_showmod = 1          " 當緩衝區修改時高亮
let g:airline#extensions#tabline#enabled=1    "smarter tab line: 顯示視窗tab和buffer
"let g:airline#extensions#tabline#left_sep = ' '  "separater
"let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
"let g:airline#extensions#tabline#formatter = 'default'  "formater
"let g:airline_left_sep = '▶'
"let g:airline_left_alt_sep = '❯'
"let g:airline_right_sep = '◀'
"let g:airline_right_alt_sep = '❮'

" ------------------------------------------------------
" git 相關
" 在行號左側會顯示這行的 git 狀態，新增、刪除、修改，詳細請看 GitHub README
Plug 'airblade/vim-gitgutter'

" ------------------------------------------------------
" 目錄樹
" 按下 <F7> 可以開啟檔案樹，按 h 有說明，再一下關掉說明
Plug 'scrooloose/nerdtree'
nmap <F7> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

" ------------------------------------------------------
" 糢糊查詢
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
let g:Lf_ShortcutF = '<F8>'
" <leader>+f, <leader>+b

" === === 【編輯相關】 === === === === === === === === === ===
" ------------------------------------------------------
" 自動括號
Plug 'jiangmiao/auto-pairs'
" 這是自訂括號的寫法
au FileType ejs let b:AutoPairs = AutoPairsDefine({'<%': '%>', '<!--': '-->'})
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--': '-->'})

" ------------------------------------------------------
" 註釋
" 說明：
" <leader>cc 註釋當前行和選中行
" <leader>ci 執行反轉註釋操作，選中區域註釋部分取消註釋，非註釋部分添加註釋
" <leader>cu 取消註釋
Plug 'preservim/nerdcommenter'
filetype plugin on
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
let g:NERDCustomDelimiters = { 'ejs': { 'left': '<!--','right': '-->' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" 按 <F9> 可以回朔到開啟檔案以來的任何歷史，還會標出修改的地方，很酷
Plug 'mbbill/undotree'
nnoremap <F9> :UndotreeToggle<CR>

" <F8> 看看你設定了哪些變數、函數，也可以快速跳轉
"Plug 'majutsushi/tagbar'
"nmap <F8> :TagbarToggle<CR>

" 用 <反斜線 f> 可以整理程式碼（要裝 python3 和 pynvim，詳細請看 GitHub ）
" $ python3 -m pip install pynvim
Plug 'Chiel92/vim-autoformat'
" 這裡指定成你的 python3 路徑
let g:python3_host_prog="/usr/bin/python3"
nmap <leader>f :Autoformat<CR>

" 在你開啟 markdown 文件時會開啟網頁預覽你的
" markdown，有雙螢幕或是把畫面讓一半給瀏覽器比較好用（需要裝 nodejs）
" $ npm -g install instant-markdown-d
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" 快速整理程式碼，這個外掛的功能超多，但是因為有 autoformat 所以我只用排 md
" 表格的功能，他可以幫你把垂直線對齊，舒舒服服，要深入使用請看 GitHub README
" 先用選取模式把表格選起來，按兩下反斜線就可以得到一個漂亮的表格
Plug 'junegunn/vim-easy-align'
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" 快速建立 html tag，用法非常靈活，明天會專門講他的用法
Plug 'mattn/emmet-vim'

" ------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
so ~/.config/nvim/coc-config.vim

" ------------------------------------------------------

call plug#end()


