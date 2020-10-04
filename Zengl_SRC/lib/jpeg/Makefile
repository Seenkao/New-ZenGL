linux:
	gcc jpeg_helper.c -c -oi386-linux/jpeg_helper.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	gcc jpeg_helper.c -c -ox86_64-linux/jpeg_helper.o -O2 -s -ffast-math -std=c99 -m64 -fPIC

win32:
	i486-mingw32-gcc jpeg_helper.c -c -oi386-win32/jpeg_helper.o -O2 -s -ffast-math -std=c99 -march=i686

win64:
	x86_64-w64-mingw32-gcc jpeg_helper.c -c -ox86_64-win64/jpeg_helper.o -O2 -s -ffast-math -std=c99

macos:
	gcc jpeg_helper.c -c -oi386-darwin/jpeg_helper.o -O2 -s -ffast-math -std=c99 -march=i686 -m32
	powerpc-apple-darwin10-gcc-4.2.1 jpeg_helper.c -c -oi386-darwin/jpeg_helper.o -O2 -s -ffast-math -std=c99 -m32
