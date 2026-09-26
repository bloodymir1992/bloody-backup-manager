#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="0.6.0"
PKG="bloody-backup-manager"
WORK="$(mktemp -d -t bloody-backup-manager-build.XXXXXX)"
BUILD="$WORK/${PKG}_${VERSION}_all"
DIST="$ROOT/dist"
trap 'rm -rf "$WORK"' EXIT

mkdir -p   "$BUILD/DEBIAN"   "$BUILD/usr/bin"   "$BUILD/usr/share/applications"   "$BUILD/usr/share/pixmaps"   "$BUILD/usr/share/bloody-backup-manager"   "$DIST"

install -m 0755 "$ROOT/src/bloody-backup-manager" "$BUILD/usr/bin/bloody-backup-manager"
install -m 0644 "$ROOT/assets/bloody-backup-manager.svg" "$BUILD/usr/share/pixmaps/bloody-backup-manager.svg"
install -m 0644 "$ROOT/packaging/bloody-backup-manager.desktop" "$BUILD/usr/share/applications/bloody-backup-manager.desktop"
install -m 0644 "$ROOT/packaging/control" "$BUILD/DEBIAN/control"

cat > "$BUILD/usr/share/bloody-backup-manager/README.txt" <<'TXT'
Bloody Backup Manager v0.6.0

GTK 3 backup manager for Debian-based Linux.
"Backup and free space" always performs SHA-256 content verification before
removing original files.

User cache: ~/.cache/bloody-backup-manager/
Backups: <destination>/Bloody Backup/<machine> Backup/
TXT

python3 -m py_compile "$BUILD/usr/bin/bloody-backup-manager"
rm -rf "$BUILD/usr/bin/__pycache__"
find "$BUILD" -type d -exec chmod 0755 {} +
chmod 0644 "$BUILD/DEBIAN/control"

dpkg-deb --build --root-owner-group   "$BUILD"   "$DIST/BloodyBackupManager-v${VERSION}-Linux.deb"

sha256sum "$DIST/BloodyBackupManager-v${VERSION}-Linux.deb"   > "$DIST/BloodyBackupManager-v${VERSION}-Linux.deb.sha256"

echo "Built: $DIST/BloodyBackupManager-v${VERSION}-Linux.deb"
