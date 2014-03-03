SDK_PATH=../../sdk
DX=$(SDK_PATH)/build-tools/android-4.4/dx
JAVAC=javac
JAVA_TARGET=-target 1.7 -source 1.7
ANDROID_LIB=$(SDK_PATH)/platforms/$(ANDROID_TARGET)/android.jar
.SUFFIXES: .java .class .apk
.java.class:
	@echo " JAVAC $*.class"
	@$(JAVAC) $(JAVA_TARGET) -classpath "$(CURDIR):$(ANDROID_LIB)" $*.java

.class.apk:
	@echo " DEX   $*.apk"
	@$(DX) --dex --output=$*.apk $*.class


##################################################
# Set here the path of every java file to compile
##################################################

OBJECTS= Replay.java


###################################################
# DEFAULT RECIPES FOR BUILDING MACROS, LEAVE AS IS
###################################################

default:	all

all:	build-dex $(APK_CLASS:.class=.apk)

macros/deepinspect: all

build-dex:	compile-java

compile-java: $(OBJECTS:.java=.class)

clean:
	@echo " > Cleaning $(basename $(APK_CLASS)) ..."
	-@rm *.class 1>/dev/null 2>/dev/null
	-@rm *.apk 1>/dev/null 2>/dev/null


