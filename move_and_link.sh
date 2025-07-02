#!/bin/bash

# ============================================================
# macOS Folder Offloader — SAFE VERSION
# ------------------------------------------------------------
# Moves specified user folders to an external drive
# Replaces them with symbolic links at their original location
# Prevents symlink loops and duplicates
# ============================================================

# === CONFIGURABLE ===
TARGET_DRIVE="/Volumes/Storage"
FOLDERS_TO_MOVE=("Movies" "Pictures" "Downloads" "Documents")

# --- Startup Banner ---
echo "� macOS Folder Offloader"
echo "This script will move specified user folders to an external drive and replace them with symbolic links."
echo "Make sure your target drive is mounted at: $TARGET_DRIVE"
echo "Press Ctrl+C now to cancel or wait 3 seconds to continue..."
sleep 3

# --- Start Migration ---
echo "� Starting symbolic link migration..."

for folder in "${FOLDERS_TO_MOVE[@]}"; do
    SRC="$HOME/$folder"
    DEST="$TARGET_DRIVE/moved_$folder"

    # ✅ Skip if source is already a symlink
    if [ -L "$SRC" ]; then
        echo "� Skipped: $SRC is already a symlink"
        continue
    fi

    # ✅ Skip if destination exists to prevent recursive move
    if [ -e "$DEST" ]; then
        echo "⚠️ Skipped: Destination already exists at $DEST (avoiding duplicate or loop)"
        continue
    fi

    # ✅ Detect potential recursive loop risk
    if [[ "$SRC" == "$DEST"* ]]; then
        echo "� ERROR: Detected potential loop. $SRC is inside $DEST"
        continue
    fi

    # ✅ Move and link only if source exists and is a directory
    if [ -d "$SRC" ]; then
        echo "� Moving $folder to $DEST..."
        mv "$SRC" "$DEST"

        ln -s "$DEST" "$SRC"
        echo "✅ Linked $SRC → $DEST"
    else
        echo "⚠️ Skipped: $SRC does not exist or is not a directory"
    fi
done

echo "� Done! Your folders are now stored on $TARGET_DRIVE and safely linked back."
