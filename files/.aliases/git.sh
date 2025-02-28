alias gs='git status -sb'
alias gl='git log --oneline --decorate'
alias gl='git l'
alias gp='git push'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias gc='git commit -v'
alias gb='git branch -v -v'
alias gba='gb -a'
alias gc.="gc -m '.'"
alias gcl="gc -m 'lint'"
alias gcm="gc -m "
alias gfo="git fetch origin --prune"
alias gch="git checkout"
alias gch-="git checkout -"

# These are awesome. Only page when necessary.
alias gdi='git --no-pager diff --staged --color | less -FXRS'
alias gd='git --no-pager diff --color | less -FXRS'
alias gdc='git diff --cached'

alias gsp='git fetch origin && git rebase --autostash -p'

