#!/bin/sh
# Install the aws wrapper into ~/.local/bin — by copy, never by symlink.
set -eu

src_dir=$(dirname -- "$(readlink -f -- "$0")")
target_dir="$HOME/.local/bin"
target="$target_dir/aws"

mkdir -p "$target_dir"

# Never write through a symlink: its target lives in another repo, and `cp`
# would silently overwrite that file instead of replacing the link.
if [ -L "$target" ]; then
  echo "replacing symlink $target"
  rm -f "$target"
elif [ -f "$target" ] && ! cmp -s "$src_dir/aws" "$target"; then
  echo "existing $target differs — backing it up to aws.bak"
  cp -p "$target" "$target.bak"
fi

cp -f "$src_dir/aws" "$target"
chmod +x "$target"
echo "installed: $target"

echo "pulling the pinned image (already present = no-op)"
podman pull docker.io/amazon/aws-cli:2.36.50

echo
echo "verify:  aws --version"
echo "note:    $target_dir must precede /usr/bin on PATH"
