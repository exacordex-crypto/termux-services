# How to run services with runit on Termux

`termux-services` wires Termux login shells to `runsvdir`, so services placed in
`$PREFIX/var/service` can be managed by runit.

## Use

1. Install termux-services with `pkg install termux-services`.
2. Restart your login shell so that `service-daemon` is started.
3. Enable a service with `sv-enable <service>`, or start it manually with
   `sv up <service>`.
4. Check `$PREFIX/var/log/sv/<service>/current` when debugging service failures.

Stop services with `sv down <service>`, or disable autostart with
`sv-disable <service>`. A service is disabled when
`$PREFIX/var/service/<service>/down` exists.

## Build and validation

Run the local checks before packaging:

```sh
make check
```

Create a staged install tree without touching the host prefix:

```sh
make install DESTDIR="$PWD/stage"
```

The CI workflow validates the shell scripts, stages the install tree, creates a
`termux-services.tar.gz` package, writes a SHA-256 checksum, and uploads both as
artifacts.
