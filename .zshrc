# pathを設定
path=(~/bin(N-/) /usr/local/bin(N-/) ~/pear/bin(N-/) ~/.anyenv/bin(N-/) ${path})
export XDG_CONFIG_HOME=~/.config

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

fpath=(~/.config/gcloud/gcloud-zsh-completion/src $fpath)

# The next line enables shell command completion for aws.
source /usr/local/share/zsh/site-functions/_aws

if [ -d $HOME/.anyenv ] ; then
  eval "$(anyenv init -)"
fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN
export PATH=~/.anyenv/envs/phpenv/versions/7.3.5/composer/vendor/bin:$PATH

###########################################################
# zplugの設定                                              #
###########################################################

# pathの設定
if [ -z "${SSHHOME+x}" ]; then
    export ZPLUG_HOME=~/.zplug
else
    export ZPLUG_HOME=$SSHHOME/.zplug
fi

if [ ! -e $ZPLUG_HOME ]; then
    # curl -sL zplug.sh/installer | zsh
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

# プラグインを定義する
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'chrissicool/zsh-256color'
zplug 'b4b4r07/enhancd', use:init.sh

# インストールする
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose


###########################################################
# itermの設定                                              #
###########################################################

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


###########################################################
# fzfの設定                                                #
###########################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


###########################################################
#  lsの設定                                                #
###########################################################
# lsコマンド時、自動で色がつく
export CLICOLOR=true
# 色の設定
export LSCOLORS='exfxcxdxbxegedabagacad'
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORS設定
export ZLS_COLORS=$LS_COLORS


###########################################################
#  cdの設定                                               #
###########################################################
# ディレクトリ名の入力のみで移動する
setopt auto_cd
# cdした先のディレクトリをディレクトリスタックに追加する
setopt auto_pushd
# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# cdの後にlsとpwdを実行
chpwd() { ls -a; pwd }


###########################################################
#  aliasの設定                                             #
###########################################################
# historyに日付を表示
alias history='fc -lt '%F %T' 1'
# grepでヒットした文字列強調
alias grep="grep --color"

alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias mv='mv -i -v'

alias ...='cd ../..'
alias ....='cd ../../..'

alias ll='ls -l'
alias la='ls -a'

if type nvim >/dev/null 2>&1; then
    alias vi='nvim'
fi

if type ag >/dev/null 2>&1; then
    alias grep='ag'
fi


###########################################################
#  グロブの設定                                             #
###########################################################
# 大文字小文字区別
setopt case_glob
# 「= コマンド」を絶対パスの展開
setopt equals
# 拡張ブロブを使用する
setopt extended_glob
# ファイルグロブ機能を使用する
setopt glob
# .で始まるファイルもマッチ
setopt glob_dots
# 数値ソート
setopt numeric_glob_sort


###########################################################
#  ヒストリーの設定                                          #
###########################################################
# ヒストリを保存するファイル指定
HISTFILE=~/.zsh_history
# メモリに保存されるヒストリの件数
HISTSIZE=10000
# 保存されるヒストリの件数
SAVEHIST=10000

# ヒストリに実行時間も保存する
setopt extended_history
# 直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_dups
# ヒストリーに重複を表示しない
setopt hist_ignore_all_dups
# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store

# 他のターミナルとヒストリーを共有
setopt share_history


###########################################################
#  補完の設定                                               #
###########################################################
# 補完機能を有効にする
autoload -Uz compinit compdef; compinit
compdef sshrc=ssh

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs
# 補完候補を一覧で表示する
setopt auto_list
# 補完キー連打で補完候補を順に表示する
setopt auto_menu
# カッコの対応などを自動的に補完
setopt auto_param_keys
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完候補にファイルの種類も表示する
setopt list_types
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# 語の途中でもカーソル位置で補完
setopt complete_in_word
# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2
# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

# 補完を絞り込み
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

# kubesec補完
source <(kubesec completion zsh)

# helm補完
source <(helm completion zsh) >& /dev/null

###########################################################
#  プロンプトの設定                                         #
###########################################################
# プロンプトに色を付ける
autoload -Uz colors; colors

# プロンプト 右にカレントディレクトリと時刻を表示
PROMPT="[%(?.%{${fg[green]}%}.%{${fg[red]}%})%n%{${reset_color}%}@%{${fg[blue]}%}%m%{${reset_color}%}] %# "
RPROMPT="[%{${fg[green]}%}%*%{${reset_color}%}]"

# kube-ps1
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
kubeoff

###########################################################
#  gitの設定                                               #
###########################################################
# vcs_infoロード
autoload -Uz vcs_info
# PROMPT変数内で変数参照する
setopt prompt_subst

# vcsの表示
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "[%F{blue}%c%u%b%f]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# プロンプト表示直前にvcs_info呼び出し
precmd () { vcs_info }
# プロンプト表示
RPROMPT='${vcs_info_msg_0_}'$RPROMPT


###########################################################
#  その他の設定                                             #
###########################################################
# 各変数の重複を自動削除
typeset -U path cdpath fpath manpath

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8
# 日本語ファイル名等8ビットを通す
setopt print_eight_bit

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control
# ctrl -Dでログアウトさせない
setopt IGNOREEOF

# ビープを無効にする
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# rm * の前に確認をとる
setopt rm_star_wait

# URLをエスケープする
autoload -Uz url-quote-magic
# 文字入力時にURLをエスケープする
zle -N self-insert url-quote-magic

# jobsでプロセスIDも出力する。
setopt long_list_jobs
# バックグラウンドジョブの状態変化を即時報告する
setopt notify
# zsh終了時にbgジョブや一時停止中のジョブが表示される
setopt check_jobs

# 区切り文字の設定
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# リダイレクトによる上書き禁止 「>!」で上書きできる
setopt noclobber

# キーバインド無効
bindkey -r '^J'
bindkey -r '^O'
