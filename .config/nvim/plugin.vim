call plug#begin('~/.vim/plugged')
" === === 【外觀相關】 === === === === === === === === === ===
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
" 書籤外掛
Plug 'MattesGroeger/vim-bookmarks'

" === === 【GIT相關】 === === === === === === === === === ===
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
" <leader>+f    " 檔案列表搜尋預設
" <leader>+b    " Buffer列表搜尋預設
let g:Lf_ShortcutF = '<F8>'  " 檔案列表搜尋 
" let g:Lf_ShortcutB = '<c-l>'
noremap <leader>l :LeaderfSelf<cr>
noremap <leader>lm :LeaderfMru<cr>
noremap <F12> :LeaderfFunction<cr>
noremap <leader>lf :LeaderfFunction<cr>
noremap <leader>lb :LeaderfBufTagAll<cr>
noremap <leader>lt :LeaderfBufTag<cr>
noremap <leader>ll :LeaderfLine<cr>
noremap <leader>lw :LeaderfWindow<cr>

" ------------------------------------------------------
" 糢糊查詢 也是提供強大的搜索功能，可以和 Leaderf 互補
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nnoremap <leader>fl :Lines 
nnoremap <leader>fb :BLines 
nnoremap <leader>ff :Files 
nnoremap <leader>fg :GFiles 
nnoremap <leader>f? :GFiles? 
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>fa :Ag 
nnoremap <leader>fc :Commits

" ------------------------------------------------------
" 全文檢索(配合ripgrep指令)
Plug 'mileszs/ack.vim'
" ack.vim --- {{{

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <leader>/ :Ack!<Space>
nnoremap <F1> :Ack!<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" 切換 Quickfix 視窗
function! ToggleQF()
    if !exists("g:fx_toggle")
        let g:fx_toggle = 0
    endif
    if g:fx_toggle == 0
        let g:fx_toggle = 1
        copen
    else
        let g:fx_toggle = 0
        cclose
    endif
endfunc
map <silent> <F2> :call ToggleQF()<cr>

" ------------------------------------------------------
" 自動生成 tags 數據庫
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_add_default_project_roots=0
" gutentags搜索工程目錄的標志，碰到這些文件/目錄名就停止向上一級目錄遞歸 "
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_project_root = ['.root']

" 所生成的數據文件的名稱 "
let g:gutentags_ctags_tagfile = '.tags'

" 將自動生成的 tags 文件全部放入 ~/.cache/tags 目錄中，避免污染工程目錄 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 檢測 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的參數 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


" === === 【編輯相關】 === === === === === === === === === ===
" ------------------------------------------------------
" 自動括號
Plug 'jiangmiao/auto-pairs'
" 這是自訂括號的寫法
au FileType ejs let b:AutoPairs = AutoPairsDefine({'<%': '%>', '<!--': '-->'})
au FileType html let b:AutoPairs = AutoPairsDefine({'<!--': '-->'})

" 彩色括號
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

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



" === === 【Coc.nvim相關】 === === === === === === === === === ===
" ------------------------------------------------------
" 自動格式化
map <leader>i :call Format()<CR>
func! Format()
    exec "w"
    if &filetype == 'python'
        exec "!python3 -m black %"
    endif
endfunc
set autoread       "當vim打開的文件變化時,自動載入,因為black會修改python文件


" 用 <反斜線 f> 可以整理程式碼（要裝 python3 和 pynvim，詳細請看 GitHub ）
" $ python3 -m pip install pynvim
" Plug 'Chiel92/vim-autoformat'
" 這裡指定成你的 python3 路徑
" let g:python3_host_prog="/usr/bin/python3"
" nmap <leader>f :Autoformat<CR>

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


