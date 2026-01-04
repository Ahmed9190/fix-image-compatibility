# Specification: Image Compatibility Fixer

## 1. Overview
A bash script to regenerate image files, fixing compatibility issues often encountered when opening downloaded images in Adobe Illustrator. This automates the "Open in Paint and Save" workaround by re-encoding the image data and stripping potentially corrupt metadata using ImageMagick.

## 2. Requirements

### 2.1 Functional Requirements
- **FR1**: Accept one or multiple image file paths as arguments.
- **FR2**: Check for the existence of `ImageMagick` (`convert` command).
- **FR3**: If `ImageMagick` is missing, provide clear installation instructions.
- **FR4**: Process each image by re-encoding it to a new file.
- **FR5**: Remove metadata (`-strip`) to ensure maximum compatibility.
- **FR6**: Output file name should append `_fixed` before the extension (e.g., `image.png` -> `image_fixed.png`).
- **FR7**: Provide a success message for each file.
- **FR8**: Handle file not found errors gracefully.

### 2.2 Non-Functional Requirements
- **NFR1**: Script must be POSIX-compliant where possible, but Bash specific is acceptable for array handling.
- **NFR2**: Use strict error handling (`set -euo pipefail`).
- **NFR3**: Minimal dependency on external tools other than `ImageMagick`.

## 3. Architecture

### 3.1 File Structure
```
scripts/
├── fix-image.sh           # Main entry point
├── lib/
│   └── utils.sh           # Helper functions (logging, check dependencies)
└── tests/
    └── test-fix-image.sh  # Validation script
```

### 3.2 Workflow
1. Parse arguments.
2. Check dependencies (`convert`).
3. Iterate through provided files.
4. For each file:
   - Validate existence.
   - Construct output filename.
   - Execute `convert "$input" -strip "$output"`.
   - Verify output creation.
5. Exit with status.

## 4. Validation Criteria
- **VC1**: Script fails gracefully if `convert` is not installed.
- **VC2**: Script successfully creates a new file ending in `_fixed.<ext>`.
- **VC3**: Script processes multiple arguments correctly.
- **VC4**: Original file remains untouched.
