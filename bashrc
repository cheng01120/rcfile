# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#user defined bash profile.
if [ -z $USER ]; then
	USER=`id | awk -F\( '{ print $2 }' | awk -F\) '{print $1}'`
fi

#list color output.
export PATH=/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/ccs/bin

#ls colors
#c and cpp files.
CPP="*.c=00;35:*.cpp=00;35:*.h=00;35:*.hpp=00;35:*.cc=00;35"
PERL="*.pl=00;91:*.pm=00;91"
export LS_COLORS="no=00:fi=00:di=00;37:ex=00;31:ln=04;92:$CPP:$PERL"
if [ `uname` == "FreeBSD" ]; then
	#looking for gnuls
	if [ -z `which gnuls` ]; then
		LS="ls -FG"
	else
		LS="gnuls -F --color=auto"
	fi
elif [ `uname` == "Linux" ]; then
	LS="ls -F --color=auto"
else
	LS="ls"
fi
alias ls="$LS"

function set_PS1() {
	username=`id | awk -F\( '{ print $2 }' | awk -F\) '{ print $1 }'`
	sign="%"
	if [ $username == "root" ] ; then
		sign="#"
	fi
	PS1="[$username@\[\033[0;35m\]`hostname -s`\[\033[00m\]:`dirs`]$sign"
}

function cd_and_list () {
	if [ $# == 0 ]; then
		builtin cd $HOME
	else
		builtin cd "$1"
	fi

	if [ $? -eq 0 ]; then
	    ls
	    set_PS1
	fi
	#ls
}
set_PS1
alias cd='cd_and_list'  #change dir and list

#vi style command line editor.
set -o vi   
set history 1000
export EDITOR=vim
export PAGER=less
#history search(up/down)
#bind '"\e[A":history-search-backward'
#bind '"\e[B":history-search-forward'
bind 'C-k:history-search-backward'
bind 'C-j:history-search-forward' 
#bind '"\x1b\x5b\x41":history-search-backward'
#bind '"\x1b\x5b\x42":history-search-forward' 
set show-all-if-ambiguous on
set completion-ignore-case on 
export LC_ALL=C
alias dir="ls -lh"

export PATH=/usr/local/gcc-arm-none-eabi-6-2017-q2-update/bin:$PATH
