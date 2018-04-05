<h1 align="center">
  <img src="https://raw.githubusercontent.com/hachibu/md_spa/master/images/md_spa-logo.png">
  <br>
  md_spa
</h1>

Have you ever wanted to build a single-page application inside of one giant Markdown file? Well, now you can with the help of `md_spa`!

With `md_spa` you can build an entire single-page application inside of a Markdown file and compile it down to a single HTML file or a standalone executable web server.

## Requirements

- [Crystal](https://crystal-lang.org/docs/installation)

## Install

    git clone https://github.com/hachibu/md_spa.git
    cd md_spa
    make install

## Uninstall

    make uninstall

## Usage

<img src="https://raw.githubusercontent.com/hachibu/md_spa/master/images/serve-mode-screenshot.png">

### Compile to HTML

    md_spa examples/index.md --build=html
    open examples/index.html

### Compile to Standalone Executable

    md_spa examples/index.md --build=exe
    examples/index.exe --port=4567

### Live Edit Mode

    md_spa examples/index.md --serve

## Development

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

