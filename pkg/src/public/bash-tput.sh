# shellcheck shell=bash

# TODO
# https://wiki.bash-hackers.org/scripting/terminalcodes
# https://stackoverflow.com/a/20983251

btput() {
	unset REPLY

	case $1 in
		# controlling cursor
		sc)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput sc
			else
				:
			fi
			;;
		rc)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput rc
			else
				:
			fi
			;;
		home)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput home
			else
				:
			fi
			;;
		cup)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput cup
			else
				:
			fi
			;;
		cud1)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput cud1
			else
				:
			fi
			;;
		cuu1)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput cuu1
			else
				:
			fi
			;;
		civis)
			tput civis
			;;
		cnorm)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput cnorm
			else
				:
			fi
			;;

		# terminal attributes
		longname) ;;
		lines) ;;
		cols) ;;
		colors) ;;

		# text effects
		bold)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput bold
			else
				:
			fi
			;;
		smul)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput smul
			else
				:
			fi
			;;
		rmul)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput rmul
			else
				:
			fi
			;;
		rev)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput rev
			else
					:
			fi
			;;
		blink)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				btput blink
			else
				:
			fi
			;;
		invis)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				itput invis
			else
				:
			fi
			;;
		smso)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput smso
			else
				:
			fi
			;;
		rmso)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput rmso
			else
				:
			fi
			;;
		sgr0)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput sgr0
			else
				:
			fi
			;;
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
		dim)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput dim
			else
				:
			fi
			;;

		# clearing screen
		smcup)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput smcup
			else
				:
			fi
			;;
		rmcup)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput rmcup
			else
				:
			fi
			;;
		el)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput el
			else
				term.erase_line_end
			fi
			;;
		el1)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput el1
			else
				term.erase_line_start
			fi
			;;
		el2)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput el2
			else
				term.erase_line
			fi
			;;
		clear)
			if [[ -v BASH_TTY_FORCE_TPUT ]]; then
				tput clear
			else
				:
			fi
			;;
		*)
			return
	esac

	if ! [[ -v BASH_TTY_FORCE_TPUT ]]; then
		# shellcheck disable=SC2059
		printf "$REPLY"
	fi
}
