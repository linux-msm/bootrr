.PHONY: all

all:

all-install :=

HELPERS := assert_file_is_empty \
           assert_device_present \
           assert_driver_present \
	   assert_mmc_present \
	   assert_partition_found \
	   assert_sysfs_attr_present \
	   bootrr \
	   bootrr-auto \
	   ensure_lib_firmware \
	   rproc-start \
	   rproc-stop \
	   value_in_range \
	   state_check

BOARDS := arrow,apq8096-db820c \
	  google,kevin \
	  google,pi \
	  google,veyron-jaq \
	  qcom,apq8016-sbc \
	  qcom,msm8998-mtp \
	  qcom,sdm845-mtp \
	  qcom,qcs404-evb \
	  sony,xperia-castor

define add-scripts
$(DESTDIR)$(prefix)/$1/$2: $1/$2
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$(prefix)/$1/$2
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,boards,$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,helpers,$v)))

install: $(all-install)

clean:
