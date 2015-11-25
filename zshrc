# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export EDITOR="vim"
export TERM='xterm-256color'

ZSH_THEME="terminalparty"

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias status="git status -s"
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias svn=~/dotfiles/svn/svn-color.py
alias svnlog="svn log -l 10"
alias svnstats="svn diff -x --ignore-eol-style -x -w  |diffstat"

# Git
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
export GIT_EDITOR=nvim  

# Plugins
plugins=(git git-extras github bower colorize brew node svn svn-fastinfo)

source $ZSH/oh-my-zsh.sh

# Path
export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin
