#!/usr/bin/env bash
#
# Ready for several things to setup emacs.
# assume that this runs on macOS.
#
set -e

PROGRAM="${BASH_SOURCE:-$0}"
HERE="$(cd -P "$(dirname "$PROGRAM")" && pwd -P)"


print_setup_banner() {
  if [[ "$1" =~ ^setup_* ]]; then
    echo "==> $1"
  fi
}

trap 'print_setup_banner "$BASH_COMMAND"' DEBUG


### utils ###

error() {
  if [ $# -eq 0 ]; then cat -
  else printf "%b\n" "$*"
  fi
} >&2

abort() {
  error "ERROR: $@" &&  exit 1
} >&2


configure_profile() {
  local HERE="$(cd -P "$(dirname "${BASH_SOURCE:-$0}")" && pwd -P)"
  local BASH_PROFILE=~/.bash_profile
  local ident="$(/bin/date +%s)"
  local temporary_file="$BASH_PROFILE.$ident"
  local tag="$1"
  shift
  sed -e "/### start ${tag}/,/### end ${tag}/d" "$BASH_PROFILE" > "$temporary_file"
  cat <<EOS >> "$temporary_file"
### start ${tag}
$(printf "%s\n" "$@")
### end ${tag}
EOS
  if [ $? -ne 0 ]; then
    echo "error: failed to write setting into '$temporary_file'" >&2
    /bin/rm "$temporary_file"
    return 1
  fi
  mv "$temporary_file" "$BASH_PROFILE"
  if [ $? -ne 0 ]; then
    echo "error: failed to mv $temporary_file to $BASH_PROFILE'" >&2
    /bin/rm "$temporary_file"
    return 1
  fi
  source "$BASH_PROFILE"
}


### setup functions ###

setup_libraries() {
  brew install cmigemo --HEAD ||:
  brew install the_silver_searcher ||:
}

setup_go() {
  which go &> /dev/null
  if [ $? -ne 0 ]; then
    abort "go not found"
  fi
  (
    cd ~/
    export GO111MODULE=on
    go get golang.org/x/tools/gopls@latest
    go get golang.org/x/tools/cmd/goimports
  ) || abort "failed to go get"
  configure_profile "go" \
                    'export PATH=/usr/local/go/bin:~/.go/bin:$PATH'
}

setup_emacs() {
  mkdir -p "$HOME"/.emacs.d
  (
    cd "$HOME"/.emacs.d
    mkdir -p snippets templates inits backups
  )
}


### main ###

setup_go
setup_libraries
setup_emacs
