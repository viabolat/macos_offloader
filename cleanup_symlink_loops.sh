#!/bin/bash

# ==============================================================
# CLEANUP SCRIPT: Detect and remove recursive symlink loops
# --------------------------------------------------------------
# Targeted for macOS Folder Offloader setup
# Looks inside /Volumes/Storage/moved_* folders
# Deletes nested moved_* symlinks (e.g., moved_Documents/moved_Documents)
# ==============================================================

TARGET_DRIVE="/Volumes/Storage"

echo "� Scanning $TARGET_DRIVE for nested moved_* symlinks..."

# Loop through top-level moved_* folders
find "$TARGET_DRIVE" -maxdepth 1 -type d -name "moved_*" | while read -r folder; do
    nested="$folder/$(basename "$folder")"

    if [ -L "$nested" ]; then
        echo "⚠️  Found nested symlink: $nested"
        read -p "�️  Delete this nested symlink? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            rm -f "$nested"
            echo "✅ Removed: $nested"
        else
            echo "⏭️  Skipped: $nested"
        fi
    fi
done

echo "✅ Cleanup complete. Symlink loops removed if confirmed."
