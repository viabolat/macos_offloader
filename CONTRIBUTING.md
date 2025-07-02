# Contributing Guidelines

Thanks for considering contributing to **FolderOffloader Kit for macOS**!

This is a clean, focused toolset meant for reliable folder offloading using symbolic links. If you find a bug, want to add a safety feature, or improve cross-version support, please follow the steps below.

## How to Contribute

1. Fork this repository
2. Create a new branch: `git checkout -b your-feature-name`
3. Make your changes and test on macOS (preferably Ventura+)
4. Commit clearly: `git commit -m "Fix: handles nested symlink edge case"`
5. Push your branch: `git push origin your-feature-name`
6. Submit a Pull Request

## Rules

- Stick to bash (no Python or binaries)
- Avoid adding complexity unless it improves safety
- All destructive actions must be user-confirmed or safely reversible

Thanks again!
