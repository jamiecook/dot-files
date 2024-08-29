#!/bin/bash 

set -eu

main() {
  cd

  if [[ ! -d "${HOME}/.dot-files" ]]
  then
    git clone https://github.com/jamiecook/dot-files.git ~/.dot-files
  fi

  ls -1d --color=none ~/.dot-files/files/* ~/.dot-files/files/.* | while read src; do
    local bname=$(basename ${src})
    local dest=~/${bname}

    # Skip .git and special dirs
    ([ "$bname" == '.' ] || [ "$bname" == '..' ] || [ "$bname" == '.git' ]) && continue

    if [[ -e "${dest}" ]]; then
      echo "skipping ${dest} - already exists"
    else
      ln -vsF "${src}" "${dest}"
    fi
  done
}


main "$@"
