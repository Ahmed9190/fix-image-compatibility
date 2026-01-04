# Project Context: fix-image-compatibility
Created: 2026-01-04
Last Updated: 2026-01-04

## Original Request
"Sometimes I download images and then try to open them with illustrator but they don't run for some reason. I need a script to fix this issue. previously I was opening on windows paint paste it and save it as a new file and it works properly. currently I am on linux I don't know how to fix this. Please create a script to handle this issue in images"

## Requirements Analysis

### Extracted Requirements
1. **Goal**: Regenerate image files to fix compatibility with Adobe Illustrator.
2. **Method**: Mimic the "Open in Paint -> Save As" workflow programmatically on Linux.
3. **Core Function**: Re-encode image data to strip corrupted headers/metadata or normalize format.
4. **Input**: Image file(s).
5. **Environment**: Linux.

### Technical Approach
- **Tool**: `ImageMagick` (`convert`) is the standard tool for this. It reads the image pixel data and writes a fresh file, effectively sanitizing the container.
- **Mechanism**: `convert input_image -strip output_image`. The `-strip` flag removes metadata which is a common cause of Illustrator crashes. Re-encoding ensures the structure is standard.
- **Safety**: Do not overwrite original files by default. Append `_fixed` or similar.

### Decision 3: Standalone Consolidation
- **When**: 2026-01-04T10:15:00Z
- **Context**: User requested a single file solution.
- **Chosen**: Embed all logic in `fix-image.sh`.
- **Rationale**: Simplifies distribution and usage for simple CLI tools.

### Decision 4: ImageMagick v7 Compatibility
- **When**: 2026-01-04T10:15:00Z
- **Context**: 'convert' is deprecated in IMv7.
- **Chosen**: Dynamic command detection (prefer 'magick', fallback to 'convert').
- **Rationale**: Removes deprecation warnings and future-proofs the script.

### Decision 5: Interactive Output Mode
- **When**: 2026-01-04T10:20:00Z
- **Context**: User requested an interactive menu to choose between overwriting and creating a new file.
- **Chosen**: Implement a text-based menu (1=Overwrite, 2=Suffix).
- **Rationale**: Gives user control over file management, similar to other CLI tools.

## Implementation Progress
- **Refactoring**: Consolidated modular structure into standalone `fix-image.sh` in root.
- **Feature**: Added interactive output mode selection.
- **Phase 1**: Specification
- **Phase 2**: Implementation (Bash script checking for `convert`, processing arguments)
- **Phase 3**: Validation (Test with dummy image)
