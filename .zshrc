# README
# 安裝 zsh: sudo apt install zsh
# 更換 shell: chsh -s $(which zsh)
# 安裝 zplug: curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# 安裝 tmux: sudo apt install tmux
# curl https://gist.githubusercontent.com/simba-fs/e06a1763c1967ce3f4b5ef643db5e0b3/raw/2f28c62d01f419a390bfc0e66a974985bacdefa5/.tmux.conf > ~/.tmux.conf
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ -e /usr/share/terminfo/x/xterm+256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# ====== History ======
HISTFILE=~/.history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY
# ------ ------ ------

# 首先是在 zshrc 最上面加上一行 source 啟用 zplug
source ~/.zplug/init.zsh

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# miniconda
export PATH="~/miniconda3/bin:$PATH"

# poetry
export PATH="~/.local/bin:$PATH"

# zplug plugins
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-history-substring-search'
# zplug 'marlonrichert/zsh-autocomplete'
zplug 'hlissner/zsh-autopair'

# 然後 zshrc 最下面加上以下程式碼
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# case sensitive
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# zsh-autocomplete configure
# Down arrow:
#bindkey '\e[B' down-line-or-select
#bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.

bindkey "$terminfo[kcuu1]" history-substring-search-up 
bindkey "$terminfo[kcud1]" history-substring-search-down

# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
# [Backspace]: backward-delete-word OR backward-delete-char
bindkey "^H" backward-delete-char
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# some more ls aliases
# 看列表
alias ll='ls -hl'
# 看隱藏檔列表
alias la='ls -Al'
# 看隱藏檔
alias l='ls -A'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'

# 加上 -r 在刪除/複製目錄時才不會跳警告
alias rm='rm -r'
alias cp='cp -r'

# -h 可以把檔案大小加上適當的單位，比較好讀
# -l 印出除了檔名其他的資訊，ex：權限、大小
# -F、--color 純粹是好看
alias ls='ls -CF --color=auto'

# 把當前目錄下的檔案/目錄以樹狀結構印出來，會把不重要的（.git, node_modules）忽略，後面可以接路徑
alias tree="tree -alI 'node_modules|.git'"

# 加上顏色
alias grep='grep --color=always'

# 超好用，在當前目錄中所有檔案中找指定字串，用法：grepFind 'console.log'，會印出檔案行號，還會把目標字串上色
alias grepFind='grep --exclude-dir=node_modules -nr . -e'

# 建立巢狀目錄時會一併建立上層目錄，下面解釋
alias mkdir='mkdir -p'
    

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hisharp/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hisharp/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hisharp/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hisharp/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

function conda_set() {
    # 呼叫原始的conda命令
    conda activate "$@"

    # 覆蓋式保存最新一次啟動的conda環境名稱到.condarc檔案中
    rm -f ~/.last_conda_env
    echo "$(conda info --envs | grep '*' | awk '{print $1}')" >> ~/.last_conda_env
}

if [ -f ~/.last_conda_env ]; then
    # 讀取.condarc檔案中保存的最後一次啟動的conda環境名稱
    last_conda_env=$(cat ~/.last_conda_env)

    # 啟動最後一次啟動的conda環境
    conda activate $last_conda_env
fi

# <<< conda initialize <<<

