################################################################################
#
# AFL
#
################################################################################

AFL_VERSION = 61037103ae3722c8060ff7082994836a794f978e
AFL_SITE = https://github.com/google/AFL.git
AFL_SITE_METHOD = git

AFL_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	AFL_NO_X86=1

define AFL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(AFL_MAKE_OPTS)
endef

AFL_TARGET_DIR = \
	$(TARGET_DIR)/opt/afl

PROGS = $(@D)/afl-gcc $(@D)/afl-fuzz $(@D)/afl-showmap $(@D)/afl-tmin $(@D)/afl-gotcpu $(@D)/afl-analyze
SH_PROGS = $(@D)/afl-plot $(@D)/afl-cmin $(@D)/afl-whatsup

define AFL_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 755 \
		$(AFL_TARGET_DIR)/bin \
		$(AFL_TARGET_DIR)/lib/afl \
		$(AFL_TARGET_DIR)/share/doc/afl \
		$(AFL_TARGET_DIR)/share/afl
	$(INSTALL) -m 755 $(PROGS) $(SH_PROGS) $(AFL_TARGET_DIR)/bin
	$(INSTALL) -m 755 $(@D)/afl-as $(AFL_TARGET_DIR)/lib/afl
	ln -sf afl-as $(AFL_TARGET_DIR)/lib/afl/as
	$(INSTALL) -m 644 $(@D)/README.md $(@D)/docs/ChangeLog $(@D)/docs/*.txt $(AFL_TARGET_DIR)/share/doc/afl
	cp -r $(@D)/dictionaries/ $(AFL_TARGET_DIR)/share/afl
endef

$(eval $(generic-package))
