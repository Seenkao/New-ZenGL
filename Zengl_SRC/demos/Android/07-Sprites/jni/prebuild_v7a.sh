# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libjpeg_turbo.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libopenal.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libogg.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libvorbis.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libtheoradec.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libzip.so ../libs/armeabi-v7a/
#cp ../../../../bin/Android/armeabi-v7a/libchipmunk.so ../libs/armeabi-v7a/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/zengl.png ../assets
cp ../../../../bin/data/back01.jpg ../assets
cp ../../../../bin/data/ground.png ../assets
cp ../../../../bin/data/tux_walking.png ../assets
cp ../../../../bin/data/tux_stand.png ../assets
cp ../../../../bin/data/font* ../assets