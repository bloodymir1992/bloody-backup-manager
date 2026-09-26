# Changelog

## 0.6.0

- Replaced size-only destructive verification with SHA-256 content verification.
- Destructive "Backup and free space" mode now always verifies content before deletion.
- Verification compares directory layout, regular-file sizes and hashes, and symlink targets.
- Updated visible verification wording in the GTK interface.
- Updated bundled README to the current version.
- Removed generated Python `__pycache__` files from the Debian package.
- Added a guarded application entry point to make verification code easier to test.
- Prepared public GitHub repository structure and reproducible Debian build script.

## 0.5.5

- Improved image thumbnail rendering.
- Added cached on-demand folder sizes for smoother browsing.
