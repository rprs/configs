#!/bin/bash

# This script grabs the vim files in the github repo for Swift:
# https://github.com/apple/swift.git
# There is a ftplugin file, but we don't seem to need it.

# Creates the directories where we will put the files.
mkdir ~/.vim/syntax
mkdir ~/.vim/ftdetect

# Copy ftdetect files.
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/ftdetect/sil.vim > ~/.vim/ftdetect/sil.vim
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/ftdetect/swift.vim > ~/.vim/ftdetect/swift.vim
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/ftdetect/swiftgyb.vim > ~/.vim/ftdetect/swiftgyb.vim

# Copy syntax files.
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/syntax/sil.vim > ~/.vim/syntax/sil.vim
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/syntax/swift.vim > ~/.vim/syntax/swift.vim
curl https://raw.githubusercontent.com/apple/swift/master/utils/vim/syntax/swiftgyb.vim > ~/.vim/syntax/swiftgyb.vim
