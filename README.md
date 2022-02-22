# bash-tty

`tput` is slow as a dog. Terminfo database from ncurses version `6.3`

## Installation

Use [Basalt](https://github.com/hyperupcall/basalt), a Bash package manager, to add this project as a dependency

```sh
basalt add 'hyperupcall/bash-tty'
```

## Roadmap

- Handle terminal attributes with formatting
- Dont codegen for terminals older than your mother

## References

- [vtasni.html](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm)
- [asnci-escapes](https://github.com/sindresorhus/ansi-escapes/blob/main/index.js)
