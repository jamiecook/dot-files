# Handy aliases to allow quick editing of key config files
alias ea="vim ~/.dot-files/files/.aliases/commands.sh && source ~/.dot-files/files/.aliases/commands.sh"
alias eb="vim ~/.dot-files/files/.bashrc && source ~/.dot-files/files/.bashrc"
alias ev="vim ~/.vim/vimrc ~/.vim/*.vim"
alias ed="vim ~/.dot-files/files && source ~/.bashrc"
alias ep="vim ~/.dot-files/files/.bash_prompt && source ~/.bash_prompt"
alias ec="vim ~/.dot-files/files/.aliases/colours.sh && source ~/.dot-files/files/.bashrc"
alias es="vim ~/.ssh/config"

alias ..="cd .."
alias cp="cp -i"
[ `which ack-grep` ] || alias ack='ack-grep'

alias crontab="VIM_CRONTAB=true EDITOR=vim crontab"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    # dircolors doesn't exist on mac osx
    if [ `which dircolors` ]; then eval "`dircolors -b`"; fi
    if [ `uname -s` == 'Linux' ]; then
        alias ls='ls --color=auto'
    elif [ `uname -s` == 'Darwin' ]; then
        if [ `which gls` ]; then
          # Use the core-utils version from homebrew if it's available...
          alias ls='gls --color=always'
        else
          # otherwise try to make bsd ls more usable by using linux style colouring
          export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
          alias ls='ls -G'
        fi
    fi

    alias ll='ls -l'
    alias l='ls -CF'

    [[ $(type -P "bat") ]] && alias cat=bat
fi

if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
  alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
fi
[[ $(command -v "bat") ]]    && alias cat="bat --theme ansi-light"
[[ $(command -v "batcat") ]] && alias cat="batcat --theme ansi-light"

alias vi='vim'

[[ $(command -v "uv") ]] && alias pip="uv pip"

RUBY_NUMERIC_ARRAY_STR='ruby -e "load \"~/.dot-files/stats.rb\"; p ARGF.select{|e| e =~ /^\s*[+-]?\d+[.]?\d*/ }.map { |e| e.to_f }'
alias min='ruby -e "p ARGF.select{|e| e =~ /^\s*[+-]?\d+[.]?\d*/ }.map{|e| e.to_f }.min"'
alias max='ruby -e "p ARGF.select{|e| e =~ /^\s*[+-]?\d+[.]?\d*/ }.map{|e| e.to_f }.max"'
alias sum='ruby -e "p ARGF.select{|e| e =~ /^\s*[+-]?\d+[.]?\d*/ }.map{|e| e.to_f }.inject(0.0) {|a,x| a+=x}"'
alias mean='ruby -e "tmp = ARGF.select{|e| e =~ /^\s*[+-]?\d+[.]?\d*/ }.map{|e| e.to_f }; p tmp.inject(0.0) {|a,x| a+=x} / tmp.size"'
alias var="${RUBY_NUMERIC_ARRAY_STR}.sum\""

export LESS="-R"

pbpaste() {
  powershell.exe Get-Clipboard | sed 's/\r$//' | sed -z '$ s/\n$//'
}
if $(which clip.exe &> /dev/null); then
  alias pbcopy=clip.exe
  export -f pbpaste
fi

source_if_exists()
{
  test -f $1 && source $1
}

source_directory()
{
  test -d $1 && for file in ${1}/*; do
    source $file
  done
}

c() {
  cd "$@" && ls -las
}

pol() {
  local expected_dir=${HOME}/git/anl/polarislib/venv
  if [[ ! -d "${expected_dir}" ]]; then
    echo "polarislib directory (${expected_dir}) not found"
    return
  fi

  . ${HOME}/git/anl/polarislib/venv/bin/activate
  export PATH=${HOME}/git/polarislib/bin:${PATH}
  export PYTHONPATH=${HOME}/git/polarislib
}
