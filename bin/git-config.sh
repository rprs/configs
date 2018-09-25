# General
git config --global alias.st status
# Configure git to use vim as diff tool.
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool

# List files not tracked.
git config --global alias.nothave "ls-files . --ignored --exclude-standard --others"
# pretty log with relative dates and authors.
git config --global alias.l "log --date=short-local --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(bold yellow)%d%C(reset)' --all"
git config --global alias.ll "log --graph --date=short-local --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
git config --global alias.lll "log --graph --date=format-local:'%a %F %R' --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
