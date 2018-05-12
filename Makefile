.PHONY: all

all:

all-install :=

HELPERS := assert_device_present \
           assert_driver_present \
	   assert_mmc_present \
	   assert_partition_found \
	   bootrr \
	   ensure_lib_firmware \
	   rproc-start \
	   rproc-stop

BOARDS := arrow,apq8096-db820c \
	  qcom,apq8016-sbc \
	  qcom,msm8998-mtp \
	  qcom,sdm845-mtp \
	  sony,xperia-castor

define add-scripts
$(DESTDIR)$(prefix)/bin/$2: $1/$2
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$(prefix)/bin/$2
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,boards,$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,helpers,$v)))

install: $(all-install)

clean:
