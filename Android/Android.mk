LOCAL_PATH := $(SRCROOT)/$(PRODUCT_NAME)

include $(CLEAR_VARS)

TARGET_PLATFORM=$(ANDROID_TARGET_PLATFORM)

LOCAL_MODULE := $(PRODUCT_NAME)

LOCAL_SRC_FILES := \
  $(ANDROID_SOURCES)

LOCAL_C_INCLUDES := \
	$(HEADER_SEARCH_PATHS)

# Uncomment this line if you want to use C++ exceptions
# LOCAL_CPPFLAGS += -frtti -fexceptions

LOCAL_STATIC_LIBRARIES :=

LOCAL_LDLIBS += -llog

# Make sure the entry points into the external are referenced.
LOCAL_LDFLAGS += \
	-Wl,-u,MCExternalDescribe \
	-Wl,-u,MCExternalInitialize \
 	-Wl,-u,MCExternalFinalize

include $(BUILD_SHARED_LIBRARY)
