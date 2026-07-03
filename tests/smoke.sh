#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT INT TERM

mkdir -p "$tmp/bin" "$tmp/var/service/demo"
cat > "$tmp/bin/sv" <<'SV'
#!/bin/sh
printf '%s %s\n' "$1" "$2" >"$TMP_SV_CALL"
SV
chmod +x "$tmp/bin/sv"

PATH="$tmp/bin:$PATH" SVDIR="$tmp/var/service" TMP_SV_CALL="$tmp/call" sh "$root/sv-disable" demo >/dev/null
[ -f "$tmp/var/service/demo/down" ]
[ "$(cat "$tmp/call")" = 'down demo' ]

PATH="$tmp/bin:$PATH" SVDIR="$tmp/var/service" TMP_SV_CALL="$tmp/call" sh "$root/sv-enable" demo >/dev/null
[ ! -e "$tmp/var/service/demo/down" ]
[ "$(cat "$tmp/call")" = 'up demo' ]

if SVDIR= sh "$root/sv-enable" demo >/dev/null 2>"$tmp/err"; then
    exit 1
fi
case $(cat "$tmp/err") in
    *'SVDIR not set'*) : ;;
    *) exit 1 ;;
esac
