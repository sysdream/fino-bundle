SDK_PATH=../../sdk
DX=$(SDK_PATH)/build-tools/android-4.4W/dx
JAVAC=javac
JAVA_TARGET=-target 1.7 -source 1.7
ANDROID_LIB=$(SDK_PATH)/platforms/$(ANDROID_TARGET)/android.jar

OBJECTS= MyMacro.java

.SUFFIXES: .java .class .apk

.java.class:
	@echo " JAVAC $*.class"
	@$(JAVAC) $(JAVA_TARGET) -classpath "$(CURDIR):$(ANDROID_LIB)" $*.java

.class.apk:
	@echo " DEX   $*.apk"
	@$(DX) --dex --output=$*.apk $*.class


default:	all

all:	build-dex $(APK_CLASS:.class=.apk)

build-dex:	compile-java

compile-java: $(OBJECTS:.java=.class)

clean:
	@echo " > Cleaning $(MACRO_NAME) ..."
	-@rm *.class 1>/dev/null 2>/dev/null
	-@rm *.apk 1>/dev/null 2>/dev/null


