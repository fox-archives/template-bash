# template-bash
TODO: ensure notify to put year and name in LICENSE

This is a project template for a [Basalt](https://github.com/hyperupcall/basalt)-defined Bash project. This template is used when constructing Bash projects with Basalt

## Requirements

- [Basalt](https://github.com/hyperupcall/basalt), the rock-solid Bash package manager
- [Bats](https://github.com/bats-core/bats-core) version `v1.4.0` or greater
  - If you have an old version, you can either do `basalt global add bats-core/bats-core`, or use [woof](https://github.com/hyperupcall/woof), a generalized program version manager

## Usage

To use this project as a boilerplate for your own projects, simply run

```sh
basalt init
```

If you wish to actually use the functionality of this template (i.e. An application that tracks foxes), see below

## Extended Usage

This template includes working code for a "Fox Tracker" that is usable as a library and a command line utility. Succinctly, this application allows a user to track and change the number of hypothetical foxes (stored in `$XDG_STATE_HOME/fox-tracker/count`)

#### 1. CLI

To access the command line interface, simply run

```sh
basalt global add hyperupcall/template-bash
```

This works because of the assignment to `binDirs` in `basalt.toml`. Access functionality with the `fox-track` command

#### 2. Library

```sh
basalt init
basalt add hyperupcall/template-bash
```

## TODO

- [ ] Completions
- [ ] Tests
