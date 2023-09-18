iOS_GCC=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.2
iOS_SYSROOT=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk
ANDROID_GCC=$(ANDROID_NDK)/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc

linux:
	gcc zlib_helper.c -c -oi386-linux/zlib_helper.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc zlib_helper.c -c -ox86_64-linux/zlib_helper.o -O2 -s -ffast-math -std=c99 -m64 -fPIC

android:
	$(ANDROID_GCC) zlib_helper.c -c -oarm-linux/zlib_helper.o -O2 -s -marm -march=armv5 -Xassembler "-meabi=5" -ffast-math -std=c99 -I$(ANDROID_NDK)/platforms/android-3/arch-arm/usr/include

win32:
	i486-mingw32-gcc zlib_helper.c -c -oi386-win32/zlib_helper.o -O2 -s -ffast-math -std=c99 -march=i686

win64:
	x86_64-w64-mingw32-gcc zlib_helper.c -c -ox86_64-win64/zlib_helper.o -O2 -s -ffast-math -std=c99

wince:
	arm-wince-cegcc-gcc zlib_helper.c -c -oarm-wince/zlib_helper.o -I./ -O2 -s -ffast-math

macos:
	gcc zlib_helper.c -c -oi386-darwin/zlib_helper.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	powerpc-apple-darwin10-gcc-4.2.1 zlib_helper.c -c -opowerpc-darwin/zlib_helper.o -O2 -s -ffast-math -std=c99

ios:
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv6 zlib_helper.c -c -oarm-darwin/zlib_helper_armv6.o -O2 -s -ffast-math -std=c99
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv7 zlib_helper.c -c -oarm-darwin/zlib_helper_armv7.o -O2 -s -ffast-math -std=c99
	lipo -create arm-darwin/zlib_helper_armv6.o arm-darwin/zlib_helper_armv7.o -output arm-darwin/zlib_helper.o
	rm -f arm-darwin/zlib_helper_armv6.o
	rm -f arm-darwin/zlib_helper_armv7.o
	gcc zlib_helper.c -c -oi386-iphonesim/zlib_helper.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
