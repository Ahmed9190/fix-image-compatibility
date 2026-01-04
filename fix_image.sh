#!/usr/bin/env bash

# Fix Image Compatibility for Adobe Illustrator
# Re-encodes images to strip corrupted metadata and normalize structure.
# Standalone version: All utilities embedded.

set -euo pipefail

# --- Utilities ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# --- Dependency Check ---
# Detect ImageMagick command (magick in v7+, convert in v6)
IMG_CMD=""
if command -v magick &> /dev/null; then
    IMG_CMD="magick"
elif command -v convert &> /dev/null; then
    IMG_CMD="convert"
fi

check_imagemagick() {
    if [ -z "$IMG_CMD" ]; then
        log_error "ImageMagick not found."
        log_info "Please install ImageMagick:"
        log_info "  Ubuntu/Debian: sudo apt update && sudo apt install imagemagick"
        log_info "  Fedora: sudo dnf install ImageMagick"
        log_info "  Arch: sudo pacman -S imagemagick"
        return 1
    fi
    return 0
}

# --- Main Logic ---
main() {
    if [ $# -eq 0 ]; then
        log_error "No files provided."
        echo "Usage: $0 <image_file1> [image_file2 ...]"
        exit 1
    fi

    if ! check_imagemagick; then
        exit 1
    fi

    # --- Interactive Prompt ---
    echo "----------------------------------------"
    echo "🤔 Choose output mode:"
    echo "   1) Overwrite original file(s) (Repair in-place)"
    echo "   2) Create new file(s) with suffix '_fixed' (Safe mode)"
    echo "----------------------------------------"
    read -p "Enter choice [1/2]: " choice
    echo ""

    case "$choice" in
        1)
            MODE="overwrite"
            log_info "Mode selected: Overwrite original files."
            ;;
        2)
            MODE="suffix"
            log_info "Mode selected: Create new files with suffix."
            ;;
        *)
            log_warn "Invalid choice. Defaulting to safe mode (suffix)."
            MODE="suffix"
            ;;
    esac

    log_info "Using command: $IMG_CMD"
    log_info "Starting image repair process..."

    local errors=0

    for input_file in "$@"; do
        if [ ! -f "$input_file" ]; then
            log_error "File not found: $input_file"
            errors=$((errors + 1))
            continue
        fi

        local filename=$(basename -- "$input_file")
        local extension="${filename##*.}"
        local name="${filename%.*}"
        local dir_path=$(dirname "$input_file")
        
        local output_file
        local full_output_path

        if [ "$MODE" == "overwrite" ]; then
            full_output_path="$input_file"
        else
            if [ "$filename" == "$extension" ]; then
                 log_warn "File '$input_file' has no extension. Appending '_fixed'."
                 output_file="${name}_fixed"
            else
                 output_file="${name}_fixed.${extension}"
            fi
            full_output_path="$dir_path/$output_file"
        fi

        log_info "Processing: $input_file -> $full_output_path"

        # Execute conversion using detected command
        if "$IMG_CMD" "$input_file" -strip "$full_output_path"; then
            log_success "Fixed: $full_output_path"
        else
            log_error "Failed to convert: $input_file"
            errors=$((errors + 1))
        fi
    done

    if [ "$errors" -gt 0 ]; then
        log_warn "Completed with $errors error(s)."
        exit 1
    else
        log_success "All files processed successfully."
        exit 0
    fi
}

main "$@"
