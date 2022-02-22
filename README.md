# bash-tty

`tput` is slow as a dog due to subshell and exec overhead. Use functions like `tty.clear_screen` instead

## Installation

Use [Basalt](https://github.com/hyperupcall/basalt), a Bash package manager, to add this project as a dependency

```sh
basalt add 'hyperupcall/bash-tty'
```

## Roadmap

- Add layer that accepts same strings are `tput`

## References

- [vtasni.html](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm)
- [asnci-escapes](https://github.com/sindresorhus/ansi-escapes/blob/main/index.js)
