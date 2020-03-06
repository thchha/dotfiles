# Prerequisites

nvim -- version < 0.5.410
ccls installed on path
lua-language-server in $HOME/programs/lua-language-server 
> referencing https://github.com/sumneko/lua-language-server

# configuration structure
managed by GNU stow

1. clone repository

change into dir

type stow <package_name>

> the first dir equals the package_name. the link will be created in the home-dir
> one can specify different directory with -t <dir>

```
stow -t /root root
```

#bash specifics

 Debian | ArchLinux |
|--|--|
.profile | .bash_profile |

