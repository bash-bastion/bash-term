# shellcheck shell=bash

util.may_set_print() {
	:
}

util.may_print() {
	if [[ -v flag_print ]]; then
		# shellcheck disable=SC2059
		printf "$REPLY"
		unset -v REPLY
	fi
}
