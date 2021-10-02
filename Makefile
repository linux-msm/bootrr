.PHONY: all

all:

all-install :=

DESTDIR ?= dest
CPIONAME ?= bootrr

HELPERS := $(wildcard helpers/*)

BOARDS := $(wildcard boards/*)

define add-scripts
$(DESTDIR)$(prefix)/bin/$(notdir $1): $1
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$(prefix)/bin/$(notdir $1)
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,$v)))

install: $(all-install)

CPIO := $(PWD)/$(CPIONAME).cpio

$(CPIO): $(all-install)
	@cd $(DESTDIR) && find ./$(prefix)/bin | cpio -o -H newc > $(CPIO)

%.cpio.gz: %.cpio
	@gzip < $< > $@

cpio: $(CPIO)

cpio.gz: $(CPIO).gz

clean:
	@rm -f $(CPIO) $(CPIO).gz
