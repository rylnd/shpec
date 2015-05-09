PREFIX    ?= /usr/local
BINDIR    ?= $(PREFIX)/bin

all: shpec

release:
	sed -i '' "s/^\( *\)VERSION=.*/\1VERSION=`cat VERSION`/" bin/shpec install.sh
	sed -i '' "s/^\( *\)\"version\":.*/\1\"version\": \"`cat VERSION`\",/" package.json
	git add install.sh bin/shpec package.json VERSION
	git commit -m "Release `cat VERSION`" || true
	git push origin master
	git tag `cat VERSION`
	git push --tags

install:
	mkdir -p $(BINDIR)
	install bin/shpec $(BINDIR)/

uninstall:
	rm -f $(BINDIR)/shpec
