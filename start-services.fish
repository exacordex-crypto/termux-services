if status --is-login
    if not set -q PREFIX
        set -gx PREFIX /data/data/com.termux/files/usr
    end
    if not set -q SVDIR
        set -gx SVDIR $PREFIX/var/service
    end
    if not set -q LOGDIR
        set -gx LOGDIR $PREFIX/var/log
    end
    if type -q service-daemon
        service-daemon start >/dev/null 2>&1 &
    end
end
