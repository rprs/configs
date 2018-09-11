#!/bin/bash

# Copy apple swift repo from github.
mkdir swift-tmp
git clone https://github.com/apple/swift.git swift-tmp/

# Copy the vim files.
cp -r swift-tmp/utils/vim/ftdetect ~/.vim/
cp -r swift-tmp/utils/vim/ftplugin ~/.vim/
cp -r  swift-tmp/utils/vim/syntax ~/.vim/

# Remove apple swift repo. We got what we wanted.
rm -rf swift-tmp/
