PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

all: shpec

release:
	cat install.sh | sed "s/VERSION=.*/VERSION=`cat VERSION`/" > install.sh
	git add install.sh
	[ -n "`git status --porcelain`" ] && git commit -m "make release" || true
	git push origin master
	git tag `cat VERSION`
	git push --tags

install:
	mkdir -p $(BINDIR)
	install bin/shpec $(BINDIR)/

uninstall:
	rm -f $(BINDIR)/shpec
