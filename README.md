# Fix Image Compatibility

A bash script designed to regenerate image files, resolving compatibility issues often encountered when opening downloaded images in Adobe Illustrator. This tool automates the "Open in Paint -> Save As" workaround.

## Overview

Sometimes when you download images, they contain corrupted metadata or non-standard formatting that causes issues when opening them in Adobe Illustrator. This script uses ImageMagick to re-encode the image data and strip potentially corrupted metadata, effectively "fixing" the image for Illustrator compatibility.

## Key Features

- **Automated Repair**: Uses ImageMagick to re-encode image data
- **Metadata Stripping**: Removes potentially corrupted headers/metadata
- **Safe Operation**: Creates new files (`filename_fixed.ext`) instead of overwriting by default
- **Batch Processing**: Accepts multiple files at once
- **Interactive Mode**: Choose between overwriting originals or creating new files

## Installation

1. Clone or download this repository
2. Make the script executable:

```bash
chmod +x fix_image
```

## Dependencies

- **ImageMagick**: Must be installed on your system
  - Ubuntu/Debian: `sudo apt install imagemagick`
  - Fedora: `sudo dnf install ImageMagick`
  - Arch: `sudo pacman -S imagemagick`
  - macOS: `brew install imagemagick`

## Usage

```bash
# Fix a single image
./fix_image image.png

# Fix multiple images
./fix_image image1.jpg image2.png

# Fix all images in a folder
./fix_image *.jpg
```

When you run the script, you'll be prompted to choose between:
1. Overwriting the original file (repair in-place)
2. Creating a new file with `_fixed` suffix (safe mode, default)

## How It Works

The script uses ImageMagick's `convert` command with the `-strip` flag to:
1. Read the image pixel data
2. Remove all metadata that might be causing issues
3. Write a fresh file with clean formatting

This mimics the "Open in Paint -> Save As" workflow that works on Windows but isn't available on Linux.

## License

This project is open source and available under the MIT License.