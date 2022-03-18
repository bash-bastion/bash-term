# shellcheck shell=bash

# TODO
# https://wiki.bash-hackers.org/scripting/terminalcodes
# https://stackoverflow.com/a/20983251

bty() {
	unset REPLY

	case $1 in
		# controlling cursor
		sc) ;;
		rc) ;;
		home) ;;
		cup) ;;
		cud1) ;;
		cuu1) ;;
		civis) ;;
		cnorm) ;;

		# terminal attributes
		longname) ;;
		lines) ;;
		cols) ;;
		colors) ;;

		# text effects
		bold) ;;
		smul) ;;
		rmul) ;;
		rev) ;;
		blink) ;;
		invis) ;;
		smso) ;;
		rmso) ;;
		sgr0) ;;
		setaf)
			case $2 in
				[0-9]) ;;
				*) ;;
			esac
			;;
		setab)
			case $2 in
				[0-9]) ;;
				*) ;;
			esac
			;;
		dim) ;;

		# clearing screen'
		smcup) ;;
		rmcup) ;;
		el) tty.erase_line_end ;;
		el1) tty.erase_line_start ;;
		el2) tty.erase_line ;;
		clear) ;;
		*)

			return
	esac

	# shellcheck disable=SC2059
	printf "$REPLY"
}
