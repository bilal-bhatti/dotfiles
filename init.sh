#!/bin/sh

echo "Setting up your Mac..."

# Remove junk files
find ./ -name ".DS_Store" -depth -exec rm {} \;

stow home --no-folding


