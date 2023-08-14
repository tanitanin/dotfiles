
#------------------------------------------------------------------------------
# .zshrc
#------------------------------------------------------------------------------

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Set up the prompt
autoload -Uz promptinit
promptinit
#prompt adam1

# Unset beep
unsetopt beep

# History Options
setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# vi key config
# bindkey -v

# zsh-completions settings
# if [ -e /usr/local/share/zsh-completions ]; then
#     fpath=(/usr/local/share/zsh-completions $fpath)
# fi
# autoload -U compinit
# compinit -u

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Use colors
autoload -Uz colors
colors

#------------------------------------------------------------------------------
# Version Control System
#------------------------------------------------------------------------------

# Use version control systems
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd_exec_vcsinfo () { vcs_info }

# Hook precmd_exec_vcsinfo to precmd
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_exec_vcsinfo

# Use .zsh folder for fpath
[[ -s "${HOME}/.zsh" ]] || mkdir "${HOME}/.zsh"
fpath=("${HOME}/.zsh" $fpath)

# Use git-prompt and git-completion
if [[ ! -s "${HOME}/.zsh/.git-prompt.sh" ]]; then
  curl -o "${HOME}/.zsh/.git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi
source "${HOME}/.zsh/.git-prompt.sh"

if [[ ! -s "${HOME}/.zsh/_git" ]]; then
  curl -o "${HOME}/.zsh/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash

autoload -Uz compinit
compinit

# git branch settings
if type __git_ps1 > /dev/null 2>&1 ; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=auto
fi

#------------------------------------------------------------------------------
# Prompt settings
#------------------------------------------------------------------------------

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    DISABLE_AUTO_TITLE=true
    #PS1_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}%n@%m:%~\a'
    precmd_exec_title () { print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m:%~\a" }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd precmd_exec_title
    ;;
*)
    ;;
esac

# set prompt
setopt prompt_subst
export PS1='%n@%m:%~ %K{118}%f%F{250}%f%F{016}%{$(__git_ps1 "[%s]")%f%k%F{118}%f$'

#------------------------------------------------------------------------------
# Path settings
#------------------------------------------------------------------------------

# NVM
if ! [ -s "$HOME/.nvm" ]; then
  unset NVM_DIR
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn global bin path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
if !! [ which yarn &> /dev/null ]; then
  export PATH=$(yarn global bin):$PATH
fi

# pyenv
export PYENV_ROOT=$HOME/.pyenv
if !! [ which pyenv &> /dev/null ]; then
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

#------------------------------------------------------------------------------
# Append from .bashrc
#------------------------------------------------------------------------------

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

#------------------------------------------------------------------------------
