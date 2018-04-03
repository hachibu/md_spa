<h1 align="center">
  <img src="https://raw.githubusercontent.com/hachibu/md_spa/master/images/md_spa-icon.png" alt="md_spa">
  <br>
  md_spa
</h1>

md_spa is a command line tool to compile a Markdown file into a single HTML file.

## Requirements

- [Crystal](https://crystal-lang.org/docs/installation)

## Install

    git clone https://github.com/hachibu/md_spa.git
    cd md_spa
    make install

## Usage

    md_spa examples/index.md
    open examples/index.html

### Live Edit Mode

    md_spa --watch examples/index.md

## Uninstall

    make uninstall

## Develop

    make build && bin/md_spa

## Test

    make test

## Contributing

1. Fork it (https://github.com/hachibu/md_spa/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new pull request

## Contributors

- [hachibu](https://github.com/hachibu) - creator, maintainer

