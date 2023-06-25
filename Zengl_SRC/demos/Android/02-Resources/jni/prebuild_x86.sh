# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/x86/
cp ../../../../bin/Android/x86/libzenjpeg.so ../libs/x86/
cp ../../../../bin/Android/x86/libopenal.so ../libs/x86/
cp ../../../../bin/Android/x86/libogg.so ../libs/x86/
cp ../../../../bin/Android/x86/libvorbis.so ../libs/x86/
cp ../../../../bin/Android/x86/libtheoradec.so ../libs/x86/
cp ../../../../bin/Android/x86/libzip.so ../libs/x86/
#cp ../../../../bin/Android/x86/libchipmunk.so ../libs/x86/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/font* ../assets
cp ../../../../bin/data/zengl.png ../assets
cp ../../../../bin/data/click.wav ../assets
cp ../../../../bin/data/back01.jpg ../assets
