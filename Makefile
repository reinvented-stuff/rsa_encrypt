VERSION := $(shell cat .version )

PROGNAME = rsaenc
PROGNAME_VERSION = $(PROGNAME)-$(VERSION)
TARGZ_FILENAME = $(PROGNAME)-$(VERSION).tar.gz
TARGZ_CONTENTS = rsaenc README.md Makefile .version

PREFIX = /opt/rsaenc
PWD = $(shell pwd)

export PROGROOT=$(PWD)/$(PROGNAME_VERSION)

.PHONY: all version build clean install test

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

test:
	./.test/10_list_keys.sh
	./.test/20_generate_keypairs.sh
	./.test/30_import_private_keys.sh
	./.test/40_import_public_keys.sh
	./.test/50_encrypt_message.sh
	./.test/60_decrypt_message.sh
	./.test/70_delete_private_keys.sh
	./.test/80_delete_public_keys.sh
# 	./.test/9000_cleanup.sh
# 	rm -v .artifacts

install:
	install -d $(DESTDIR)/usr/share/doc/$(PROGNAME_VERSION)
	install -d $(DESTDIR)/usr/bin
	install -m 755 rsaenc $(DESTDIR)/usr/bin
	install -m 644 README.md $(DESTDIR)/usr/share/doc/$(PROGNAME_VERSION)

