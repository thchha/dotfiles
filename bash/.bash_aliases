#!/bin/sh
alias ll='ls -la'
alias ztin='zeiterf_in'
alias ztout='zeiterf_out'
alias ztpop='notify-send -t 5000 "$(/home/tomes/workspace/lua/zeiterfassung/zeiterfassung_shell_prompt.lua)"'

zeiterf_in() { /home/tomes/workspace/lua/zeiterfassung/login.lua "$@"; }
zeiterf_out() { /home/tomes/workspace/lua/zeiterfassung/logout.lua "$@"; }

junk() { mv "$@" ~/.local/share/Trash/files; }
