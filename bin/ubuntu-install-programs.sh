# General use
sudo apt install vlc
sudo apt install feh
sudo apt install python-bs4

# For vim plugins.
sudo apt install silversearcher-ag
sudo apt install fzf
sudo apt install cscope
sudo apt install python-pip
pip install pycscope
pip install --upgrade pip

# Vim YouCompleteMe plugin dependencies
sudo apt install build-essential cmake
sudo apt install python-dev python3-dev
sudo apt install mono-xbuild
sudo apt install golang-go

# Instaling YouCompleteMe plugin
cd ~/.vim/vim-addons/github-Valloric-YouCompleteMe/
./install.py --clang-completer --cs-completer --go-completer --java-completer
