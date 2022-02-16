# shellcheck shell=bash

task.gen() {
	deno run --allow-read --allow-write ./scripts/parse.ts --write
}
