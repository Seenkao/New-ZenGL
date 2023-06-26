# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/x86/
cp ../../../../bin/Android/x86/libjpeg_turbo.so ../libs/x86/
cp ../../../../bin/Android/x86/libopenal.so ../libs/x86/
cp ../../../../bin/Android/x86/libogg.so ../libs/x86/
cp ../../../../bin/Android/x86/libvorbis.so ../libs/x86/
cp ../../../../bin/Android/x86/libtheoradec.so ../libs/x86/
cp ../../../../bin/Android/x86/libzip.so ../libs/x86/
#cp ../../../../bin/Android/x86/libchipmunk.so ../libs/x86/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/font* ../assets
cp ../../../../bin/data/CalibriBold50pt* ../assets
cp ../../../../bin/data/arrow.png ../assets
cp ../../../../bin/data/Rus.txt ../assets
