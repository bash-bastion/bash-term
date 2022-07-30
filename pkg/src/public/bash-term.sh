# shellcheck shell=bash

# -------------------------------------------------------- #
#                          Cursor                          #
# -------------------------------------------------------- #

# @description Move the cursor position to a supplied row and column. Both default to `0` if not supplied
# @arg $1 int row
# @arg $1 int column
term.cursor_to() {
	unset -v REPLY
	local row="${1:-0}"
	local column="${2:-0}"

	# Note that 'f' instead of 'H' is the 'force' variant
	printf -v REPLY '\033[%s;%sH' "$row" "$column"
}

# @description Moves cursor position to a supplied _relative_ row and column. Both default to `0` if not supplied (FIXME: implement)
# @arg $1 int row
# @arg $1 int column
term.cursor_moveto() {
	:
}

# @description Moves the cursor up. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_up() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sA' "$count"
}

# @description Moves the cursor down. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_down() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sB' "$count"
}

# @description Moves the cursor forward. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_forward() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sC' "$count"
}

# @description Moves the cursor backwards. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_backward() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sD' "$count"
}

# @description Moves the cursor to the next line. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_line_next() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sE' "$count"
}

# @description Moves the cursor to the previous line. Defaults to `1` if not supplied
# @arg $1 int count
term.cursor_line_prev() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sF' "$count"
}

# FIXME: docs
# @description Moves the cursor ?
# @arg $1 int count
term.cursor_horizontal() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sG' "$count"
}

# @description Saves the current cursor position
# @noargs
term.cursor_savepos() {
	unset -v REPLY

	if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; then
		REPLY=$'\u001B7'
	else
		REPLY=$'\e[s'
	fi
}

# @description Restores cursor to the last saved position
# @noargs
term.cursor_restorepos() {
	unset -v REPLY

	if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; then
		REPLY=$'\u001B8'
	else
		REPLY=$'\e[u'
	fi
}

# FIXME: docs
# @description Saves
# @noargs
term.cursor_save() {
	unset -v REPLY

	REPLY=$'\e[7'
}

# FIXME: docs
# @description Restores
# @noargs
term.cursor_restore() {
	unset -v REPLY

	REPLY=$'\e[8'
}

# @description Hides the cursor
# @noargs
term.cursor_hide() {
	unset -v REPLY

	REPLY=$'\e[?25l'
}

# @description Shows the cursor
# @noargs
term.cursor_show() {
	unset -v REPLY

	REPLY=$'\e[?25h'
}

# @description Reports the cursor position to the application as (as though typed at the keyboard)
# @noargs
term.cursor_getpos() {
	unset -v REPLY

	REPLY=$'\e[6n'
}



# -------------------------------------------------------- #
#                           Erase                          #
# -------------------------------------------------------- #

# @description Erase from the current cursor position to the end of the current line
# @noargs
term.erase_line_end() {
	unset -v REPLY

	# Same as '\e[0K'
	REPLY=$'\e[K'
}

# @description Erase from the current cursor position to the start of the current line
# @noargs
term.erase_line_start() {
	unset -v REPLY

	REPLY=$'\e[1K'
}

# @description Erase the entire current line
# @noargs
term.erase_line() {
	unset -v REPLY

	REPLY=$'\e[2K'
}

# @description Erase the screen from the current line down to the bottom of the screen
# @noargs
term.erase_screen_end() {
	unset -v REPLY

	# Same as '\e[0J'
	REPLY=$'\e[J'
}

# @description Erase the screen from the current line up to the top of the screen
# @noargs
term.erase_screen_start() {
	unset -v REPLY

	REPLY=$'\e[1J'
}

# @description Erase the screen and move the cursor the top left position
# @noargs
term.erase_screen() {
	unset -v REPLY

	REPLY=$'\e[2J'
}

# @noargs
term.erase_saved_lines() { # TODO: better name?
	unset -v REPLY

	REPLY=$'\e[3J'
}



# -------------------------------------------------------- #
#                          Scroll                          #
# -------------------------------------------------------- #

# @noargs
term.scroll_down() {
	unset -v REPLY

	# REPLY=$'\e[T'
	REPLY=$'\e[D'
}

# @noargs
term.scroll_up() {
	unset -v REPLY

	# REPLY=$'\e[S'
	REPLY=$'\e[M'
}



# -------------------------------------------------------- #
#                            Tab                           #
# -------------------------------------------------------- #

# @noargs
term.tab_set() {
	unset -v REPLY

	REPLY=$'\e[H'
}

# @noargs
term.tab_clear() {
	unset -v REPLY

	REPLY=$'\e[g'
}

# @noargs
term.tab_clearall() {
	unset -v REPLY

	REPLY=$'\e[3g'
}



# -------------------------------------------------------- #
#                          Screen                          #
# -------------------------------------------------------- #

# @description Save screen
# @noargs
term.screen_save() {
	unset -v REPLY

	REPLY=$'\e[?1049h'
}

# @description Restore screen
# @noargs
term.screen_restore() {
	unset -v REPLY

	REPLY=$'\e[?1049l'
}



# -------------------------------------------------------- #
#                           Color                          #
# -------------------------------------------------------- #

# @description Construct reset
# @arg $1 string text
term.style_reset() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY '\e[0m%s' "$text"
}

# @description Construct bold
# @arg $1 string text
term.style_bold() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1m%s%s" "$text" "$end"
}

# @description Construct dim
# @arg $1 string text
term.style_dim() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[2m%s%s" "$text" "$end"
}

# @description Construct italic
# @arg $1 string text
term.style_italic() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[3m%s%s" "$text" "$end"
}

# @description Construct underline
# @arg $1 string text
term.style_underline() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[4m%s%s" "$text" "$end"
}

# @description Construct inverse
# @arg $1 string text
term.style_inverse() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[7m%s%s" "$text" "$end"
}

# @description Construct hidden
# @arg $1 string text
term.style_hidden() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[8m%s%s" "$text" "$end"
}

# @description Construct strikethrough
# @arg $1 string text
term.style_strikethrough() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[9m%s%s" "$text" "$end"
}

# @description Construct hyperlink
# @arg $1 string text
# @arg $2 string url
term.style_hyperlink() {
	local text="$1"
	local url="$2"

	printf -v REPLY '\e]8;;%s\a%s\e]8;;\a' "$url" "$text"
}

# @description Construct black color
# @arg $1 string text
term.color_black() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[30m%s%s" "$text" "$end"
}

# @description Construct red color
# @arg $1 string text
term.color_red() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[31m%s%s" "$text" "$end"
}

# @description Construct green color
# @arg $1 string text
term.color_green() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[32m%s%s" "$text" "$end"
}

# @description Construct orange color
# @arg $1 string text
term.color_orange() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[33m%s%s" "$text" "$end"
}

# @description Construct blue color
# @arg $1 string text
term.color_blue() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[34m%s%s" "$text" "$end"
}

# @description Construct purple color
# @arg $1 string text
term.color_purple() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[35m%s%s" "$text" "$end"
}

# @description Construct cyan color
# @arg $1 string text
term.color_cyan() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[36m%s%s" "$text" "$end"
}

# @description Construct light gray color
# @arg $1 string text
term.color_light_gray() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[37m%s%s" "$text" "$end"
}

# @description Construct dark gray color
# @arg $1 string text
term.color_dark_gray() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;30m%s%s" "$text" "$end"
}

# @description Construct light red color
# @arg $1 string text
term.color_light_red() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;31m%s%s" "$text" "$end"
}

# @description Construct light green color
# @arg $1 string text
term.color_light_green() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;32m%s%s" "$text" "$end"
}

# @description Construct yellow color
# @arg $1 string text
term.color_yellow() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;33m%s%s" "$text" "$end"
}

# @description Construct light blue color
# @arg $1 string text
term.color_light_blue() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;34m%s%s" "$text" "$end"
}

# @description Construct light purple color
# @arg $1 string text
term.color_light_purple() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;35m%s%s" "$text" "$end"
}

# @description Construct light cyan color
# @arg $1 string text
term.color_light_cyan() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;36m%s%s" "$text" "$end"
}

# @description Construct white color
# @arg $1 string text
term.color_white() {
	local {text,end}=
	case $# in 1) text=$1 ;; 2) text=$2; end=$'\e[0m'; if [ "$1" != '-d' ]; then core.panic 'Invalid flag'; fi ;; *) core.panic 'Invalid argument count' ;; esac

	printf -v REPLY "\e[1;37m%s%s" "$text" "$end"
}



# -------------------------------------------------------- #
#                       Miscellaneous                      #
# -------------------------------------------------------- #

# @description Construct a beep
# @noargs
term.beep() {
	unset -v REPLY

	REPLY=$'\a'
}



# -------------------------------------------------------- #
#                        Deprecated                        #
# -------------------------------------------------------- #

# @description (DEPRECATED) Construct hyperlink
# @arg $1 string text
# @arg $2 string url
term.hyperlink() {
	term.style_hyperlink "$@"
}

# @description (DEPRECATED) Construct bold
# @arg $1 string text
term.bold() {
	term.style_bold "$@"
}

# @description (DEPRECATED) Construct italic
# @arg $1 string text
term.italic() {
	term.style_italic "$@"
}

# @description (DEPRECATED) Construct underline
# @arg $1 string text
term.underline() {
	term.style_underline "$@"
}

# @description (DEPRECATED) Construct strikethrough
# @arg $1 string text
term.strikethrough() {
	term.style_strikethrough "$@"
}

