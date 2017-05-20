#!/bin/sh

git_source=https://github.com/tanitanin/dotfiles.git
copy_dst=~/.dotfiles

log()  { printf "%b\n" "$*"; }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

dotfiles_check() {
	log "Checking required items..."
	_flg=false
	[ -d $copy_dst ] && fail ".dotfiles already exists. If udpate, use update.sh"

	#if ! type -p wget > /dev/null 2>&1 ; then
	#       	fail "wget doesn't exist."
	#fi
	if ! type -p git > /dev/null 2>&1 ; then
	       	fail "git doesn't exist. prease install git."
	fi
}

dotfiles_init() {
	log "Copy files from $git_source -> $copy_dst"
	git clone $git_source $copy_dst --recurse-submodules
	[ -d $copy_dst ] || fail "Cannot copy from $git_source"
}

dotfiles_udpate() {
	if [ -d $copy_dst/.git ]; then
		cd $copy_dst && git pull -f --recurse-submodules
	elif [ -d $copy_dst ]; then
		fail ".dotfiles exists but .git is not found."
	else
		fail ".dotfiles does not exist. Please install dotfiles."
	fi
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

dotfiles_os() {
	name=`uname -s`
	if [ "$name" == 'Darwin' ]; then
		OS='Mac'
	elif [ "$name" == 'Linux' ]; then
		OS='Linux'
	elif [ "$name" == 'CYGWIN_NT' ]; then
		OS='Cygwin'
	elif [ "$name" == 'MINGW' ]; then
		OS='MinGW'
	else
		fail "Your platform ($name) is not supported."
	fi
}

dotfiles_install() {
	[ ! -d $copy_dst/backup ] && mkdir -p $copy_dst/backup
	for dot in $copy_dst/.* $copy_dst/$OS/.* ; do
		_name=`basename $dot`
		[ "$_name" == "." ] && continue
		[ "$_name" == ".." ] && continue
		[ "$_name" == ".*" ] && continue
		[ "$_name" == ".git" ] && continue
		[ "$_name" == ".gitignore" ] && continue
		[ "$_name" == ".gitmodules" ] && continue

		[ "$dot" == "$copy_dst/$_name" -a -e $copy_dst/$OS/$_name ] && continue

		if [ -e ~/$_name ]; then
			log "move $_name to $copy_dst/backup"
			mv -f ~/$_name $copy_dst/backup/$_name
		fi
		dotfiles_link $dot ~/$_name
	done
}

dotfiles_main() {
	dotfiles_check
	dotfiles_init
	dotfiles_install
	#dotfiles_update
}

dotfiles_main $@


