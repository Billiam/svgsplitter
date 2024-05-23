# svgsplitter

Commandline utility to separate multiple "layers" of an SVG into separate files.

SVGsplitter is a utility to correct a shortcoming in Affinity Designer 1 and 2, making it easier to create
separate SVGs for each layer of a document _without changing the output dimensions_.

Affinity designer can do this through the exports persona, but each layer will be "sliced" to the layers content dimensions.

## Installation

Download the latest release for your platform

## Usage

First, export an SVG with all layers visible, and then pass the resulting file to `svgsplitter`

```sh
svgsplitter my_document.svg
```

By default, a new directory will be created based on the input filename: `./my_document`, and one file will be generated
for each named layer of the export.

SVGsplitter uses the layer's ID attribute (which matches the layer name in Affinity Designer) as the output filename
for each file.

Elements without this ID attribute (for example, unnamed layers, or SVGs created by another program) will not be exported.

### Example

Given an SVG like:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="100%" height="100%" viewBox="0 0 426 426" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" xmlns:serif="http://www.serif.com/" style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <rect id="Layer-1" serif:id="Layer 1" x="67.725" y="78.326" width="87.159" height="95.993" style="fill:#ebebeb;"/>
    <ellipse id="Layer-2" serif:id="Layer 2" cx="246.167" cy="187.422" rx="61.247" ry="61.1" style="fill:#ebebeb;"/>
    <path id="Layer-3" serif:id="Layer 3" d="M182.858,283.268l46.208,36.014l-17.65,58.27l-57.116,0l-17.649,-58.27l46.207,-36.014Z" style="fill:#ebebeb;"/>
</svg>
```
Three files will be created: `Layer-1.svg`, `Layer-2.svg`, and `Layer-3.svg`.

All files will share the same DTD and `<svg>` element, but will only have the associated layer's content.

### CLI

```
Usage:
  svgsplitter split [options] [--] <svg>

Arguments:
  svg                    SVG to split

Options:
  -o, --output[=OUTPUT]  Output directory
  -p, --prefix[=PREFIX]  Prefix for new files
  -d, --dry-run          
  -h, --help             Display help for the given command. When no command is given display help for the list command
  -q, --quiet            Do not output any message
  -V, --version          Display this application version
      --ansi|--no-ansi   Force (or disable --no-ansi) ANSI output
```
## Contributing

1. Fork it (<https://github.com/your-github-user/svgsplitter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Billiam](https://github.com/Billiam) - creator and maintainer
