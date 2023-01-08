.PHONY: all

all:

all-install :=

DESTDIR ?= dest
CPIONAME ?= bootrr

HELPERS := $(wildcard helpers/*)

BOARDS := $(wildcard boards/*)

BINS := bin/bootrr bin/bootrr-generate-template

LIBEXEC_DIR ?= $(prefix)/libexec
BOOTRR_DIR = $(LIBEXEC_DIR)/bootrr

define add-scripts
$(DESTDIR)$1/$2: $2
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$1/$2
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,$(BOOTRR_DIR),$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,$(BOOTRR_DIR),$v)))
$(foreach v,${BINS},$(eval $(call add-scripts,$(prefix),$v)))

bin/bootrr: bin/bootrr.in Makefile
	@sed -e 's!@BOOTRR@!$(BOOTRR_DIR)!g' $< > $@.tmp
	@mv $@.tmp $@

install: $(all-install)

CPIO := $(PWD)/$(CPIONAME).cpio

$(CPIO): $(all-install)
	@cd $(DESTDIR) && find ./$(prefix) | cpio -o -H newc > $(CPIO)

%.cpio.gz: %.cpio
	@gzip < $< > $@

cpio: $(CPIO)

cpio.gz: $(CPIO).gz

clean:
	@rm -f $(CPIO) $(CPIO).gz bin/bootrr
