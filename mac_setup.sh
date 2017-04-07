#!/bin/bash

# Homebrewのインストール
if ! type brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# gitから設定ファイルをclone
if ! type git >/dev/null 2>&1; then
    brew install git
fi
git clone https://github.com/bayguh/dotfiles.git ~/dotfiles

# 設定ファイルフォルダに移動
cd ~/dotfiles
# bundleインストール
brew tap Homebrew/bundle
# アプリインストール
brew bundle

##################################################################

# dotfileの設定
sh ~/dotfiles/dotfile_setup.sh

# zshをシェルリストに追加
sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# デフォルトシェルをzshに変更
chsh -s /usr/local/bin/zsh

# fzfをインストール
sh /usr/local/opt/fzf/install

# gcloud補完設定
if [ ! -f .config/gcloud/gcloud-zsh-completion ]; then
    mkdir -p  ~/.config/gcloud
    git clone https://github.com/littleq0903/gcloud-zsh-completion.git ~/.config/gcloud/gcloud-zsh-completion
fi

# font Rictyの設定
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

# vimのプラグインlightlineでRictyを使う
git clone https://github.com/Lokaltog/vim-powerline.git /tmp/vim-powerline
fontforge -lang=py -script /tmp/vim-powerline/fontpatcher/fontpatcher ~/Library/Fonts/Ricty-Regular.ttf
fontforge -lang=py -script /tmp/vim-powerline/fontpatcher/fontpatcher ~/Library/Fonts/Ricty-Bold.ttf
mv Ricty-Regular-Powerline.ttf ~/Library/Fonts/
mv Ricty-Bold-Powerline.ttf ~/Library/Fonts/
rm -rf /tmp/vim-powerline
fc-cache -fv

# neovimでpython3を使えるように設定
pip3 install --user --upgrade neovim

# finderで隠しファイルの表示
defaults write com.apple.finder AppleShowAllFiles TRUE
