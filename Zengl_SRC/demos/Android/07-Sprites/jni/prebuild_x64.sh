# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libjpeg_turbo.so ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libopenal.so ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libogg.so ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libvorbis.so ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libtheoradec.so ../libs/x86_64/
cp ../../../../bin/Android/x86_64/libzip.so ../libs/x86_64/
#cp ../../../../bin/Android/x86_64/libchipmunk.so ../libs/x86_64/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/zengl.png ../assets
cp ../../../../bin/data/back01.jpg ../assets
cp ../../../../bin/data/ground.png ../assets
cp ../../../../bin/data/tux_walking.png ../assets
cp ../../../../bin/data/tux_stand.png ../assets
cp ../../../../bin/data/font* ../assets
