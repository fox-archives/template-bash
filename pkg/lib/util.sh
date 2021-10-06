# shellcheck shell=bash

fox_tracker.util.init() {
	if [ "${FOX_TRACKER_STATE_DIR::1}" != / ]; then
		FOX_TRACKER_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/fox-tracker"
	fi

	if [ ! -f "$FOX_TRACKER_STATE_DIR/count" ]; then
		mkdir -p "$FOX_TRACKER_STATE_DIR"
		printf '%s\n' '0' > "$FOX_TRACKER_STATE_DIR/count"
	fi
}

fox_tracker.util.ensure_args() {
	local actual_number="$1"
	local expected_number="$2"

	# TODO: This will exit, even when called as a library! (along with nearly every other exit in this project)
	if ((expected_number != actual_number)); then
		printf '%s\n' "Error: Received $actual_number argument(s), but expected $expected_number"
		exit 1
	fi
}

fox_tracker.util.gettotal() {
	# Note that it is _highly_ recommended to use the pattern below when dealing
	# with `REPLY` variables. `REPLY=` is shorthand for `REPLY=''`. This is required
	# for two reasons
	# 1. To prevent bugs where this function exits prematuraly (before `REPLY` is set here),
	#    and the previous value of `REPLY` leaks into wherever the callsite of this function is
	# 2. If `set -u` is enabled, setting this will ensure `REPLY` is always set and not error
	#
	# Note that the `unset REPLY` is also required, since we want to ensure `REPLY=` is of the
	# correct type. If `REPLY` is unset, then `REPLY=` sets it to an empty string, but if `REPLY`
	# is an associative array, then `REPLY=` just makes it an empty array. Additionally, if you want to
	# set `REPLY` to an indexed array or associative array, you _must_ pass the `-g` flag to `declare`. If
	# your version of Bash does not have `-g`, it means it is not supported!
	unset REPLY; REPLY=

	# Note that "$(<"file")" is generally faster compared to "$(cat "file")" since it is not creating
	# an external process (cat is _not_ a builtin)
	REPLY="$(<"$FOX_TRACKER_STATE_DIR/count")"
}
