ifeq ($(shell uname -m), x86_64)
  ARCH  = arm
else
  ARCH  = arm
endif
FPC	= /home/mirrel/fpc_3_2/fpc/bin/x86_64-linux/ppcrossarm
INCLUDE	= -Fi../../../../headers -Fi../../../../android -Fu../../../../src -Fu../../../../srcGEGL -Fi../../../../src -Fi../../../../srcGEGL -Fu../../../../extra
LIB	= -Fu../../../../lib/zip/arm-linux -Fu../../../../lib/zlib/arm-linux
FLAGS	= -O3 -XsX -CX -Sdghi
UNIT	= demo05.pas
TARGET	= demo05
TMP	= ../tmp/
OUTPUT	= lib/arm-android/

# Targets
all: clean
	$(FPC) $(UNIT) $(INCLUDE) $(LIB) -Tandroid -Parm -CpARMv6 -FE$(OUTPUT) -FU$(TMP) $(FLAGS) -o$(TARGET) $(OUTPUT)

clean:
	rm -f *.*~
	rm -f $(TMP)*.*

/home/mirrel/fpc_3_2/fpc/bin/x86_64-linux/ppcrossarm demo05.pas \
-Fi../../../../headers -Fi../../../../android -Fu../../../../src \
-Fu../../../../srcGEGL -Fi../../../../src -Fi../../../../srcGEGL \
-Fu../../../../extra -Fu../../../../lib/zip/arm-linux -Fu../../../../lib/zlib/arm-linux \
-Tandroid -Parm -CpARMv6 -al
