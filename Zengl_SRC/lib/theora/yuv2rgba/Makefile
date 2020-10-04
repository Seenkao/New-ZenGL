iOS_GCC=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.2
iOS_SYSROOT=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.2.sdk
ANDROID_GCC=$(ANDROID_NDK)/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc

linux:
	gcc yuv2bgr16tab.c -c -o../i386-linux/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv420rgb8888.c -c -o../i386-linux/yuv420rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv422rgb8888.c -c -o../i386-linux/yuv422rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv444rgb8888.c -c -o../i386-linux/yuv444rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv2bgr16tab.c -c -o../x86_64-linux/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99 -m64 -fPIC
	gcc yuv420rgb8888.c -c -o../x86_64-linux/yuv420rgb8888.o -O2 -s -ffast-math -std=c99 -m64 -fPIC
	gcc yuv422rgb8888.c -c -o../x86_64-linux/yuv422rgb8888.o -O2 -s -ffast-math -std=c99 -m64 -fPIC
	gcc yuv444rgb8888.c -c -o../x86_64-linux/yuv444rgb8888.o -O2 -s -ffast-math -std=c99 -m64 -fPIC

android:
	$(ANDROID_GCC) yuv2bgr16tab.c -c -o../arm-linux/yuv2bgr16tab.o -O2 -s -marm -march=armv5 -Xassembler "-meabi=5" -ffast-math -std=c99 -I$(ANDROID_NDK)/platforms/android-3/arch-arm/usr/include
	$(ANDROID_GCC) yuv420rgb8888.s -c -o../arm-linux/yuv420rgb8888.o -O2 -s -marm -march=armv5 -Xassembler "-meabi=5" -ffast-math -std=c99 -I$(ANDROID_NDK)/platforms/android-3/arch-arm/usr/include
	$(ANDROID_GCC) yuv422rgb8888.s -c -o../arm-linux/yuv422rgb8888.o -O2 -s -marm -march=armv5 -Xassembler "-meabi=5" -ffast-math -std=c99 -I$(ANDROID_NDK)/platforms/android-3/arch-arm/usr/include
	$(ANDROID_GCC) yuv444rgb8888.s -c -o../arm-linux/yuv444rgb8888.o -O2 -s -marm -march=armv5 -Xassembler "-meabi=5" -ffast-math -std=c99 -I$(ANDROID_NDK)/platforms/android-3/arch-arm/usr/include

win32:
	i486-mingw32-gcc yuv2bgr16tab.c -c -o../i386-win32/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99 -march=i686
	i486-mingw32-gcc yuv420rgb8888.c -c -o../i386-win32/yuv420rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686
	i486-mingw32-gcc yuv422rgb8888.c -c -o../i386-win32/yuv422rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686
	i486-mingw32-gcc yuv444rgb8888.c -c -o../i386-win32/yuv444rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686

win64:
	x86_64-w64-mingw32-gcc yuv2bgr16tab.c -c -o../x86_64-win64/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99
	x86_64-w64-mingw32-gcc yuv420rgb8888.c -c -o../x86_64-win64/yuv420rgb8888.o -O2 -s -ffast-math -std=c99
	x86_64-w64-mingw32-gcc yuv422rgb8888.c -c -o../x86_64-win64/yuv422rgb8888.o -O2 -s -ffast-math -std=c99
	x86_64-w64-mingw32-gcc yuv444rgb8888.c -c -o../x86_64-win64/yuv444rgb8888.o -O2 -s -ffast-math -std=c99

wince:
	arm-wince-cegcc-gcc yuv2bgr16tab.c -c -o../arm-wince/yuv2bgr16tab.o -I./ -O2 -s -ffast-math
	arm-wince-cegcc-gcc yuv420rgb8888.c -c -o../arm-wince/yuv420rgb8888.o -I./ -O2 -s -ffast-math
	arm-wince-cegcc-gcc yuv422rgb8888.c -c -o../arm-wince/yuv422rgb8888.o -I./ -O2 -s -ffast-math
	arm-wince-cegcc-gcc yuv444rgb8888.c -c -o../arm-wince/yuv444rgb8888.o -I./ -O2 -s -ffast-math

macos:
	gcc yuv2bgr16tab.c -c -o../i386-darwin/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv420rgb8888.c -c -o../i386-darwin/yuv420rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv422rgb8888.c -c -o../i386-darwin/yuv422rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv444rgb8888.c -c -o../i386-darwin/yuv444rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	powerpc-apple-darwin10-gcc-4.2.1 yuv2bgr16tab.c -c -o../powerpc-darwin/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99
	powerpc-apple-darwin10-gcc-4.2.1 yuv420rgb8888.c -c -o../powerpc-darwin/yuv420rgb8888.o -O2 -s -ffast-math -std=c99
	powerpc-apple-darwin10-gcc-4.2.1 yuv422rgb8888.c -c -o../powerpc-darwin/yuv422rgb8888.o -O2 -s -ffast-math -std=c99
	powerpc-apple-darwin10-gcc-4.2.1 yuv444rgb8888.c -c -o../powerpc-darwin/yuv444rgb8888.o -O2 -s -ffast-math -std=c99

ios:
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv6 yuv2bgr16tab.c -c -o../arm-darwin/yuv2bgr16tab_armv6.o -O2 -s -ffast-math -std=c99
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv7 yuv2bgr16tab.c -c -o../arm-darwin/yuv2bgr16tab_armv7.o -O2 -s -ffast-math -std=c99
	lipo -create ../arm-darwin/yuv2bgr16tab_armv6.o ../arm-darwin/yuv2bgr16tab_armv7.o -output ../arm-darwin/yuv2bgr16tab.o
	rm -f ../arm-darwin/yuv2bgr16tab_armv6.o
	rm -f ../arm-darwin/yuv2bgr16tab_armv7.o
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv6 yuv420rgb8888.c -c -o../arm-darwin/yuv420rgb8888_armv6.o -O2 -s -ffast-math -std=c99
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv7 yuv420rgb8888.c -c -o../arm-darwin/yuv420rgb8888_armv7.o -O2 -s -ffast-math -std=c99
	lipo -create ../arm-darwin/yuv420rgb8888_armv6.o ../arm-darwin/yuv420rgb8888_armv7.o -output ../arm-darwin/yuv420rgb8888.o
	rm -f ../arm-darwin/yuv420rgb8888_armv6.o
	rm -f ../arm-darwin/yuv420rgb8888_armv7.o
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv6 yuv422rgb8888.c -c -o../arm-darwin/yuv422rgb8888_armv6.o -O2 -s -ffast-math -std=c99
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv7 yuv422rgb8888.c -c -o../arm-darwin/yuv422rgb8888_armv7.o -O2 -s -ffast-math -std=c99
	lipo -create ../arm-darwin/yuv422rgb8888_armv6.o ../arm-darwin/yuv422rgb8888_armv7.o -output ../arm-darwin/yuv422rgb8888.o
	rm -f ../arm-darwin/yuv422rgb8888_armv6.o
	rm -f ../arm-darwin/yuv422rgb8888_armv7.o
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv6 yuv444rgb8888.c -c -o../arm-darwin/yuv444rgb8888_armv6.o -O2 -s -ffast-math -std=c99
	$(iOS_GCC) -isysroot$(iOS_SYSROOT) -arch armv7 yuv444rgb8888.c -c -o../arm-darwin/yuv444rgb8888_armv7.o -O2 -s -ffast-math -std=c99
	lipo -create ../arm-darwin/yuv444rgb8888_armv6.o ../arm-darwin/yuv444rgb8888_armv7.o -output ../arm-darwin/yuv444rgb8888.o
	rm -f ../arm-darwin/yuv444rgb8888_armv6.o
	rm -f ../arm-darwin/yuv444rgb8888_armv7.o
	gcc yuv2bgr16tab.c -c -o../i386-iphonesim/yuv2bgr16tab.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv420rgb8888.c -c -o../i386-iphonesim/yuv420rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv422rgb8888.c -c -o../i386-iphonesim/yuv422rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc yuv444rgb8888.c -c -o../i386-iphonesim/yuv444rgb8888.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
