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

> beware linking with *, since when there is an error, rm * will remove every file in current dir. 


```.taskrc```
Taskwarrior

```rt/```
for root-dir

```usr/```
for usr-dir

bash specifics
Debian | ArchLinux |
.profile | .bash_profile |

