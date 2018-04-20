# Configure git to use vim as diff tool.
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

# pretty log with relative dates and authors.
git config --global alias.ll "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ai)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
