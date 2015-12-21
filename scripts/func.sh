#!/usr/bin/env bash

# Text color
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "${ncolors}" ] && [ "${ncolors}" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BOLD=""
  NORMAL=""
fi

msg() { echo -e "${GREEN}--- $@${NORMAL}" 1>&2; }
warn() { echo -e "${YELLOW}${BOLD}--> $@${NORMAL}" 1>&2; }
err() { echo -e "${RED}${BOLD}*** $@${NORMAL}" 1>&2; }
detail() { echo -e "	$@" 1>&2; }
verlte() {
  [ "$1" = `echo -e "$1\n$2" | sort -t '.' -k 1,1n -k 2,2n -k 3,3n -k 4,4n | head -n1` ]
}

system_type() {
  local platform
  case ${OSTYPE} in
    linux* ) platform="LINUX" ;;
    darwin* ) platform="OSX" ;;
    cygwin* ) platform="CYGWIN" ;;
    * ) platform="OTHER" ;;
  esac

  echo ${platform}
  return 0
}

config_home() {
  local cfg_home
  if [ -z ${XDG_CONFIG_HOME+x} ]; then
    cfg_home="${HOME}/.config"
  else
    cfg_home=${XDG_CONFIG_HOME}
  fi

  echo ${cfg_home}
  return 0
}

package_manager() {
  local package_manager

  if command -v brew >/dev/null 2>&1 ; then
    package_manager="BREW"
  elif command -v dnf >/dev/null 2>&1 ; then
    package_manager="DNF"
  elif command -v yum >/dev/null 2>&1 ; then
    package_manager="YUM"
  elif command -v apt-get >/dev/null 2>&1 ; then
    package_manager="APT"
  else
    package_manager="OTHER"
  fi

  echo ${package_manager}
  return 0
}

check_exist() {
  local not_exist=()
  for prg; do
    if ! command -v ${prg} >/dev/null 2>&1; then
      not_exist+=("${prg}")
    fi
  done
  echo ${not_exist[@]}
  return ${#not_exist[@]}
}

exit_err() {
  err ${1}
  exit 1
}

