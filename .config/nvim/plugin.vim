call plug#begin('~/.vim/plugged')
" ------------------------------------------------------
" 彩色的 status bar
" Plug 'itchyny/lightline.vim'
"  有這個設定 lightline 在單個 vim 視窗中才會正常，沒錯！vim
"  也可以分割視窗，後天會講
" set laststatus=2

" 在行號左側會顯示這行的 git 狀態，新增、刪除、修改，詳細請看 GitHub README
Plug 'airblade/vim-gitgutter'

" 按下 <F7> 可以開啟檔案樹，按 h 有說明，再一下關掉說明
Plug 'scrooloose/nerdtree'
nmap <F7> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

" 自動括號
Plug 'jiangmiao/auto-pairs'
" 這是自訂括號的寫法
au FileType ejs let b:AutoPairs = AutoPairsDefine({'<%': '%>', '<!--': '-->'})
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--': '-->'})

" 之前講過了，這邊附上一些設定
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
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

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


