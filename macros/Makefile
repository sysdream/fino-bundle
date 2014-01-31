# Build all our macros

OBJECTS = $(wildcard */*.macro)
MACROS = $(addprefix macro/, $(subst .macro,.class,$(OBJECTS)))

default: build-macros

build-macros: $(MACROS)

clean-macros: $(addprefix clean,$(MACROS))

macro/%:
	$(MAKE) APK_CLASS=$(notdir $*) -e -C $(dir $*) all

cleanmacro/%:
	$(MAKE) -C $(dir $*) clean

