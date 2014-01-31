ARCH=$(shell getconf LONG_BIT)
SDK_PATH=sdk-$(ARCH)
MACROS=$(wildcard macros/*/*.macro)
ANDROID_TARGET=$(notdir $(firstword $(wildcard $(SDK_PATH)/platforms/*)))

install: update fino.keystore

macros: $(MACROS)
	@for m in $(MACROS); do \
		touch $$m; \
	done
	@export ANDROID_TARGET=$(ANDROID_TARGET)
	$(MAKE) -C macros build-macros

update:
	@tools/update_sdk

clean: $(MACROS_OBJECTS)
	$(MAKE) -C macros clean-macros

fino.keystore:
	@echo "No keystore found. Please answer the following questions:"
	@keytool -genkey -v -keystore fino.keystore -alias finokey -storepass finopass -keypass finopass -keyalg RSA -validity 14000

