PREFIX ?= /data/data/com.termux/files/usr
DESTDIR ?=
INSTALL ?= install

BINDIR = $(DESTDIR)$(PREFIX)/bin
PROFILEDIR = $(DESTDIR)$(PREFIX)/etc/profile.d
FISHDIR = $(DESTDIR)$(PREFIX)/etc/fish/conf.d
SHAREDIR = $(DESTDIR)$(PREFIX)/share/termux-services

SCRIPTS = sv-enable sv-disable service-daemon

termux-services:

install: termux-services
	$(INSTALL) -d $(BINDIR) $(PROFILEDIR) $(FISHDIR) $(SHAREDIR)
	$(INSTALL) -m 0755 $(SCRIPTS) $(BINDIR)/
	$(INSTALL) -m 0644 start-services.sh $(PROFILEDIR)/
	$(INSTALL) -m 0644 start-services.fish $(FISHDIR)/
	$(INSTALL) -m 0755 svlogger $(SHAREDIR)/

uninstall:
	rm -f $(BINDIR)/sv-enable
	rm -f $(BINDIR)/sv-disable
	rm -f $(BINDIR)/service-daemon
	rm -f $(PROFILEDIR)/start-services.sh
	rm -f $(FISHDIR)/start-services.fish
	rm -rf $(SHAREDIR)

check:
	sh -n sv-enable sv-disable service-daemon start-services.sh svlogger
	sh tests/smoke.sh

.PHONY: termux-services install uninstall check
