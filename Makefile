VERSION := $(shell cat .version )

PROGNAME = rsaenc
PROGNAME_VERSION = $(PROGNAME)-$(VERSION)
TARGZ_FILENAME = $(PROGNAME)-$(VERSION).tar.gz
TARGZ_CONTENTS = rsaenc README.md Makefile .version

PREFIX = /opt/rsaenc

.PHONY: all version build clean install

$(TARGZ_FILENAME):
	tar -zvcf "$(TARGZ_FILENAME)" "$(PROGNAME_VERSION)"

build:
	mkdir -vp "$(PROGNAME_VERSION)"
	cp -v $(TARGZ_CONTENTS) "$(PROGNAME_VERSION)/"
	sed -i"" -e "s/VERSION=.*/VERSION='$(VERSION)'/" "$(PROGNAME_VERSION)/rsaenc"
	[ -f "$(PROGNAME_VERSION)/rsaenc-e" ] && rm "$(PROGNAME_VERSION)/rsaenc-e" || :

compress: $(TARGZ_FILENAME)

version:
	@echo "Version: $(VERSION)"

clean:
	rm -vfr "$(PROGNAME_VERSION)"
	rm -vf "$(TARGZ_FILENAME)"

install:
	install -d $(DESTDIR)$(PREFIX)
	install -m 755 rsaenc $(DESTDIR)/usr/bin
	install -m 644 README.md $(DESTDIR)/usr/share/doc/$(PROGNAME_VERSION)

