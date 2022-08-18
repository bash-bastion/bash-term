# shellcheck shell=bash

term.private_util_validate_p() {
	local args_excluding_flags="$1"
	if ! shift; then core.panic 'Failed to shift'; fi

	if (($# - 1 > args_excluding_flags)); then
		core.panic 'Incorrect argument count'
	elif (($# - 1 == args_excluding_flags)); then
		if [[ $1 == -?(@(p|P)) ]]; then
			case $1 in
				*p*) flag_print='yes' ;;
				*P*) flag_print='yes-big' ;;
			esac
			REPLY_SHIFT=1
		else
			core.panic 'Invalid flag'
		fi
	else
		REPLY_SHIFT=0
	fi

}

term.private_util_validate_pd() {
	local args_excluding_flags="$1"
	if ! shift; then core.panic 'Failed to shift'; fi

	if (($# - 1 == args_excluding_flags)); then
		if [[ $1 == -?(d|@(p|P)|d@(p|P)|@(p|P)d) ]]; then
			case $1 in
				*p*) flag_print='yes' ;;
				*P*) flag_print='yes-newline' ;;
			esac
			if [[ $1 == *d* ]]; then
				end=$'\e[0m'
			fi
			REPLY_SHIFT=1
		else
			core.panic 'Invalid flag'
		fi
	elif (($# > args_excluding_flags)); then
		core.panic 'Incorrect argument count'
	else
		REPLY_SHIFT=0
	fi
}

term.private_util_set_reply() {
	local flag_print="$1"
	local value="$2"

	REPLY="$value"
	if [ "$flag_print" = 'yes' ]; then
		printf '%s' "$REPLY"
	elif [ "$flag_print" = 'yes-newline' ]; then
		printf '%s\n' "$REPLY"
	fi
}

term.private_util_set_reply2() {
	local flag_print="$1"

	if ! shift; then
		core.panic 'Failed to shift'
	fi

	# shellcheck disable=SC2059
	printf -v REPLY "$@"
	if [ "$flag_print" = 'yes' ]; then
		printf '%s' "$REPLY"
	elif [ "$flag_print" = 'yes-newline' ]; then
		printf '%s\n' "$REPLY"
	fi
}
