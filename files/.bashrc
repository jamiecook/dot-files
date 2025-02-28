#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Homebrew stuff (for Mac OS/X) - this has to be before the aliases so that we can do things like [ `which ack` ] in there
[ -d ~/.homebrew/bin ] && PATH=~/.homebrew/bin:$PATH

# Alias definitions.
source ~/.aliases/commands.sh
source_directory ~/.aliases
source_if_exists ~/.bash_aliases
source_if_exists ~/.bash_functions

# Search your history
bind "\C-p":history-search-backward
bind "\C-n":history-search-forward
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="history*:fg:bg:vim"
export HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s histappend
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ `uname -s` == 'Linux' ]; then
    source_if_exists ./etc/bash_completion
else # I guess this is Mac OS/X
    source_if_exists /opt/local/etc/bash_completion
fi
source_directory ~/.bash_completion.d
source_if_exists ~/.bash_prompt

# Amazon EC2 stuff
for i in ~/.ec2rc; do source_if_exists $i; done

# Ruby Stuff -----------------------------------------------------------
which brew > /dev/null
if [[ $? == 0 ]]; then
    source_if_exists $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source_if_exists $(brew --prefix)/opt/chruby/share/chruby/auto.sh
fi
# END: Ruby Stuff ------------------------------------------------------

# Node/NVM Stuff
export NVM_DIR="$HOME/.nvm"
source_if_exists /usr/local/opt/nvm/nvm.sh
source_if_exists /usr/local/opt/nvm/etc/bash_completion
source_if_exists /usr/local/opt/nvm/etc/bash_completion.d/nvm
source_if_exists $NVM_DIR/bash_completion
[[ -d "$HOME/.yarn" ]] && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Python Stuff
if [[ -d ${HOME}/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  [[ -d ~/.pyenv/shims ]] && export PATH=$PATH:~/.pyenv/shims

  eval "$(pyenv init --path)" || true
  eval "$(pyenv init -)" || true
  eval "$(pyenv virtualenv-init -)" || true
fi

# Haskell binaries on the path please
[ -d ~/Library/Haskell/bin ] && PATH=$PATH:~/Library/Haskell/bin
[ -d ~/.local/bin ] && PATH=$PATH:~/.local/bin
[ -f ~/.cargo/env ] && . "$HOME/.cargo/env"

# If batcat is installed... use it instead of cat
which batcat > /dev/null 2>&1 && alias cat=$(which batcat)

# Export all the things we've set up above
export EDITOR=vim
export FIGNORE="CVS:.swp:.svn"
export PATH=$PATH:~/bin
export LD_LIBRARY_PATH
export LANG=en_AU.UTF-8 # Setup the LANG so that gcc doesn't spit a^ characters instead of '
export CIRCLE_API_TOKEN=f9c0f57d80044e8776a53f124a60bf0809cf8fe1
export BAT_THEME=OneHalfLight
export PACKAGE_ACCESS_TOKEN=8WyjTqkDa4uj3-rfiomm

# Allow gistit to post gists as jamiecook
export GISTIT_TOKEN="5522c05955ac0cbf22c8c73c26b7c51fdc4783a2"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true
