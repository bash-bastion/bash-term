# shellcheck shell=bash

# -------------------------------------------------------- #
#                          Cursor                          #
# -------------------------------------------------------- #

tty.cursor_to() {
	unset -v REPLY
	local row="${1:-0}"
	local column="${2:-0}"

	# Note that 'f' instead of 'H' is the 'force' variant
	printf -v REPLY '\033[%s;%sH' "$row" "$column"
}

tty.cursor_up() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sA' "$count"
}

tty.cursor_down() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sB' "$count"
}

tty.cursor_forward() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sC' "$count"
}

tty.cursor_backward() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sD' "$count"
}

tty.cursor_line_next() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sE' "$count"
}

tty.cursor_line_prev() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sF' "$count"
}

# TODO: name, default?
tty.cursor_tocolumn() {
	unset -v REPLY
	local count="${1:-1}"

	printf -v REPLY '\033[%sG' "$count"
}

# @noargs
tty.cursor_savepos() {
	unset -v REPLY

	REPLY=$'\e[s'
}

# @noargs
tty.cursor_unsavepos() {
	unset -v REPLY

	REPLY=$'\e[u'
}

# @noargs
tty.cursor_save() {
	unset -v REPLY

	REPLY=$'\e[7'
}

# @noargs
tty.cursor_unsave() {
	unset -v REPLY

	REPLY=$'\e[8'
}

# @noargs
tty.cursor_hide() {
	unset -v REPLY

	REPLY=$'\e[?25l'
}

# @noargs
tty.cursor_show() {
	unset -v REPLY

	REPLY=$'\e[?25h'
}


# -------------------------------------------------------- #
#                          Scroll                          #
# -------------------------------------------------------- #

# @noargs
tty.scroll_down() {
	unset -v REPLY

	REPLY=$'\e[D'
}

# @noargs
tty.scroll_up() {
	unset -v REPLY

	REPLY=$'\e[M'
}


# -------------------------------------------------------- #
#                            Tab                           #
# -------------------------------------------------------- #

# @noargs
tty.tab_set() {
	unset -v REPLY

	REPLY=$'\e[H'
}

# @noargs
tty.tab_clear() {
	unset -v REPLY

	REPLY=$'\e[g'
}

# @noargs
tty.tab_clearall() {
	unset -v REPLY

	REPLY=$'\e[3g'
}


# -------------------------------------------------------- #
#                           Erase                          #
# -------------------------------------------------------- #

# @noargs
tty.erase_line_end() {
	unset -v REPLY

	# Same as '\e[0K'
	REPLY=$'\e[K'
}

# @noargs
tty.erase_line_start() {
	unset -v REPLY

	REPLY=$'\e[1K'
}

# @noargs
tty.erase_line() {
	unset -v REPLY

	REPLY=$'\e[2K'
}

# @noargs
tty.erase_screen_end() {
	unset -v REPLY

	# Same as '\e[0J'
	REPLY=$'\e[J'
}

# @noargs
tty.erase_screen_start() {
	unset -v REPLY

	REPLY=$'\e[1J'
}

# @noargs
tty.erase_screen() {
	unset -v REPLY

	REPLY=$'\e[2J'
}

# @noargs
tty.erase_saved_lines() {
	unset -v REPLY

	REPLY=$'\e[3J'
}


# -------------------------------------------------------- #
#                       Miscellaneous                      #
# -------------------------------------------------------- #

tty.beep() {
	unset -v REPLY

	REPLY=$'\a'
}

tty.hyperlink() {
	unset -v REPLY
	local text="$1"
	local url="$2"

	printf -v REPLY '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$url" "$text"
}
