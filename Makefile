PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

all: shpec

release:
	cat install.sh | sed "s/VERSION=.*/VERSION=`cat VERSION`/" > install.sh
	git add install.sh VERSION
	sed -i '' "s/^VERSION=.*/VERSION=`cat VERSION`/" bin/shpec
	[ -n "`git status --porcelain`" ] && git commit -m "Release `cat VERSION`" || true
	git push origin master
	git tag `cat VERSION`
	git push --tags

install:
	mkdir -p $(BINDIR)
	install bin/shpec $(BINDIR)/

uninstall:
	rm -f $(BINDIR)/shpec
