# linux_config
Config for Linux

# 安裝說明
```
nvim ~/.vimrc
nvim ~/.config/nvim/init.vim

:so %
:PlugInstall
```

# 快捷鍵說明

## 自定快捷鍵
+ `ctrl+n` 切換滑鼠模式 Enable/disable mouse
+ `ctrl+b` Switch to text/binary
+ `ctrl+j` To utf-8 file
+ `ctrl+t` Convert tab to spaces
+ `ctrl+l` Toggle line breaking

+ `<F1>` 精確搜尋
+ `<leader>/` 在某個字按 `Enter`：精確搜尋
+ `<leader>/` 後面接小寫的文字，按 `Enter`：不區分大小寫
+ `<F2>` 切換Quickfix列表
+ `<F3>` 向下搜尋游標所指定的文字
+ `<F4>` 轉跳到游標所指定的函數定義
+ `<F5>` 轉跳到上次編輯的位置(返回)
+ `<F6>` 轉跳到下次編輯的位置(向前)
+ `<F7>` 開啟目前目錄的檔案列表
+ `<F8>` 專案的檔案列表搜尋
+ `<F9>` 檢視undo的堆疊
+ `<F10>` 切換行號滑鼠模式 Switch to full/simple
+ `<F12>` 檢視目前檔案定義的函數、變數等(需有ctags)

## 基本快捷鍵
### 移動光標

#### 單位級

-   `h` 向左一字符
-   `j` 下一行
-   `k` 上一行
-   `l` 向右一字符

#### 單詞級

-   `w` or `W` 向右移動到下一單詞開頭
-   `e` or `E` 向右移動到單詞結尾
-   `b` or `B` 向左移動到單詞開頭

_注意：所有小寫單詞都是以分詞符作為單詞界限，大寫字母以空格作為界限_

#### 塊級

-   `gg` 到文檔第一行
-   `G` 到文檔最後一行
-   `0` 到行首（第 1 列）
-   `^` 到第一個非空白字符
-   `$` 到行尾
-   `Ctrl-d` 向下移動半頁
-   `Ctrl-u` 向上移動半頁
-   `Ctrl-f` 向下移動一頁
-   `Ctrl-b` 向上移動一頁
-   `:<N>` or `<N>gg` 跳轉到第 N 行
-   `:+<N>` or `<N>j` 向下跳 N 行
-   `:-<N>` or `<N>k` 向上跳 N 行

_注意：所有命令前都可以加一個數字 N，表示對後面的命令執行 N 次，例如你想向下移動 3 行，除了  
可以用 `:+3` 之外，還可以用 `3j` 來實現同樣的效果。另外，上面實際上有兩種命令：一種是鍵入後  
立即執行的，比如 `gg`；還有一種是先輸入 `:` 的（後面還會出現先按 `/` 的），這類命令需要在  
輸入完成後按回車執行，後面的教程中也是一樣。

### 修改文檔

你現在已經學會了控制光標、打開文件、切換文件、並在文件中查找內容，這些操作都是在 vim 的 normal  
模式下進行的。現在，是時候進入 vim 的另外一種模式 —— insert 模式，學習一下如何修改文件了。

#### 插入

-   `i` 當前字符前插入
-   `a` 當前字符後插入
-   `I` 行首插入
-   `A` 行尾插入
-   `o` 在下一行插入
-   `O` 在上一行插入

_注意：以上任何一個命令都會使 vim 進入 insert 模式，進入該模式後光標會發生變化，這時輸入的  
文字會直接出現在文檔中，按 `Esc` 鍵或 `Ctrl-[` 或 `Ctrl-C` 退出 insert 模式。_

#### 刪除(並保存到 vim 剪貼板)

-   `x` 刪除當前字符，相當於 insert 模式下的 `Delete`
-   `X` 刪除前一個字符，相當於 insert 模式下的 `Backspace`
-   `dd` 刪除當前行，並將刪除的內容保存到 vim 剪貼板
-   `d<X>` 刪除指定內容並保存到 vim 剪貼板
-   `c<X>` 刪除指定內容並保存到 vim 剪貼板，同時進入 insert 模式

_說明： `<X>` 部分是對操作內容的描述，如果要刪除一個單詞，就輸入 `dw` 或者 `de`，要復制當前  
位置到行尾的內容，就輸入 `y$`，要刪除後面 3 個字符並插入，就輸入 `c3l` 諸如此類。_

#### 復制

-   `yy` 復制當前行到 vim 剪貼板
-   `y<X>` 復制指定內容到 vim 剪貼板

#### 粘貼

-   `p` 在當前位置後粘貼
-   `P` 在當前位置前粘貼

#### 合並

-   `J` 將當前行與下一行合並

> 嘗試在下面的文本中進行復制粘貼練習

```
刪除這一行粘貼到這一行下面剪切 ABC 並把它粘貼到 XYZ 前面，使這部分內容看起來像剪切 並把它粘貼到 ABC XYZ 前面。
```

#### 替換

-   `r<X>` 將當前字符替換為 X
-   `gu<X>` 將指定的文本轉換為小寫
-   `gU<X>` 將指定的文本轉換為大寫
-   `:%s/<search>/<replace>/` 查找 search 內容並替換為 replace 內容

> 嘗試修改下列文本的大小寫

```
Change this line to UPPERCASE, THEN TO lowercase.
```

> 還有個更好玩的命令 `g~<X>`，先將光標定位到上面那行文本，執行 `0g~$` 看看發生了什麼。

#### 撤銷、重做

-   `u` 撤銷
-   `Ctrl-r` 重做

#### 保存文件

-   `:w` 保存當前文件
-   `:wa` 保存全部文件
-   `:wq` or `ZZ` 保存並退出
-   `:q!` or `ZQ` 強制退出，不保存
-   `:saveas <new filename>` 文件另存為
-   `:w <new filename>` 文件另存一份名為 `<new filename>` 的副本並繼續編輯原文件

## coc.nvim
智能補全類的插件

### coc.nvim說明

| 快捷鍵         | 說明                                 |
| -------------- | ------------------------------------ |
| `tab`          | 觸發自動補全                         |
| `<leader>rn`： | 新命名變數、函數                     |
| `[g` 和 `]g`   | 跳到診斷的位置（就是程式碼有問題地方 |
| `gd`           | 程式碼轉跳(coc-definition)           |
| `gr`           | 程式碼轉跳(coc-references)           |
| gy           | 程式碼轉跳(coc-type-definition)           |
| gi           | 程式碼轉跳(coc-implementation)           |

#### 代碼格式化
- `<leader>+I` 使用yapf自動格式化python程式碼

## leaderF
- `<F8>`  查找文件： 
	`<leader>+F(預設組合鍵)`，然後在輸入文件名關鍵字，按 Enter 選中文件。
	可以看到，這裡面不用輸入準確的文件名字，只需要部分關鍵字，匹配度最高的文件出現在最上面，還可以通過 
	- `Ctrl+J, Ctrl+K` 上下移動光標， 來選擇文件，很高效吧，這是通過 Leaderf 的模糊匹配算法實現的。

- `Ctrl+]` 跳轉到函數定義處。
	光標移動到函數 `syscon_regmap_lookup_by_phandle`，按 Ctrl \+ \] 組合鍵，就跳到這個函數原型處，按 `Ctrl + o` 組合鍵返回。

- `gr` 查找那些地方有調用這個函數。
	按Ctrl \+ J 或者 K 上下移動光標， 來選擇文件，這裡選了atmel-ebi.c 這個文件，然後敲 Enter鍵跳過去。

- `<F12>`  查找當前打開文件的函數列表。
	這裡直接用了 `LeaderfFunction` 這個命令，也可以定義成快捷鍵。

- `<leader>+B`  查找Buffer列表。

## 糢糊檢索 fzf
+ `<leader>fl` :Lines 快速開啟全文檢索搜尋視窗
+ `<leader>fb` :BLines 
+ `<leader>ff` :Files 快速開啟檔案搜尋視窗
+ `<leader>fg` :GFiles 
+ `<leader>f?` :GFiles? 
+ `<leader>ft` :Tags`<cr>`
+ `<leader>fa` :Ag 快速開啟全域搜尋的視窗
+ `<leader>fc` :Commits

## 全文檢索
+ `<F1>` 精確搜尋
+ `<leader>/` 在某個字按 `Enter`：精確搜尋
+ `<leader>/` 後面接小寫的文字，按 `Enter`：不區分大小寫
+ `<F2>` 切換Quickfix列表
+ `]q`或`[q` 。 VIM將光標移至下一個/上一個結果，並在需要時在新緩沖區中打開文件。
+ 完成後要關閉Quickfix列表，您可以轉到底部的Quickfix窗口並關閉它，也可以運行
   `:cclose`    
- 要備份打開的快速修復列表，請運行`:copen`

## 書籤外掛
| Action                                        | Shortcut     | Command                       |
| --------------------------------------------- | ------------ | ----------------------------- |
| Add/remove bookmark at current line           | `mm`         | `:BookmarkToggle`             |
| Add/edit/remove annotation at current line    | `mi`         | `:BookmarkAnnotate <TEXT>`    |
| Jump to next bookmark in buffer               | `mn`         | `:BookmarkNext`               |
| Jump to previous bookmark in buffer           | `mp`         | `:BookmarkPrev`               |
| Show all bookmarks (toggle)                   | `ma`         | `:BookmarkShowAll`            |
| Clear bookmarks in current buffer only        | `mc`         | `:BookmarkClear`              |
| Clear bookmarks in all buffers                | `mx`         | `:BookmarkClearAll`           |
| Move up bookmark at current line              | `[count]mkk` | `:BookmarkMoveUp [<COUNT>]`   |
| Move down bookmark at current line            | `[count]mjj` | `:BookmarkMoveDown [<COUNT>]` |
| Move bookmark at current line to another line | `[count]mg`  | `:BookmarkMoveToLine <LINE>`  |
| Save all bookmarks to a file                  | x            | `:BookmarkSave <FILE_PATH>`   |
| Load bookmarks from a file                    | x            | `:BookmarkLoad <FILE_PATH>`   |

## 註釋
+ `<leader>cc` 註釋當前行和選中行
+ `<leader>ci` 執行反轉註釋操作，選中區域註釋部分取消註釋，非註釋部分添加註釋
+ `<leader>cu` 取消註釋
+ `<leader>c<空格>` 如果被選區域有部分被註釋，則對被選區域執行取消註釋操作，其它情況執行反轉註釋操作
