alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else
    colorflag="-G"
fi

alias ll='ls -lh $colorflag'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h -c'

#---------------------------------------------------------------------------
# git aliases
#---------------------------------------------------------------------------
alias gs='git status --untracked-files=no'
alias gsu='git status --untracked-files=normal'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpr='git pull -r'
alias gpull='git pull'
alias gc='git checkout'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(normal)%h%C(reset) %C(dim white)- %an (%ar) -%C(reset) %C(normal)%s%C(reset) %C(bold normal)%d%C(reset)' --all"

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
alias copy='xclip -sel clip'
