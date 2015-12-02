LOCAL_PATH := $(SRCROOT)/$(PRODUCT_NAME)

# only build if run from the revtestexternal/build-android.sh script
include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := $(PRODUCT_NAME)

LOCAL_SRC_FILES := \
  $(DERIVED_FILE_DIR)/$(LOCAL_MODULE).lcidl.cpp

LOCAL_C_INCLUDES := \
	$(LIVECODE_REPO_ROOT)/lcidlc/include \
	$(ANDROID_NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/include \
	$(ANDROID_NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/libs/$(TARGET_ARCH_ABI)/include

# Uncomment this line if you want to use C++ exceptions
# LOCAL_CPPFLAGS += -frtti -fexceptions

LOCAL_STATIC_LIBRARIES :=

LOCAL_LDLIBS += -llog
LOCAL_LDLIBS += $(call host-path,$(ANDROID_NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/libs/$(TARGET_ARCH_ABI)/libstdc++.a)

# Make sure the entry points into the external are referenced.
LOCAL_LDFLAGS += \
	-Wl,-u,MCExternalDescribe \
	-Wl,-u,MCExternalInitialize \
 	-Wl,-u,MCExternalFinalize

include $(BUILD_SHARED_LIBRARY)
