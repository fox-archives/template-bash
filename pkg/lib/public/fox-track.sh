# shellcheck shell=bash

fox_tracker.show() {
	fox_tracker.fox.show "$@"
}

fox_tracker.set() {
	fox_tracker.fox.set "$@"
}

fox_tracker.add() {
	fox_tracker.fox.add "$@"
}

fox_tracker.remove() {
	fox_tracker.fox.remove "$@"
}
