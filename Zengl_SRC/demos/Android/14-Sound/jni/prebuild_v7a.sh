# clean
rm -r ../libs
# copy libraries
mkdir ../libs
mkdir ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libzenjpeg.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libopenal.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libogg.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libvorbis.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libtheoradec.so ../libs/armeabi-v7a/
cp ../../../../bin/Android/armeabi-v7a/libzip.so ../libs/armeabi-v7a/
#cp ../../../../bin/Android/armeabi-v7a/libchipmunk.so ../libs/armeabi-v7a/
# copy resources
mkdir ../assets/
cp ../../../../bin/data/click.wav ../assets
cp ../../../../bin/data/music.ogg ../assets
cp ../../../../bin/data/audio-stop.png ../assets
cp ../../../../bin/data/audio-play.png ../assets
cp ../../../../bin/data/font* ../assets
