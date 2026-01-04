# Project Summary: Fix Image Compatibility

## Overview
A bash script designed to regenerate image files, resolving compatibility issues often encountered when opening downloaded images in Adobe Illustrator. This tool automates the "Open in Paint and Save" workaround.

## Key Features
- **Automated Repair**: Uses ImageMagick to re-encode image data.
- **Metadata Stripping**: Removes potentially corrupted headers/metadata (`-strip`).
- **Safe Operation**: Creates new files (`filename_fixed.ext`) instead of overwriting.
- **Batch Processing**: Accepts multiple files at once.

## Usage
```bash
# Fix a single image
./scripts/fix-image.sh image.png

# Fix multiple images
./scripts/fix-image.sh image1.jpg image2.png

# Fix all images in a folder
./scripts/fix-image.sh *.jpg
```

## Dependencies
- **ImageMagick**: Must be installed.
  - Ubuntu/Debian: `sudo apt install imagemagick`
  - Fedora: `sudo dnf install ImageMagick`
  - Arch: `sudo pacman -S imagemagick`

## Files Created
- `scripts/fix-image.sh`: Main executable script.
- `scripts/lib/utils.sh`: Helper functions.
