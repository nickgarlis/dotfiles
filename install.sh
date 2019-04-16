#!/bin/sh

set -e

# TODO: Create backups
rm -rf ~/.config/nvim

# Install nvim (and its dependencies: pip3, git), Python 3 and ctags (for tagbar)
echo -e '[*] App installing Neovim and its dependencies (Python 3 and git), and dependencies for tagbar (exuberant-ctags) ...\e[2m'
sudo pacman -S --needed --noconfirm neovim python3 python-pip git ctags xclip
echo -e '\e[0m\c'

# Install virtualenv to containerize Neovim dependencies
echo '[*] Pip installing virtualenv to containerize Neovim dependencies (instead of installing them onto your system) ...'
python3 -m pip install virtualenv > /dev/null
python3 -m virtualenv -p python3 ~/.config/nvim/env > /dev/null

# Install pip modules for Neovim within the virtual environment created
echo '[*] Activating virtualenv and pip installing Neovim (for Python plugin support), libraries for async autocompletion support (jedi, psutil, setproctitle) ...'
source ~/.config/nvim/env/bin/activate
pip install neovim jedi psutil setproctitle > /dev/null
deactivate

# Install vim-plug plugin manager
echo '[*] Downloading vim-plug, the best minimalistic vim plugin manager ...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 2>  /dev/null

# Install a nerd font for icons and a beautiful airline bar
echo "[*] Downloading patch font into ~/.local/share/fonts ..."
curl -fLo ~/.local/share/fonts/Roboto\ Mono\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf 2> /dev/null

# Install Neovim plugins using
echo -e '[*] Running :PlugInstall within nvim ...'
sed '/call plug#end/q' init.vim > ~/.config/nvim/init.vim
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall' > /dev/null
rm ~/.config/nvim/init.vim

# Copy dotfiles to their directories
echo '[*] Copying dotfiles...'
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp .zshrc ~/
cp .tmux.conf ~/

echo -e "[+] Done!"
