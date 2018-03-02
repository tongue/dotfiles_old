# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export EDITOR="nvim"
export TERM='xterm-256color'

# ZSH_THEME="terminalparty"
ZSH_THEME="avit"

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias status="git status -s"
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias linesofcode="find . -name '*.*' | xargs wc -l"

# Dscript
alias ds="./dscript.sh"

# SVN
alias svn=~/dotfiles/svn/svn-color.py
alias svnlog="svn log -l 10"
alias svnstats="svn diff -x --ignore-eol-style -x -w  |diffstat"
#export SVN_EDITOR='nvim -c "4,\$!cut -c-5 --complement | xargs svn diff --no-diff-deleted -x --ignore-eol-style" -c "set syntax=diff" +0'

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

alias gs="git status"
alias gl="git log --oneline --decorate --max-count=20"
alias gla="git la"
alias glas="git la --simplify-by-decoration"
alias gco="git co"
alias nb="git nb"
alias nfb="nff"
alias gca="git commit -am"
alias gb="git branch"
alias gbo="git branch -va --sort=-committerdate --abbrev"  k
export GIT_EDITOR=nvim

alias or="open-jira"

# Functions
function nff() {
   if [ -z "$1" ]; then
      echo "no branch number provided"
      return
   fi
   git checkout -b feature/DK-$1
}

function lgr() {

   la | grep "$1"

}

function ggo() {
   # are we in a git repo?
   git rev-parse --is-inside-work-tree &>/dev/null

   if [[ $? != 0 ]]; then
     echo "Not a git repository."
     return
   fi

   giturl=$(git config --get "remote.origin.url")
   branch=$(git symbolic-ref -q --short HEAD)
   gitlab_domain="git.isotop.ad"

   giturl=${giturl/git\@${gitlab_domain}:/${gitlab_domain}/}
   giturl=${giturl%\.git}
   giturl=${giturl}/tree/${branch}
   start "http://$giturl" &> /dev/null
}

function open-jira() {
	# are we in a git repo?
	git rev-parse --is-inside-work-tree &>/dev/null

	if [[ $? != 0 ]]; then
		echo "Not a git repository."
		return
	fi
	baseurl="https://jira.isotop.se/browse/"
	branch=$(git symbolic-ref -q --short HEAD)
	jiraurl=$(echo $branch | grep -o "DK-[0-9]*")
	if [[ $jiraurl != 0 ]]; then 
		url="$baseurl$jiraurl"
	else
		url="$baseurl"
	fi
	start "$url" &> /dev/null
}

function findbyport() {
	sudo lsof -i :$1
}

# Plugins
plugins=(git git-extras github bower colorize brew node svn svn-fastinfo)

source $ZSH/oh-my-zsh.sh

# Path
export ANDROID_HOME=/usr/local/share/android-sdk
export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin
export LC_ALL="en_US.UTF-8"

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
