alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else
    colorflag="-G"
fi


#---------------------------------------------------------------------------
# modern shell command replacements (check if installed for each)
#---------------------------------------------------------------------------
if ! command -v exa &> /dev/null
then
    alias ll='ls -lh $colorflag'
else
    alias l='exa --icons'
    alias ll='exa -l --icons'
    alias llt='exa -l --icons --sort time'
fi

alias bcat='batcat'

alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'
alias update='sudo apt update && sudo apt upgrade'

#---------------------------------------------------------------------------
# git aliases
#---------------------------------------------------------------------------
alias gs='git status --untracked-files=no'
alias gsu='git status --untracked-files=normal'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpr='git pull -r'
alias gprs='git stash; git pull -r; git stash apply'
alias gpull='git pull'
alias gc='git checkout'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(normal)%h%C(reset) %C(dim white)- %an (%ar) -%C(reset) %C(normal)%s%C(reset) %C(bold normal)%d%C(reset)' --all"
alias cdgr='cd $(git rev-parse --show-toplevel)' # cd to current git root directory

#---------------------------------------------------------------------------
# Cmake aliases
#---------------------------------------------------------------------------
alias deb='cmake -DCMAKE_BUILD_TYPE=DEBUG ..'
alias rel='cmake -DCMAKE_BUILD_TYPE=RELEASE ..'
alias reldeb='cmake -DCMAKE_BUILD_TYPE=RELWITHDEBINFO ..'
alias asan='cmake -DCMAKE_BUILD_TYPE=ASAN ..'

# Oftenly used programs aliases
alias v='nvim'
alias o='okular'
alias c='clear'
alias m='make'
alias copy='xclip -sel clip'
alias p2='python2'
alias p3='python3'
alias n='nautilus'
alias gc='gcalcli' # google calendar cli
alias gcw='gcalcli calw' # google calendar cli


#---------------------------------------------------------------------------
# Docker aliases
#---------------------------------------------------------------------------
alias dcl='docker container ls'
alias dcla='docker container ls -a'

