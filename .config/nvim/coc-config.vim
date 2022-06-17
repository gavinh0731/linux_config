let g:coc_global_extensions = [
\ 'coc-pyright'
\ ]


" 太長的更新間隔會導致明顯的延遲並降低使用者體驗（預設是 4000 ms = 4s ）
set updatetime=300

" 永遠顯示 signcolumn（行號左邊那個，這我不知道怎麼翻），否則每當有診斷出來時整個程式碼就會被往右移
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " 新的版本可以把 signcolumn 和行號合併（這個我版本不夠沒看過，有人知道會長怎樣可以下面留言嗎？）
  set signcolumn=number
else
  set signcolumn=yes
endif

" 用 tab 鍵觸發自動補全
" 注意：載入設定後記得用命令 `verbose imap <tab>` 確定這沒有被其他外掛覆蓋掉
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 讓 enter 鍵自動完成第一個建議並讓 coc 進行格式化（不確定個格式化指的是什麼，我看不太出來）
" enter 可以被重複 keymap（看不懂就算了，意思是你亂搞不會出錯）
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 用 \rn 重新命名變數、函數（原文寫「符號」）
nmap <leader>rn <Plug>(coc-rename)

" 這個讓你可以捲動浮動視窗和跳出式框框（有時候自動補全給你的文件會太長超出螢幕，如果你想要看下面的內容必須設定這個）
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" 設定文字編碼（我想這個你的 init.vim/.vimrc 都應該有了）
set encoding=utf-8

" 如果 hidden 沒有設定，「TextEdit」可能會失敗
" TextEdit 也許是彈出式輸入框吧？阿災
set hidden

" 有些伺服器對於備份檔會出錯，請看 issue #649
" https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

" 把下面的命令欄變高，多一點空間
set cmdheight=2

" 不傳訊息給「|ins-completion-menu|」（這我看不太出來有什麼差
set shortmess+=c


" 使用 <c-space> 觸發自動完成
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh
endif

" 用 `[g` 和 `]g` 跳到診斷的位置（就是程式碼有問題地方
" 用命令 `:CocDiagnostics` 在分割視窗列出目前檔案中所有有問題的點
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 程式碼轉跳（這個我覺得有點難記，而且這四個實驗出來效果非常像，我的建議是試過後選你覺得順眼的，不要全上
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 用 K（注意大寫）顯示文件在分割視窗
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 突顯游標下的符號（這是淡淡的灰色
autocmd CursorHold * silent call CocActionAsync('highlight')

" 整理程式碼，但是我們在 Day 15 裝過 Chiel92/vim-autoformat 了，coc 的 autoformat 在遇到不會的情況會直白的噴錯比較醜，
" 相較之下 vim-autoformat 比較好看，所以我建議兩個選一個，不要都裝
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " 設定指定檔案的 formatter
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.（這個真的不會翻譯
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 將 codeAction 應用到選取的區域
" 範例：`<leader>aap` 對應一個段落 (ap = a paragraph，同理 aw = a word)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 將 codeaction 應用到這個檔案
nmap <leader>ac  <Plug>(coc-codeaction)
" 自動修補目前這行（這要 language server 有提供
nmap <leader>qf  <Plug>(coc-fix-current)

" 映射函數和類別（嗎？測試起來怪怪的
" 注意：需要 language server 支援 'textDocument.documentSymbol'
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" 用 CTRL-S 選取整個函數或是類別
" 需要 language server 支援 'textDocument/selectionRange'
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" 新增 `:Format` 命令，和 Chiel92/vim-autoformat 選一個就行了
command! -nargs=0 Format :call CocAction('format')

" 新增 `:Fold` 命令，可以摺疊目前的檔案（我怎麼測試就是折不起來，不確定到底在幹麻，vim 內建也有摺疊阿？
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 新增 `:OR` 命令，可以整理目前檔案引入的函式庫（測試 Golang 會刪掉沒用到的但是 nodejs 要用 'import' 才會理人，用 'require' 他會當作沒看到什麼都不做
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" 添加 (neo)vim 原生的狀態列支援（他會在最下面提供一些訊息
" 注意：用 `:h coc-status` 指令看如何和其他狀態列外掛結合
" 提供範例：lightline.vim, vim-airline.（如果你要用這個的話請務必看範例，不然你的外掛等於白裝
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CocList 的鍵盤映射（CocList 的功能是顯示所有 XXX，我等等就只寫 XXX 的部份
" 診斷
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" 擴充
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" 命令
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" 大綱（和 tag bar 的功能差不多，就是你定義的變數物件函數等等
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" 在 workspace 中找某個變數、函數、物件（「符號」）
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" 執行預設的 `:CocNext`
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" 執行預設的 `:CocPrev
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" 打開上一次的 `:CocList`（這個指令可以列出很多東西
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
