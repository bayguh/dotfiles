#!/bin/bash

# 通常のドットファイルを定義
DOT_FILES=(.zshrc .sshrc .gitconfig)

# ホームディレクトリ配下にシンボリックリンクをはる
for file in ${DOT_FILES[@]}
do
    ln -sf ~/dotfiles/$file ~/$file
done

#################################################################
# vim関連                                                       #
#################################################################
# neovimの設定ファイル管理用のフォルダ作成
if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
fi

# neovimの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
# vimも同じ設定ファイルを使う
ln -sf ~/dotfiles/.config/nvim/init.vim ~/.vimrc

# vimのプラグインパッケージ管理用のフォルダ作成
if [ ! -d ~/.dein ]; then
    mkdir ~/.dein
fi

# deinの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.dein/dein.toml ~/.dein/dein.toml
ln -sf ~/dotfiles/.dein/dein_lazy.toml ~/.dein/dein_lazy.toml

#################################################################
# sshrc関連                                                     #
#################################################################
# sshrcの設定ファイル管理用のフォルダ作成
if [ ! -d ~/.sshrc.d ]; then
    mkdir ~/.sshrc.d
fi

# zshの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.zshrc ~/.sshrc.d/.zshrc
# vimの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.config/nvim/init.vim ~/.sshrc.d/.vimrc
# deinの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.dein/dein.toml ~/.sshrc.d/dein.toml
# deinの設定ファイルをシンボリックリンク化
ln -sf ~/dotfiles/.dein/dein_lazy.toml ~/.sshrc.d/dein_lazy.toml

