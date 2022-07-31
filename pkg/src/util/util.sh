# shellcheck shell=bash

term.private_util_validate_p() {
	local args_excluding_flags="$1"
	if ! shift; then core.panic 'Failed to shift'; fi

	if (($# - 1 > args_excluding_flags)); then
		core.panic 'Incorrect argument count'
	elif (($# - 1 == args_excluding_flags)); then
		if [[ "$1" == -p ]]; then
			flag_print='yes'
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

	if (($# - 2 == args_excluding_flags)); then
		case $1 in
			-p) flag_print='yes' ;;
			-d) end=$'\e[0m' ;;
			-pd|-dp) flag_print='yes'; end=$'\e[0m' ;;
			*) core.panic 'Invalid flag' ;;
		esac
		case $2 in
			-p)
				if [ "$flag_print" = 'yes' ]; then
					core.panic "Flag '-p' was already specified"
				fi
				flag_print='yes'
				;;
			-d)
				if [ -n "$end" ]; then
					core.panic "Flag '-d' was already specified"
				fi
				end=$'\e[0m'
				;;
			-pd|-dp)
				if [ "$flag_print" = 'yes' ]; then
					core.panic "Flag '-p' was already specified"
				fi
				if [ -n "$end" ]; then
					core.panic "Flag '-d' was already specified"
				fi
				flag_print='yes'
				end=$'\e[0m'
				;;
			*)
				core.panic 'Invalid flag'
				;;
		esac
		REPLY_SHIFT=2
	elif (($# - 1 == args_excluding_flags)); then
		case $1 in
			-p) flag_print='yes' ;;
			-d) end=$'\e[0m' ;;
			-pd|-dp) flag_print='yes'; end=$'\e[0m' ;;
			*) core.panic 'Invalid flag' ;;
		esac
		REPLY_SHIFT=1
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
		printf '%s\n' "$REPLY"
	fi
}
