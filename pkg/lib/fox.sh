# shellcheck shell=bash

fox_tracker.fox.show() {
	fox_tracker.util.init
	fox_tracker.util.ensure_args $# 0

	fox_tracker.util.gettotal
	local total="$REPLY"

	printf '%s\n' "$total"
}

fox_tracker.fox.set() {
	fox_tracker.util.init
	fox_tracker.util.ensure_args $# 1

	local number="$1"
	if ! [[ $number =~ -?[[:digit:]]+ ]]; then
		printf '%s\n' "Error: Argument does not look like a valid number"
		exit 1
	fi

	printf '%s' $((number)) > "$FOX_TRACKER_STATE_DIR/count"
}

fox_tracker.fox.add() {
	fox_tracker.util.init
	fox_tracker.util.ensure_args $# 1

	local number="$1"
	if ! [[ $number =~ [[:digit:]]+ ]]; then
		printf '%s\n' "Error: Argument does not look like a valid positive number"
		exit 1
	fi

	fox_tracker.util.gettotal
	local total="$REPLY"

	printf '%s' $((total+number)) > "$FOX_TRACKER_STATE_DIR/count"
}

fox_tracker.fox.remove() {
	fox_tracker.util.init
	fox_tracker.util.ensure_args $# 1

	local number="$1"
	if ! [[ $number =~ [[:digit:]]+ ]]; then
		printf '%s\n' "Error: Argument does not look like a valid positive number"
		exit 1
	fi

	# This is the general pattern for calling functions in Bash. It is highly adviced to set `REPLY`
	# instead of printing to standard output and caputing it with `"$()"` since the latter can get
	# quite slow. Furthermore, the former enables you to return multiple values (label them as `REPLY1`,
	# `REPLY2`, etc. (do _not_ set `REPLY` in this case!))
	fox_tracker.util.gettotal
	local total="$REPLY"

	# TODO: Handle this, and similar cases in the code?
	# Note that the '>' can potentially error (ex. if it is redirecting to a directory). Since this
	# error is not handeled, it will print an ugly message to the console, and will terminate execution
	# of the program if `set -e` is enabled. If `set -e` is not enabled, this error will likely cause
	# undefined (with respect to how the program is expected to behave to the programer, _not_ with respect
	# to how Bash interprets the code) behavior
	printf '%s' $((total-number)) > "$FOX_TRACKER_STATE_DIR/count"
}
