#!/bin/sh
#my custom aliases
alias ll='ls -la'
alias note='qn notes general'
alias path_android='PATH=$PATH:~/runenv/android/platform-tools/'
alias path_gradle='PATH=$PATH:~/.gradle/'
alias ztin='zeiterf_in'
alias ztout='zeiterf_out'
alias ztpop='notify-send -t 5000 "$(/home/tomes/workspace/lua/zeiterfassung/zeiterfassung_shell_prompt.lua)"'
alias vlime='sbcl --load ~/dotfiles/nvim/.local/share/nvim/site/pack/git-plugins/start/vlime/lisp/start-vlime.lisp'

zeiterf_in() { /home/tomes/workspace/lua/zeiterfassung/login.lua "$@"; }
zeiterf_out() { /home/tomes/workspace/lua/zeiterfassung/logout.lua "$@"; }

junk() { mv "$@" ~/.local/share/Trash/files; }
