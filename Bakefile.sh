# shellcheck shell=bash

task.test() {
	bats tests
}

task.format() {
	shfmt -w -ln bash -sr ./pkg ./Bakefile.sh
}

task.lint() {
	shellcheck ./pkg/**/*.sh
}

task.docs() {
	shdoc < './pkg/src/public/bash-term.sh' > './docs/bash-term.md'
}
