# Prerequisites

nvim nightly.

lanugage servers: ccls, lua, kotlin-language-server

# configuration structure
managed by GNU stow

1. clone repository

2. change into repo
> the first dir equals the package_name. the link will be created in the home-dir
> one can specify different directory with -t <dir>
```
stow -t /root root
```
 
3. type `stow <package_name>`

`stow -D <package_name>` removes the created symlinks and therefore disables the linking.


# bash specifics

Note that one has to refer to its distribution for the correct naming of files.

 Debian | ArchLinux |
|--|--|
.profile | .bash_profile |

