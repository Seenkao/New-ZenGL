# Get current platform
ifeq ($(shell uname -m), x86_64)
  ARCH  = x86_64
else
  ARCH  = i386
endif

# Get current OS
ifeq ($(shell uname), Linux)
  OS    = linux
else ifeq ($(shell uname), Darwin)
  OS    = darwin
  ARCH  = i386
endif

# Variables
FPC     = fpc
FLAGS   = -O3 -XsX -CX -Sd
INCLUDE = -Fu../../../headers -Fi../../../headers -Fu../../../extra -Fu../../../src
LIBS    = -Fu../../../lib/jpeg/$(ARCH)-$(OS) -Fu../../../lib/ogg/$(ARCH)-$(OS) -Fu../../../lib/theora/$(ARCH)-$(OS) -Fu../../../lib/zlib/$(ARCH)-$(OS) -Fu../../../lib/zip/$(ARCH)-$(OS)
LIBSPPC = -Fu../../../lib/jpeg/powerpc-$(OS) -Fu../../../lib/ogg/powerpc-$(OS) -Fu../../../lib/theora/powerpc-$(OS) -Fu../../../lib/zlib/powerpc-$(OS) -Fu../../../lib/zip/powerpc-$(OS)
OUTPUT  = ../../../bin/
TMP     = ../tmp/
UNIT    = demo03.pas
TARGET  = demo03
TARGETW = demo03.exe
TARGETM = demo03
BUNDLE  = $(OUTPUT)$(TARGETM).app

# Targets
all: clean
	$(FPC) $(UNIT) $(INCLUDE) $(LIBS) -FE$(OUTPUT)$(ARCH)-$(OS)/ -FU$(TMP) $(FLAGS) -o$(TARGET) -TLINUX
	strip $(OUTPUT)$(ARCH)-$(OS)/$(TARGET) --strip-unneeded -R .comment -R .note

linux32: clean
	$(FPC) $(UNIT) $(INCLUDE) \
	-Fu../../../lib/jpeg/i386-linux \
	-Fu../../../lib/ogg/i386-linux \
	-Fu../../../lib/theora/i386-linux \
	-Fu../../../lib/zlib/i386-linux \
	-Fu../../../lib/zip/i386-linux \
	-FE$(OUTPUT)i386-linux/ -FU$(TMP) $(FLAGS) -o$(TARGET) -TLINUX -Pi386 -Xd
	strip $(OUTPUT)i386-linux/$(TARGET) --strip-unneeded -R .comment -R .note

win32: clean
	$(FPC) $(UNIT) $(INCLUDE) \
	-Fu../../../lib/jpeg/i386-win32 \
	-Fu../../../lib/msvcrt/i386 \
	-Fu../../../lib/ogg/i386-win32 \
	-Fu../../../lib/theora/i386-win32 \
	-Fu../../../lib/zlib/i386-win32 \
	-Fu../../../lib/zip/i386-win32 \
	-FE$(OUTPUT)i386-win32/ -FU$(TMP) $(FLAGS) -o$(TARGETW) -TWIN32 -Pi386 -WG

win64: clean
	$(FPC) $(UNIT) $(INCLUDE) \
	-Fu../../../lib/jpeg/x86_64-win64 \
	-Fu../../../lib/msvcrt/x86_64 \
	-Fu../../../lib/ogg/x86_64-win64 \
	-Fu../../../lib/theora/x86_64-win64 \
	-Fu../../../lib/zlib/x86_64-win64 \
	-Fu../../../lib/zip/x86_64-win64 \
	-FE$(OUTPUT)x86_64-win64/ -FU$(TMP) $(FLAGS) -o$(TARGETW) -TWIN64 -Px86_64 -WG

macosx: clean
	rm -Rf $(BUNDLE)
	mkdir {$(BUNDLE),$(BUNDLE)/{Contents,Contents/{MacOS,Resources,Frameworks}}}
	$(FPC) $(UNIT) $(INCLUDE) $(LIBS) -FE$(OUTPUT) -FU$(TMP) $(FLAGS) -o$(TARGETM) -TDARWIN -Pi386 -k"-macosx_version_min" -k"10.4"
	mv $(OUTPUT)$(TARGETM) $(BUNDLE)/Contents/MacOS/
	sh macosx_postbuild.sh

macosx_uni: clean
	rm -Rf $(BUNDLE)
	mkdir {$(BUNDLE),$(BUNDLE)/{Contents,Contents/{MacOS,Resources,Frameworks}}}
	$(FPC) $(UNIT) $(INCLUDE) $(LIBS) -FE$(OUTPUT) -FU$(TMP) $(FLAGS) -o$(TARGETM)-386 -TDARWIN -Pi386 -k"-macosx_version_min" -k"10.4"
	$(FPC) $(UNIT) $(INCLUDE) $(LIBSPPC) -FE$(OUTPUT) -FU$(TMP) $(FLAGS) -o$(TARGETM)-ppc -TDARWIN -Ppowerpc -k"-macosx_version_min" -k"10.4"
	lipo -create $(OUTPUT)$(TARGETM)-ppc $(OUTPUT)$(TARGETM)-386 -output $(BUNDLE)/Contents/MacOS/$(TARGETM)
	rm $(OUTPUT)$(TARGETM)-386 $(OUTPUT)$(TARGETM)-ppc
	sh macosx_postbuild.sh

clean:
	rm -f *.*~
	rm -f $(TMP)*.*
