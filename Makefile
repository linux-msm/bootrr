.PHONY: all

all:

all-install :=

DESTDIR ?= dest
CPIONAME ?= bootrr

HELPERS := assert_file_is_empty \
           assert_device_present \
           assert_driver_present \
	   assert_mmc_present \
	   assert_partition_found \
	   assert_soundcard_present \
	   assert_sysfs_attr_present \
	   assert_cpufreq_enabled \
	   assert_cpuidle_enabled \
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
	  qcom,sm8150-mtp \
	  qcom,sm8250-mtp \
	  qcom,qrb5165-rb5 \
	  qcom,qcs404-evb \
	  sony,xperia-castor \
	  thundercomm,db845c

define add-scripts
$(DESTDIR)$(prefix)/bin/$2: $1/$2
	@echo "INSTALL $$<"
	@install -D -m 755 $$< $$@

all-install += $(DESTDIR)$(prefix)/bin/$2
endef

$(foreach v,${BOARDS},$(eval $(call add-scripts,boards,$v)))
$(foreach v,${HELPERS},$(eval $(call add-scripts,helpers,$v)))

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
