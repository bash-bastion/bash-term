#!/usr/bin/env bats

load './util/init.sh'

@test "Outputs 'woofers!'" {
	run echo 'woofers!'

	[ "$status" -eq 0 ]
	[ "$output" = "woofers!" ]
}
