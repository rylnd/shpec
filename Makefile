PREFIX    ?= /usr/local
INSTALL   ?= install
MKDIR     ?= $(INSTALL) -d
BINDIR    ?= $(PREFIX)/bin
DESTDIR   ?=

all: shpec

release:
	cat install.sh | sed "s/VERSION=.*/VERSION=`cat VERSION`/" > install.sh
	git add install.sh
	[ -n "`git status --porcelain`" ] && git commit -m "make release" || true
	git push origin master
	git tag `cat VERSION`
	git push --tags

install:
	$(INSTALL) bin/shpec $(DESTDIR)$(BINDIR)/

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/shpec
