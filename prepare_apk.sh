#!/bin/sh

# prepare the directory structure
rm -rf /tmp/patch
mkdir -p /tmp/patch

# disassemble original apk and injected apk
echo "Preparing APK for injection ..."
apktool d resources/injector.apk /tmp/patch/injector 1>/dev/null 2>/dev/null
apktool d $1 /tmp/patch/orig 1>/dev/null 2>/dev/null

# injecting introspection classes
echo "Injecting Fino service ..."
cp -r /tmp/patch/injector/smali/* /tmp/patch/orig/smali/

# insert the service
sed -s -i -e 's/<\/application>/<service android:name="com.sysdream.fino.InspectionService" android:enabled="true" android:exported="true"><intent-filter><action android:name="com.sysdream.fino.inspection"\/><\/intent-filter><\/service><\/application>/' /tmp/patch/orig/AndroidManifest.xml

# fix sdk versions
sed -i -e 's/<uses-sdk[^>]+>/<uses-sdk android:minSdkVersion="14" android:targetSdkVersion="15" \/>/' /tmp/patch/orig/AndroidManifest.xml

# build the unsigned apk
echo "Rebuilding the APK ..."
apktool b /tmp/patch/orig /tmp/patch/tmp.apk 1>/dev/null 2>/dev/null

# sign the final apk
jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore fino.keystore -storepass finopass -signedjar $2 /tmp/patch/tmp.apk finokey 1>/dev/null 2>/dev/null

echo "Done"
