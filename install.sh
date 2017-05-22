#!/bin/sh

git_source=https://github.com/tanitanin/dotfiles.git
copy_dst=~/.dotfiles

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

dotfiles_check() {
  log "Checking required items..."
  _flg=false
  update_flg=false
  if [ -d $copy_dst ]; then
    log ".dotfiles already exists."
    update_flg=true
  fi

  #if ! type -p wget > /dev/null 2>&1 ; then
  #         fail "wget doesn't exist."
  #fi
  if [ ! `type -p git > /dev/null 2>&1` = 0 ] ; then
    fail "git doesn't exist. prease install git."
  fi
}

dotfiles_init() {
  log "Copy files from $git_source -> $copy_dst"
  git clone $git_source $copy_dst --recurse-submodules
  [ -d $copy_dst ] || fail "Cannot copy from $git_source"
}

dotfiles_check_install() {
  _name=$1
  [ "$_name" = "." ] && return 1
  [ "$_name" = ".." ] && return 1
  [ "$_name" = ".*" ] && return 1
  [ "$_name" = ".git" ] && return 1
  [ "$_name" = ".gitignore" ] && return 1
  [ "$_name" = ".gitmodules" ] && return 1
  return 0
}

dotfiles_link() {
  _src=$1
  _dst=$2
  if [ -e $_dst ]; then
    log "$_dst already exists. move backup. link $_src -> $_dst."
    mv -f $_dst $_dst.backup
    ln -s $_src $_dst
  else
    log "link $_src -> $_dst"
    ln -s $_src $_dst
  fi
}

dotfiles_update_link() {
  for dot in $copy_dst/.* $copy_dst/$OS/.* ; do
     _name=`basename $dot`
    dotfiles_check_install $_name
    [ $? -ne 0 ] && continue

    [ "$dot" = "$copy_dst/$_name" ] && [ -e "$copy_dst/$OS/$_name" ] && continue

    if [ -h ~/$_name ]; then
      log "delete symbolic link ~/$_name"
      rm -rf ~/$_name
    fi

    if [ -e ~/$_name ]; then
      log "move $_name to $copy_dst/backup"
      mv -f ~/$_name $copy_dst/backup/$_name
    fi
    dotfiles_link $dot ~/$_name
  done
}

dotfiles_update() {
  if [ $update_flg ]; then
    log "Run update."
    if [ -d $copy_dst/.git ]; then
      cd $copy_dst && git pull -f --recurse-submodules
      dotfiles_update_link
    elif [ -d $copy_dst ]; then
      fail ".dotfiles exists but .git is not found."
    else
      fail ".dotfiles does not exist. Please install dotfiles."
    fi
  else
    log "Update is skip."
  fi
}

dotfiles_distinguish_os() {
  name_s=`uname -s`
  name_o=`uname -o`
  OS='unknown'
  if [ "$name_s" = 'Darwin' ]; then
    OS='Mac'
  elif [ "$name_s" = 'Linux' ]; then
    OS='Linux'
  elif [ "$name_o" = 'Cygwin' ]; then
    OS='Cygwin'
  elif [ "$name_o" = 'MINGW' ]; then
    OS='MinGW'
  fi
  if [ $OS = 'unknown' ]; then
    fail "Your platform (`uname -a`) is not supported."
  else
    log "OS is $OS"
  fi
}

dotfiles_install() {
  if [ ! $update_flg ]; then
    [ ! -d $copy_dst/backup ] && mkdir -p $copy_dst/backup
    for dot in $copy_dst/.* $copy_dst/$OS/.* ; do
      _name=`basename $dot`
      dotfiles_check_isntall $_name
      [ $? -ne 0 ] && continue

      [ "$dot" = "$copy_dst/$_name" -a -e $copy_dst/$OS/$_name ] && continue

      if [ -e ~/$_name ]; then
        log "move $_name to $copy_dst/backup"
        mv -f ~/$_name $copy_dst/backup/$_name
      fi
      dotfiles_link $dot ~/$_name
    done
  else
    log "Skip install."
  fi
}

dotfiles_main() {
  dotfiles_check
  dotfiles_init
  dotfiles_distinguish_os
  dotfiles_install
  dotfiles_update
}

dotfiles_main $@


