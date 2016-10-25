#!/bin/bash

export DEBUGGABLE_FLAG=false
export DEBUG_FLAG=0
export ANDROID=1

JAVA_SDK=`/usr/libexec/java_home`
JCOUNT=4

ENGINE_CLASSPATH=$LIVECODE_REPO_ROOT/build-android-armv6/livecode/out/$CONFIGURATION/Classes-Community.jar

if [[ ! -f "$ENGINE_CLASSPATH" ]]; then
	ENGINE_CLASSES_FILE=$LIVECODE_REPO_ROOT/build-android-armv6/livecode/out/$CONFIGURATION/Classes-Community
	if [[ ! -f "$ENGINE_CLASSES_FILE" ]]; then
		echo "Could not find LiveCode Classes. Build the android engine."
		exit 1
	fi
	cp "$ENGINE_CLASSES_FILE" "$ENGINE_CLASSPATH"
fi

CLASSPATH="$ENGINE_CLASSPATH:$ANDROID_SDK_ROOT/platforms/$ANDROID_TARGET_PLATFORM/android.jar:$SRCROOT/$PRODUCT_NAME/libs"
NDKBUILD=$ANDROID_NDK_ROOT/ndk-build

JAVAC=$JAVA_SDK/bin/javac
JAR=$JAVA_SDK/bin/jar

mkdir -p "$BUILT_PRODUCTS_DIR/native"

if [[ -f "$SRCROOT/$PRODUCT_NAME/$PRODUCT_NAME.lcidl" ]]; then
	echo "Building external stubs…"
	mkdir -p "$SRCROOT/$PRODUCT_NAME/derived"
	lcidlc "$SRCROOT/$PRODUCT_NAME/$PRODUCT_NAME.lcidl" "$SRCROOT/$PRODUCT_NAME/derived/"

	ANDROID_SOURCES="derived/$PRODUCT_NAME.lcidl.cpp $ANDROID_SOURCES"
fi

echo "Building native code components…"
$NDKBUILD ANDROID_SOURCES="$ANDROID_SOURCES" NDK_DEBUG=$DEBUG_FLAG NDK_APP_DEBUGGABLE=$DEBUGGABLE_FLAG NDK_APPLICATION_MK="$NDK_APPLICATION_MK" APP_BUILD_SCRIPT="$APP_BUILD_SCRIPT" NDK_PROJECT_PATH="$BUILT_PRODUCTS_DIR/native" APP_PLATFORM="$ANDROID_TARGET_PLATFORM" -j $JCOUNT -s
if [ $? != 0 ]; then
	exit $?
fi

mkdir -p "$SRCROOT/binaries/Android"
if [[ -f "$SRCROOT/$PRODUCT_NAME/$PRODUCT_NAME.java" ]]; then
	echo "Building java classes components…"
	mkdir -p "$BUILT_PRODUCTS_DIR/classes"
	"$JAVAC" -target 1.5 -source 1.5 -Xlint:none -d "$BUILT_PRODUCTS_DIR/classes" -cp "$CLASSPATH" -sourcepath "$SRCROOT/$PRODUCT_NAME" "$SRCROOT/$PRODUCT_NAME/$PRODUCT_NAME.java" "$SRCROOT/$PRODUCT_NAME/derived/LC.java"
	if [ $? != 0 ]; then
		exit $?
	fi

	echo "Building jar…"
	"$JAR" cf "$SRCROOT/binaries/Android/Classes" -C "$BUILT_PRODUCTS_DIR/classes" .
	if [ $? != 0 ]; then
		exit $?
	fi
fi

echo "Building lcext archive…"
cp "$BUILT_PRODUCTS_DIR/native/libs/armeabi/lib$PRODUCT_NAME.so" "$SRCROOT/binaries/Android/External-armeabi"

if [[ -d "$SRCROOT/libs" ]]; then
	cp -r "$SRCROOT/libs/." "$SRCROOT/binaries/Android"
fi

cd $SRCROOT/binaries

zip -Rm $PRODUCT_NAME.lcext Android/*
