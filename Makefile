.PHONY: all

all:

all-install :=

HELPERS := assert_device_present \
           assert_driver_present \
	   assert_mmc_present \
	   assert_partition_found \
	   ensure_lib_firmware \
	   rproc-start \
	   rproc-stop

BOARDS := arrow,apq8096-db820c \
	  qcom,apq8016-sbc

define add-scripts
$(DESTDIR)$(prefix)/bin/$1: $1
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$(prefix)/bin/$1
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,$v)))

install: $(all-install)

clean:
