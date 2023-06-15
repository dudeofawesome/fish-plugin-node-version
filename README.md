# `fish-plugin-node-version` [![GPL-3 License](https://img.shields.io/badge/license-GPL3-007EC7.svg?style=flat-square)](/LICENSE)

> A [Fish shell](https://fishshell.com/) plugin to change Node versions based on a [Node Version File](https://github.com/shadowspawn/node-version-usage).

## Installation

```fish
$ fisher install dudeofawesome/fish-plugin-node-version
```

## Usage

1. `cd` into a directory with a `.nvmrc` or `.node-version` file in it.
1. Watch your `node` version magically change to the correct version!

## Development

### Install dependencies

1. `$ fisher install jorgebucaran/fishtape`

### Testing

```sh
$ fishtape test/*.fish
```
