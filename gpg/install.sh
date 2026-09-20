#!/usr/bin/env sh
# Install the repo's GnuPG agent config (common.conf, gpg-agent.conf) as the live
# configs (no symlinks). Key material — private-keys-v1.d/, public-keys.d/,
# trustdb.gpg, openpgp-revocs.d/ — is never touched by this script.
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="${GNUPGHOME:-$HOME/.gnupg}"

if [ ! -d "$DEST" ]; then
    echo "error: $DEST does not exist — run gpg once first" >&2
    exit 1
fi

case "$(stat -c %a "$DEST")" in
    700) ;;
    *) echo "warning: $DEST is mode $(stat -c %a "$DEST") — GnuPG expects 700" >&2 ;;
esac

for f in common.conf gpg-agent.conf; do
    if [ -f "$DEST/$f" ] && ! cmp -s "$DIR/$f" "$DEST/$f"; then
        cp -p "$DEST/$f" "$DEST/$f.bak"
        echo "backed up $DEST/$f -> $f.bak"
    fi
    cp "$DIR/$f" "$DEST/$f"
    chmod 600 "$DEST/$f"
    echo "installed $DIR/$f -> $DEST/$f"
done

gpgconf --kill gpg-agent 2>/dev/null || true
echo "gpg-agent will restart with the new config on next use"
