: "${PREFIX:=/data/data/com.termux/files/usr}"
export PREFIX
export SVDIR=${SVDIR:-$PREFIX/var/service}
export LOGDIR=${LOGDIR:-$PREFIX/var/log}

if command -v service-daemon >/dev/null 2>&1; then
    service-daemon start >/dev/null 2>&1 &
fi
