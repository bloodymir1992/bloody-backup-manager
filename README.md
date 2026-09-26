# Bloody Backup Manager

Bloody Backup Manager is a GTK 3 desktop backup utility for Debian-based Linux distributions. It provides a file-manager-like view of mounted disks, organized `rsync` backups, image thumbnails, cached folder sizes, and a protected **Backup and free space** mode.

## Highlights

- Detects mounted storage with `lsblk` while hiding EFI/boot partitions.
- Browse source disks inside the application.
- Choose an independent writable destination.
- Back up selected files and folders with `rsync -a`.
- Optional SHA-256 content verification after normal backups.
- **Backup and free space always forces SHA-256 verification** before deleting originals.
- Protects system roots and critical directories from destructive cleanup.
- Image thumbnails and cached on-demand folder sizes for a responsive UI.
- Per-user cache under `~/.cache/bloody-backup-manager/`.

## Supported systems

Designed for Debian-based desktop Linux distributions with GTK 3, including Linux Mint, Ubuntu, and Debian systems where the package dependencies are available.

## Install the `.deb`

Download the release package and run:

```bash
sudo apt install ./BloodyBackupManager-v0.6.0-Linux.deb
```

Then launch **Bloody Backup Manager** from the application menu.

## Dependencies

Required:

- `python3`
- `python3-gi`
- `gir1.2-gtk-3.0`
- `rsync`
- `util-linux`

Recommended for thumbnail fallback:

- `libgdk-pixbuf2.0-bin`

## Safety model

The destructive **Backup and free space** mode follows this order:

1. Copy the selected item with `rsync`.
2. Build a manifest of the source and destination.
3. Compare directory structure, regular-file sizes, SHA-256 hashes, and symlink targets.
4. Delete the original only when both manifests match.
5. Keep the original and report an error if verification fails for any reason.

The destructive mode cannot disable verification.

No backup tool replaces a multi-copy backup strategy for irreplaceable data.

## Build the Debian package

From the repository root:

```bash
chmod +x build-deb.sh
./build-deb.sh
```

The package will be created in `dist/`.

## License

MIT License. See `LICENSE`.
