# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "$(dircolors)"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'


force_color_prompt=yes
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]$(date +\%Y-\%m-\%d \%H:\%M:\%S)\[\033[00m\] \[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;33m\]\h \[\033[38;5;214m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
