SDK_PATH=sdk
MACROS=$(wildcard macros/*/*.apk)
ANDROID_TARGET=$(notdir $(firstword $(wildcard $(SDK_PATH)/platforms/*)))

.PHONY: macros clean update keystore install

install: update keystore macros

macros:
	$(MAKE) ANDROID_TARGET=$(ANDROID_TARGET) -C macros build-macros

update:
	@tools/update_sdk

clean: $(MACROS_OBJECTS)
	$(MAKE) -C macros clean-macros

keystore:
	@rm -f fino.keystore
	@echo "Please answer the following questions:"
	@keytool -genkey -v -keystore fino.keystore -alias finokey -storepass finopass -keypass finopass -keyalg RSA -validity 14000

