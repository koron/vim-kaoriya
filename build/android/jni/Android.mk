LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_ARCH_ABI	:= armeabi-v7a
TARGET_PLATFORM	:= android-9

LOCAL_MODULE	:= vim
LOCAL_SRC_FILES	:= main.c

include $(BUILD_EXECUTABLE)
