# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
PS1='\[\033[01;31m\] ROOT \[\033[05;37m\]@\[\033[00m\] \[\033[32m\]\h\[\033[00m\]: \w\[\033[1;37m\]$\[\033[00m\] '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# 
# custom
alias subwoofer='sh /home/tomes/runenv/linux/mSubwoofer/power-on.sh'
