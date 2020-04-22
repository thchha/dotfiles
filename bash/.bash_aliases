#!/bin/sh
#my custom aliases
alias ll='ls -la'
alias evince='evince -f'
alias note='qn notes general'
alias notecat='cat ~/workspace/projects/notes/general'
alias noteedit='vim ~/workspace/projects/notes/general'
alias mtiny='sshfs raptom@BERRYRakete:/home/raptom/storage/tiny/ ~/storage/tinyremote/'
alias utiny='fusermount -u /home/tomes/storage/tinyremote'
alias path_android='PATH=$PATH:~/runenv/android/platform-tools/'
alias path_gradle='PATH=$PATH:~/.gradle/'
alias project_save='/home/tomes/bin/zeiterf_logout.lua'
alias project_login='/home/tomes/bin/zeiterf_login.lua'
alias ztin='zeiterf_in'
alias ztout='zeiterf_out'

junk() { mv "$@" ~/.local/share/Trash/files; }
zeiterf_in() { /home/tomes/workspace/lua/zeiterfassung/login.lua "$@"; }
zeiterf_out() { /home/tomes/workspace/lua/zeiterfassung/logout.lua "$@"; }
