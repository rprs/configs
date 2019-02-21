# General use
sudo apt install vlc
sudo apt install feh
sudo apt install python-bs4
sudo apt install blueman # For bluetooth

# For vim plugins.
sudo apt install silversearcher-ag
# fzf has its own install executable inside the plugin path.
.vim/vim-addons/github-junegunn-fzf/install
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

# Pytest for writing test on python
pip install -U pytest --user

# Install pylint for linting python files.
sudo apt install pylint

# Adding the right dimensions to chrome remote desktop
echo 'export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="2000x1333"' >> ~/.profile 
