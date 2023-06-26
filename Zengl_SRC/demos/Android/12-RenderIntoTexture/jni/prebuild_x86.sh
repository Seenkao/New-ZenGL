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
cp ../../../../bin/data/tux_stand.png ../assets
cp ../../../../bin/data/font* ../assets
