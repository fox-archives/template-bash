# shellcheck shell=bash

# TODO: use hyperupcall/bash-args when it is ready
fox-track.main() {
	local subcommand=
	local arg=; for arg; do case "$arg" in
		--help)
			printf '%s\n' "fox-track: A fox tracking sample application

Commands:
  show
    Shows the current fox count

  set <number>
    Sets the current fox count

  add [number]
    Adds a number to the current fox count. If number is not specified, it defaults to 1

  remove [number]
    Adds a number to the current fox count. If number is not specified, it defaults to 1

Flags:
  --help
    Shows the help menu"
			;;
		-*)
			printf '%s\n' "Error: Flag '$arg' not recognized"
			exit 1
			;;
		*)
			subcommand="$arg"
			break
			;;
	esac done; unset arg

	case "$subcommand" in
		'')
			printf '%s\n' "Error: No subcommand was given. Pass '--help'"
			exit 1
			;;
		show)
			shift
			fox_tracker.fox.show "$@"
			;;
		set)
			shift
			fox_tracker.fox.set "$@"
			;;
		add)
			shift
			fox_tracker.fox.add "$@"
			;;
		remove)
			shift
			fox_tracker.fox.remove "$@"
			;;
		*)
			printf '%s\n' "Error: Subcommand '$subcommand' not recognized"
			exit 1
			;;
	esac
}
