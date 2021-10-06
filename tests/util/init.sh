# shellcheck shell=bash

# When testing with Bats (i.e. invoking the `bats` command), a new Bash process
# is launched, so we need to load everything in the same way as the files in
# the 'bin' directory
eval "$(basalt-package-init)"; basalt.package-init
basalt.package-load

# Note that normally `basalt.package-load` will load all files, including the one
# below. However, `bats-common-utils` does not do this, since that would mean testing
# functions will be loaded during testing _and non-testing_ environments. This means
# we just have to remember to load it during testing, as is done below
basalt.load 'github.com/hyperupcall/bats-common-utils' 'load.bash'

# Although this project, doesn't use it, it is generally good to set this during testing (and ensure
# any of your printing functions do _not_ output color if `NO_COLOR` is set (see https://no-color.org
# for details)). Doing this allows you do `assert_line -p` text (`assert_line` is from
# `github.com/bats-core/bats-assert`) without worring about color escape sequences. In other words, if
# a line had the text `<red_text_escape_sequence>Error:<clear_escape_sequence> Sample text`, it would
# mean that `assert_line -p "Error: Sample text` does _not_ match it, due to the hidden escape sequences.
export NO_COLOR=

# TODO: this should be automated
# As stated in `pkg/bin/fox-track`, making the `pkg/bin/fox-track` contain a
# function to
fox-track() { fox-track.main "$@"; }

setup() {
	ensure.cd "$BATS_TEST_TMPDIR"
}

teardown() {
	ensure.cd "$BATS_SUITE_TMPDIR"
}
