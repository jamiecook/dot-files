#!/bin/bash 

set -eu

main() {
  cd

  if [[ ! -d '.dot-files' ]]
  then
    git clone https://github.com/jamiecook/dot-files.git .dot-files
  fi

  ls -1d --color=none .dot-files/files/* .dot-files/files/.* | while read f; do
    local bname=$(basename $f)
    [ "$bname" == '.' ] || [ "$bname" == '..' ] || [ "$bname" == '.git' ] || ln -vsF "$f" .
  done
}


main "$@"
