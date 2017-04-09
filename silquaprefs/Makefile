include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SilquaPrefs
SilquaPrefs_FILES = SiliquaPrefsRootListController.m DoubleTapListController.m QuadTapListController.m
SilquaPrefs_INSTALL_PATH = /Library/PreferenceBundles
SilquaPrefs_FRAMEWORKS = UIKit
SilquaPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SilquaPrefs.plist$(ECHO_END)
